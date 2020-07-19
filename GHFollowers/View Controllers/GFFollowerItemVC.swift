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
    
    override func didTapButton() {
        guard user.followers > 0 else {
            //TODO:- Figure out how to use the GFEmptyStateView instead of the alert. That's what it was created for isn't it?
//            showEmptyStateView(with: "This user doesn't have any followers, maybe go follow them 😊", in: self.view)
            presentGFAlertOnMainThread(title: "No followers :/", message: "This user doesn't have any followers, maybe go follow them 😊", buttonTitle: "Got it!")
            return
        }
        
        delegate.didTapGetFollowers(for: user)
        dismiss(animated: true)
    }
}
