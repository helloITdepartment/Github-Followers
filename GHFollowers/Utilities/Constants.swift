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
