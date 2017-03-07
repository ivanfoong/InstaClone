//
//  Feed.swift
//  InstaClone
//
//  Created by Ivan Foong on 3/7/17.
//  Copyright © 2017 Ivan Foong. All rights reserved.
//

import Foundation
import ObjectMapper

class Feed: Mappable {
    var feedId: Int64?
    var imageUrl: String?
    var user: User?
    var title: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        feedId <- map["id"]
        imageUrl <- map["image_url"]
        user <- map["user"]
        title <- map["title"]
    }
}
