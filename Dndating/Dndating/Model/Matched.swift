//
//  Matched.swift
//  Dndating
//
//  Created by Sky Xu on 12/10/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation

struct Matched: Codable {
    let match: [UserData]
}
struct UserData: Codable {
    let userData: UserObj
}
struct UserObj: Codable {
    let user: String
    let percentage: String
    let img: String
}
