//
//  BoxStatues.swift
//  Template
//
//  Created by Avadh on 04/07/22.
//

import Foundation
import ObjectMapper

struct BoxStatus: Decodable, Mappable {
    
    var id: Int?
    var status_name: String?
    var user_id: String?
    var is_default: Bool?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        id <- map["id"]
        status_name <- map["status_name"]
        user_id <- map["user_id"]
        is_default <- map["is_default"]
    }
}
