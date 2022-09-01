//
//  BusinessCategory.swift
//  Template
//
//  Created by Avadh on 17/08/22.
//

import Foundation
import ObjectMapper

struct BusinessCategory: Decodable, Mappable {
    
    var id: Int?
    var category_name: String?
    var category_icon: String?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        id <- map["id"]
        category_name <- map["category_name"]
        category_icon <- map["category_icon"]
    }
}
