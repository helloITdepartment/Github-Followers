//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 5/28/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        view.backgroundColor = .systemBackground
        title = username
        
        NetworkManager.shared.getUser(for: username) { [weak self] (result) in
            guard let self = self else {
                return
            }

            switch result {
                
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "😬 Something went wrong", message: error.rawValue, buttonTitle: "Got it")
            }
        }
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
