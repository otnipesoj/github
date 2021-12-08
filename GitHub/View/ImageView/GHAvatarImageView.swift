//
//  GHAvatarImageView.swift
//  GitHub
//
//  Created by Jose Pinto on 08/12/2021.
//

import UIKit

class GHAvatarImageView: UIImageView {
    
    let cache = NetworkService.shared.cache
    let placeholderImage = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from url: String) {
        Task { image = await NetworkService.shared.downloadImage(from: url) ?? placeholderImage }
    }
}
