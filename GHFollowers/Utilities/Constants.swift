//
//  Constants.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 4/21/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import Foundation

struct Constants {
    static var columnsInFollowerListCV = 3
    static var followersToPull: Int {
        print((100/columnsInFollowerListCV)*columnsInFollowerListCV)
        return (100/columnsInFollowerListCV)*columnsInFollowerListCV
    }
}

enum SFSymbols {
    static let location = "mappin.and.ellipse"
    static let repos = "folder"
    static let gists = "text.alignleft"
    static let followers = "heart"
    static let following = "person.2"
}
