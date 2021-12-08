//
//  GFItemInfoGroupView.swift
//  GitHub
//
//  Created by Jose Pinto on 08/12/2021.
//

import UIKit

class GHItemInfoGroupView : UIView {
    
    let stackView = UIStackView()
    let itemInfoViewOne = GHItemInfoView()
    let itemInfoViewTwo = GHItemInfoView()
    
    var user: User!
    
    init(user: User) {
        super.init(frame: .zero)
        self.user = user
        configureBackgroundView()
        layoutUI()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackgroundView() {
        layer.cornerRadius = 18
        backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func layoutUI() {
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
