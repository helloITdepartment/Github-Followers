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
    
    var isUsernameEntered: Bool {
        !usernameTextField.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground //light on light mode, dark on dark
        
        setupLogoImageView()
        setupUsernameTextField()
        setupSearchButton()
        createKeyboardDismissTapGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true //done in viewWillAppear as opposed to viewDidLoad because the latter will only be called once, and this will be called every time the view shows back up on screen
    }
    
    @objc func pushFollowerListVC() {
        
        guard isUsernameEntered else {
            print("No usernamae entered") //TODO:- handle this error
            
            let ac = UIAlertController(title: "No username entered", message: "We're gunna need a username to we know whose followers to get 😉", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                self.dismiss(animated: true)
            }))
            present(ac, animated: true)
            
            return
        }
        
        let followerListVC = FollowerListVC()
        followerListVC.username = usernameTextField.text
        followerListVC.title = usernameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    //MARK:- UI
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
        
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupSearchButton() {
        view.addSubview(searchButton)
        
        searchButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createKeyboardDismissTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
    }
}

//MARK:- Extensions
extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
