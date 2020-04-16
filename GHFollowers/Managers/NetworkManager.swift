//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 4/16/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    //We make the init private so that no one outside of this class can make a NetworkManager, ensuring that the only one that will ever exist is the `shared` one we just created
    private init() {}
}
