//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 7/16/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItemInfoViews()
        configureButton()
    }
    
    func configureItemInfoViews() {
        leftItemInfoView.set(itemInfoType: .repos, with: user.publicRepos)
        rightItemInfoView.set(itemInfoType: .gists, with: user.publicGists)
    }
    
    func configureButton() {
        button.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func didTapButton() {
        delegate.didTapGithubProfile(for: user)
    }
}
