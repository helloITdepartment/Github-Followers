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
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
