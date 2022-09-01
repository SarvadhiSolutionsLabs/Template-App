//
//  Tips.swift
//  Template
//
//  Created by Avadh on 05/08/22.
//

import Foundation
import ObjectMapper

struct Tips: Decodable, Mappable {
    
    var id: Int?
    var title: String?
    var tip_images: [String]?
    var description: String?
    var business_id: Int?
    var created_by: String?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        tip_images <- map["tip_images"]
        description <- map["description"]
        business_id <- map["business_id"]
        created_by <- map["created_by"]
    }
}
