//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 4/4/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let searchButton = GFButton(withBackgroundColor: .systemGreen, title: "Find followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground //light on light mode, dark on dark
        
        setupLogoImageView()
        setupUsernameTextField()
        setupSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true //done in viewWillAppear as opposed to viewDidLoad because the latter will only be called once, and this will be called every time the view shows back up on screen
    }
    
    private func setupLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        //Auto-layout needs to know the vertical position, horizontal poisition, height, and width of any view, so more often than not you're gunna use 4 constraints
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupUsernameTextField() {
        view.addSubview(usernameTextField)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupSearchButton() {
        view.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
