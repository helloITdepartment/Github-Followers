//
//  GFUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 6/3/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {

    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    let padding: CGFloat = 20
    let imageToTextPadding: CGFloat = 12
    
    init(for user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureAvatarImageView()
        configureUsernameLabel()
        configureNameLabel()
        configureLocationImageView()
        configureLocationLabel()
        configureBioLabel()
        
    }
    
    func configureAvatarImageView(){
        view.addSubview(avatarImageView)
        
        avatarImageView.setImage(fromUrl: user.avatarUrl)
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func configureUsernameLabel(){
        view.addSubview(usernameLabel)
        
        usernameLabel.text = user.login
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: imageToTextPadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38)
        ])

    }
    
    func configureNameLabel(){
        guard let name = user.name else { return }
        
        nameLabel.text = name
        
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: imageToTextPadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

    }
    
    func configureLocationImageView(){
        locationImageView.translatesAutoresizingMaskIntoConstraints = false //Don't need to do this in the other ones because those are all custom and we did this in all their constructors
        
        view.addSubview(locationImageView)
        
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
        
        if let _ = user.name {
            NSLayoutConstraint.activate([
                locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
                locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: imageToTextPadding),
                locationImageView.heightAnchor.constraint(equalToConstant: 20),
                locationImageView.widthAnchor.constraint(equalToConstant: 20)
            ])
        } else {
            //TODO:- figure out where the location stuff should go in the UI and adjust these accordingly
            NSLayoutConstraint.activate([
                locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
                locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: imageToTextPadding),
                locationImageView.heightAnchor.constraint(equalToConstant: 20),
                locationImageView.widthAnchor.constraint(equalToConstant: 20)
            ])
        }

    }
    
    func configureLocationLabel(){
        
        view.addSubview(locationLabel)
        
        locationLabel.text = user.location ?? "N/A"
               
        if let _ = user.name {
            NSLayoutConstraint.activate([
                locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
                locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
                locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                locationLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        } else {
            //TODO:- figure out where the location stuff should go in the UI and adjust these accordingly
            NSLayoutConstraint.activate([
                locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
                locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
                locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                locationLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
    }
    
    func configureBioLabel(){
        view.addSubview(bioLabel)
        
        bioLabel.text = user.bio ?? ""
        bioLabel.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: imageToTextPadding),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}
