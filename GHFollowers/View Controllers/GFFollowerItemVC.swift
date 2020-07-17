//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 7/16/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItemInfoViews()
        configureButton()
    }
    
    func configureItemInfoViews() {
        leftItemInfoView.set(itemInfoType: .followers, with: user.followers)
        rightItemInfoView.set(itemInfoType: .following, with: user.following)
    }
    
    func configureButton() {
        button.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
