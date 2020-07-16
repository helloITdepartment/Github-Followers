//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 5/28/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {

    let headerView = UIView() //This is the view that the UserInfoHeaderVC's view will live inside of
    let githubInfoView = UIView()
    let followersInfoView = UIView()
    
    let layoutPadding: CGFloat = 20
    let infoItemHeight: CGFloat = 140
    
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        view.backgroundColor = .systemBackground
        title = username
        
        githubInfoView.backgroundColor = .systemPink
        followersInfoView.backgroundColor = .systemTeal
        
        downloadUser()
        
        configureHeaderView()
        configureGithubInfoView()
        configureFollowerInfoView()
    }
    
    func downloadUser() {
        
        NetworkManager.shared.getUser(for: username) { [weak self] (result) in
            guard let self = self else {
                return
            }
            
            switch result {
                
            case .success(let user):
                DispatchQueue.main.async {
                    self.connect(viewController: GFUserInfoHeaderVC(for: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "😬 Something went wrong", message: error.rawValue, buttonTitle: "Got it")
            }
        }
        
    }
    
    func configureHeaderView() {
        view.addSubview(headerView)
                
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: layoutPadding),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layoutPadding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -layoutPadding),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func configureGithubInfoView() {
        view.addSubview(githubInfoView)
        
        githubInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            githubInfoView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: layoutPadding),
            githubInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layoutPadding),
            githubInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -layoutPadding),
            githubInfoView.heightAnchor.constraint(equalToConstant: infoItemHeight)
        ])
        
    }
    
    func configureFollowerInfoView() {
        view.addSubview(followersInfoView)
        
        followersInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            followersInfoView.topAnchor.constraint(equalTo: githubInfoView.bottomAnchor, constant: layoutPadding),
            followersInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layoutPadding),
            followersInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -layoutPadding),
            followersInfoView.heightAnchor.constraint(equalToConstant: infoItemHeight)
        ])
        
    }
    
    func connect(viewController: UIViewController, to view: UIView) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        
        viewController.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
