//
//  Comment.swift
//  InstaClone
//
//  Created by Ivan Foong on 3/7/17.
//  Copyright © 2017 Ivan Foong. All rights reserved.
//

import Foundation
import ObjectMapper

class Comment: Mappable {
    var commentId: Int64?
    var user: User?
    var comment: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        commentId <- map["id"]
        user <- map["user"]
        comment <- map["comment"]
    }
}
