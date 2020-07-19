//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 5/28/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {

    let headerView = UIView() //This is the view that the UserInfoHeaderVC's view will live inside of
    let githubInfoView = UIView()
    let followersInfoView = UIView()
    let userSinceLabel = GFBodyLabel(textAlignment: .center)
    
    let layoutPadding: CGFloat = 20
    let infoItemHeight: CGFloat = 140
    
    var username: String!
    
    weak var delegate: FollowerListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        view.backgroundColor = .systemBackground
        title = username
        
        downloadUser()
        
        configureHeaderView()
        configureGithubInfoView()
        configureFollowerInfoView()
        configureUserSinceLabel()
    }
    
    func downloadUser() {
        
        NetworkManager.shared.getUser(for: username) { [weak self] (result) in
            guard let self = self else {
                return
            }
            
            switch result {
                
            case .success(let user):
                DispatchQueue.main.async {
                    self.initializeUIElements(for: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "😬 Something went wrong", message: error.rawValue, buttonTitle: "Got it")
            }
        }
        
    }
    
    private func initializeUIElements(for user: User) {
        
        self.connect(viewController: GFUserInfoHeaderVC(for: user), to: self.headerView)
        
        let repoItemVC = GFRepoItemVC(for: user)
        repoItemVC.delegate = self
        self.connect(viewController: repoItemVC, to: self.githubInfoView)
        
        let followerItemVC = GFFollowerItemVC(for: user)
        followerItemVC.delegate = self
        self.connect(viewController: followerItemVC, to: self.followersInfoView)
        
        self.userSinceLabel.text = "On Github since \(user.createdAt.convertToDisplayFormat())"
    }
    
    private func configureHeaderView() {
        view.addSubview(headerView)
                
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: layoutPadding),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layoutPadding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -layoutPadding),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func configureGithubInfoView() {
        view.addSubview(githubInfoView)
        
        githubInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            githubInfoView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: layoutPadding),
            githubInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layoutPadding),
            githubInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -layoutPadding),
            githubInfoView.heightAnchor.constraint(equalToConstant: infoItemHeight)
        ])
        
    }
    
    private func configureFollowerInfoView() {
        view.addSubview(followersInfoView)
        
        followersInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            followersInfoView.topAnchor.constraint(equalTo: githubInfoView.bottomAnchor, constant: layoutPadding),
            followersInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layoutPadding),
            followersInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -layoutPadding),
            followersInfoView.heightAnchor.constraint(equalToConstant: infoItemHeight)
        ])
        
    }
    
    private func configureUserSinceLabel() {
        view.addSubview(userSinceLabel)
        
        NSLayoutConstraint.activate([
            userSinceLabel.topAnchor.constraint(equalTo: followersInfoView.bottomAnchor, constant: layoutPadding),
            userSinceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layoutPadding),
            userSinceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -layoutPadding),
            userSinceLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func connect(viewController: UIViewController, to view: UIView) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        
        viewController.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}

extension UserInfoVC: UserInfoVCDelegate {
    
    func didTapGithubProfile(for user: User) {
        
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "Looks like the URL for this user is invalid 😬. Send a screenshot and whatever info you can to our dev team.", buttonTitle: "Got it")
            return
        }
        
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        delegate.didRequestFollowers(for: user.login)
    }
    
}
