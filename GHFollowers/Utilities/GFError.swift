//
//  GFError.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 4/21/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "The username produced an invalid URL. Please try again later."
    case unableToComplete = "Unable to handle your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case fourOhFour = "A 404 error was returned, which usually means that the user does not exists."
    case invalidData = "The data returned from the server was invalid. Please try again."
    case unableToRetrieveFavorites = "There was an error retrieving the list of favorites."
    case unableToUpdateFavorites = "There was an error updating the list of favorites. Please try again."
    case userAlreadyFavorited = "This user is already in Favorites."
}

