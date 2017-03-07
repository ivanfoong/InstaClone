//
//  User.swift
//  InstaClone
//
//  Created by Ivan Foong on 3/7/17.
//  Copyright © 2017 Ivan Foong. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var userId: Int64?
    var username: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        userId <- map["id"]
        username <- map["username"]
    }
}
