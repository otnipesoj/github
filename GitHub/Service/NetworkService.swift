//
//  NetworkService.swift
//  GitHub
//
//  Created by Jose Pinto on 08/12/2021.
//

import UIKit

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = path
        if (!queryItems.isEmpty) { urlComponents.queryItems = queryItems }
        
        return urlComponents.url
    }
}

class NetworkService {
    static let shared = NetworkService()
    private let baseURL = "https://api.github.com/"
    let pageSize = 50
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func searchUsers(by query: String?, page: Int) async throws -> [User] {
        var queryItems: [URLQueryItem] = [URLQueryItem(name: "per_page", value: String(pageSize)), URLQueryItem(name: "page", value: String(page))]
        
        if let query = query, !query.isEmpty {
            queryItems.append(URLQueryItem(name: "q", value: query))
        }
        
        let endpoint = Endpoint(path: "/search/users", queryItems: queryItems)
        
        guard let url = endpoint.url else {
            throw GHError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw GHError.invalidResponse
        }
        
        guard response.statusCode == 200 else {
            switch response.statusCode {
            case 403:
                throw GHError.rateLimitExceeded
            default:
                throw GHError.invalidResponse
            }
        }
        
        do {
            let result = try decoder.decode(SearchUsersResult.self, from: data)
            return result.items
        } catch {
            throw GHError.invalidData
        }
    }
    
    func getUserInfo(for username: String) async throws -> User {
        let endpoint = Endpoint(path: "/users/\(username)")
        
        guard let url = endpoint.url else {
            throw GHError.invalidUsername
        }
        
        print(url)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
    func downloadImage(from url: String) async -> UIImage? {
        let cacheKey = NSString(string: url)
        
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: url) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
