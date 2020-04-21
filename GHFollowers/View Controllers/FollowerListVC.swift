//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 4/10/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            
            switch result {
            case .success(let followers):
                print(followers.count)
                print(followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Uh oh.", message: error.rawValue, buttonTitle: "Got it.")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
