//
//  CommentListResponse.swift
//  InstaClone
//
//  Created by Ivan Foong on 3/7/17.
//  Copyright © 2017 Ivan Foong. All rights reserved.
//

import Foundation
import ObjectMapper

class CommentListResponse: Mappable {
    var comments: [Comment]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        comments <- map["comments"]
    }
}
