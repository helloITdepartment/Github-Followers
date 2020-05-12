//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 4/10/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
        //TODO:- change "main" to "mutual" and "nonmutual" to experiment with multiple sections
    }
    
    var username: String!
    var followers: [Follower] = []
    var hasMoreFollowers = true
    var page = 1
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    //MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDiffableDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    //MARK:- Configuration functions
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createNColumnFlowLayout(withNumberOfColumns: Constants.columnsInFollowerListCV)) //TODO:- if there's a settings page, let the user decide how many columns (within a certain range (1-5?)) and also change the number of followers loaded per page based on the same value
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
    }
    
    private func configureDiffableDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    private func getFollowers(username: String, page: Int) {
        
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in //this makes it so that the reference to `self` in this closure doesn't increase self's reference count. Why that's something we're concerned about in this particular case it something I'm still working on understanding
            
            //This created a new variable called self, and tries to set it to an unwrapped version of the weak one we made int he capture list. If it was nil, the program will bail out, but if not, the rest of the program will have a non-optional version to use
            guard let self = self else {
                return
            }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                
                self.hasMoreFollowers = !(followers.count < Constants.followersToPull)
                self.followers += followers
                print(followers)
                self.updateCollectionView(animated: true)
                
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
        let itemWidth = availableWidth / CGFloat(n)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
        
    }
    
    func updateCollectionView(animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let distanceScrolled = scrollView.contentOffset.y
        let totalScrollviewHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if hasMoreFollowers && distanceScrolled >= totalScrollviewHeight - screenHeight {
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}
