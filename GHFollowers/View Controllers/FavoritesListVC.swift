//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 4/4/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

class FavoritesListVC: UIViewController {

    let tableView = UITableView()
    var favorites: [Follower]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadFollowers()
    }
    
    func configureViewController() {
        
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    func loadFollowers() {
        
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyStateView(with: "No followers :/\nGo add some in the search screen!", in: self.view)
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Uh oh", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
        
    }

}

extension FavoritesListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
//        cell.backgroundColor = .random()
        return cell
    }
    
}

extension FavoritesListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destination = FollowerListVC()
        destination.username = favorite.login
        destination.title = favorite.login

        //`present` slides the destination VCup modally, `push` slides a new one in on top
        //        navigationController?.present(destination, animated: true)
        navigationController?.pushViewController(destination, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        
        //Remove from underlying array
        favorites.remove(at: indexPath.row)
        
        //Remove from tableView
        tableView.deleteRows(at: [indexPath], with: .left)
        
        //Remove from UserDefaults
        PersistenceManager.updateFavorites(.remove, follower: favorite) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            
            self.presentGFAlertOnMainThread(title: "Uh oh.", message: error.rawValue, buttonTitle: "Ok")
        }
        
        loadFollowers()
    }
}
