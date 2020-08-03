//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 4/4/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBlue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        PersistenceManager.retrieveFavorites { result in
            
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        }
    }

}
