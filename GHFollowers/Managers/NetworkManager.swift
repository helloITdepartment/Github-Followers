//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 4/16/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURLString = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    //We make the init private so that no one outside of this class can make a NetworkManager, ensuring that the only one that will ever exist is the `shared` one we just created
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        
        let endpointString = baseURLString + "\(username)/followers?per_page=99&page=\(page)" //went with 99 followers per page since the followerListVC will have them in rows of 3, and this way you won't occasionally have an extra one dangling at the bottom by himself
        
        guard let url = URL(string: endpointString) else {
            completed(.failure(.invalidUsername))
//            completed(nil, "The username produced an invalid URL. Please try again later.")
            return
        }
        
//        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //if the error does not come back nil
            if let _ = error {
                completed(.failure(.unableToComplete))
//                completed(nil, "Unable to handle your request. Please check your internet connection.")
            }
            
            guard let response = response as? HTTPURLResponse else{
                //TODO:- check for, and handle, specific error codes
                completed(.failure(.invalidResponse))
//                completed(nil, "Invalid response from the server. Please try again.")
                return
            }
            
            if response.statusCode != 200 {
                print(response.statusCode)
                if(response.statusCode == 404) {
                    completed(.failure(.fourOhFour))
//                    completed(nil, "A 404 error was returned, which usually means that the user does not exists.")
                    return
                }
                completed(.failure(.invalidResponse))
//                completed(nil, "Invalid response from the server. Please try again.")
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
//                completed(nil, "The data returned from the server was invalid. Please try again")
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
//                completed(followers, nil)
            } catch {
                completed(.failure(.invalidData))
//                completed(nil, "The data returned from the server was invalid. Please try again")
            }
        }
        
        task.resume()
    }
}
