//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 8/3/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID = "FavoriteCell"
    let padding: CGFloat = 12

    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        accessoryType = .disclosureIndicator
        
        configureAvatarImageView()
        configureUsernameLabel()
    }
    
    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        avatarImageView.setImage(fromUrl: favorite.avatarUrl)
    }
    
    private func configureAvatarImageView() {
        addSubview(avatarImageView)
           
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
       
    private func configureUsernameLabel() {
        addSubview(usernameLabel)

        NSLayoutConstraint.activate([
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
