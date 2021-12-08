//
//  GHUserInfoHeaderView.swift
//  GitHub
//
//  Created by Jose Pinto on 08/12/2021.
//

import UIKit

class GHUserInfoHeaderView : UIView {
    
    let avatarImageView = GHAvatarImageView(frame: .zero)
    let usernameLabel = GHTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GHSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let companyImageView = UIImageView()
    let blogImageView = UIImageView()
    let companyLabel = GHSecondaryTitleLabel(fontSize: 18)
    let locationLabel = GHSecondaryTitleLabel(fontSize: 18)
    let blogLabel = GHSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GHBodyLabel(textAlignment: .left)
    
    var user: User!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(user: User) {
        self.init(frame: .zero)
        self.user = user
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, companyImageView, companyLabel, blogImageView, blogLabel, bioLabel)
        layoutUI()
        configureUIElements()
    }
    
    private func configureUIElements() {
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        companyLabel.text = user.company
        locationLabel.text = user.location
        blogLabel.text = user.blog
        bioLabel.text = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3
        
        locationImageView.image = SFSymbols.location
        locationImageView.tintColor = .label
        companyImageView.image = SFSymbols.company
        companyImageView.tintColor = .label
        blogImageView.image = SFSymbols.link
        blogImageView.tintColor = .label
    }
    
    private func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        companyImageView.translatesAutoresizingMaskIntoConstraints = false
        blogImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            locationImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            companyImageView.topAnchor.constraint(equalTo: locationImageView.bottomAnchor, constant: padding),
            companyImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            companyImageView.widthAnchor.constraint(equalToConstant: 20),
            companyImageView.heightAnchor.constraint(equalToConstant: 20),
            
            companyLabel.centerYAnchor.constraint(equalTo: companyImageView.centerYAnchor),
            companyLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 5),
            companyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            companyLabel.heightAnchor.constraint(equalToConstant: 20),
            
            blogImageView.topAnchor.constraint(equalTo: companyImageView.bottomAnchor, constant: padding),
            blogImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blogImageView.widthAnchor.constraint(equalToConstant: 20),
            blogImageView.heightAnchor.constraint(equalToConstant: 20),
            
            blogLabel.centerYAnchor.constraint(equalTo: blogImageView.centerYAnchor),
            blogLabel.leadingAnchor.constraint(equalTo: blogImageView.trailingAnchor, constant: 5),
            blogLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            blogLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: blogImageView.bottomAnchor, constant: padding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
}
