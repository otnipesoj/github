//
//  GHError.swift
//  GitHub
//
//  Created by Jose Pinto on 08/12/2021.
//

import Foundation

enum GHError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server is invalid. Please try again."
}
