//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 7/22/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add
    case remove
}

enum PersistenceManager {
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static private let defaults = UserDefaults.standard
    
    //A function called retrieveFollowers that takes in a parameter called completed. Completed is itself a function, this one one that takes in a Result type and returns nothing. If retrieveFollowers succeeds, it will call the `completed` function, whatever it may be, with an argument of .success, which is of type Result, which `completed` takes in
    //retrieveFollowers doesn't actually return anything
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        
        guard let favoritesObject = defaults.object(forKey: Keys.favorites) else {
            //Ain't nothin there
            completed(.success([]))
            return
        }
        
        guard let favoritesData = favoritesObject as? Data else {
            //Something was in there that definitely wasn't data
            completed(.failure(.unableToRetrieveFavorites))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToRetrieveFavorites))
        }
        
    }
    
    //This will take in an array of followers to save, return an error if something hits the fan while it's trying to save, or send back a nil error if nothing went wrong
    static func saveFavorites(favorites: [Follower]) -> GFError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToUpdateFavorites
        }
    }
    
    static func updateFavorites(with follower: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        
        retrieveFavorites { (result) in
            switch result {
            case .success(let favorites):
                var mutableFavorites = favorites
                
                switch actionType {
                case .add:
                    //First make sure the follower isn't already in there
                    guard !mutableFavorites.contains(follower) else {
                        completed(.userAlreadyFavorited)
                        return
                    }
                    
                    mutableFavorites.append(follower)
                case .remove:
                    mutableFavorites.removeAll { (followerBeingInspected) -> Bool in
                        followerBeingInspected.login == follower.login
                    }
                }
                
                completed(saveFavorites(favorites: mutableFavorites))
                
            case .failure(let error):
                completed(error)
            }
        }
        
    }
}
