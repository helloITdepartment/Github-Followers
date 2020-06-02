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
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
