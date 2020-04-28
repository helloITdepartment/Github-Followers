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
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createNColumnFlowLayout(withNumberOfColumns: 3)) //TODO:- if there's a settings page, let the user decide how many columns (within a certain range) and also change the number of followers loaded per page based on the same value
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollwerCell.self, forCellWithReuseIdentifier: FollwerCell.reuseID)
        
    }
    
    private func getFollowers() {
        
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
    
    private func createNColumnFlowLayout(withNumberOfColumns n: Int) -> UICollectionViewFlowLayout {
        
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let numberOfItemSpacings: CGFloat = CGFloat(n-1)
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * numberOfItemSpacings)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
        
    }
}
