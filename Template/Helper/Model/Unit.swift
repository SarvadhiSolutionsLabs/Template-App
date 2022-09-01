//
//  Unit.swift
//  Template
//
//  Created by Avadh on 30/06/22.
//

import Foundation
import ObjectMapper

struct Category: Decodable, Mappable {
    
    var id: Int?
    var category_name: String?
    var units: [Unit]?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        id <- map["id"]
        category_name <- map["category_name"]
        units <- map["units"]
    }
}

struct Unit: Decodable, Mappable {
    
    var id: Int?
    var unit_length: Int?
    var unit_width: Int?
    var unit_height: Int?
    var unit_type: Int?
    var created_by: String?
    var updated_by: String?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        id <- map["id"]
        unit_length <- map["unit_length"]
        unit_width <- map["unit_width"]
        unit_height <- map["unit_height"]
        unit_type <- map["unit_type"]
        created_by <- map["created_by"]
        updated_by <- map["updated_by"]
    }
}
