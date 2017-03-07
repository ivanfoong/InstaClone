//
//  FeedListResponse.swift
//  InstaClone
//
//  Created by Ivan Foong on 3/7/17.
//  Copyright © 2017 Ivan Foong. All rights reserved.
//

import Foundation
import ObjectMapper

class FeedListResponse: Mappable {
    var feeds: [Feed]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        feeds <- map["feeds"]
    }
}
