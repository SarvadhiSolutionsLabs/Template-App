//
//  Promotions.swift
//  Template
//
//  Created by Avadh on 01/08/22.
//

import Foundation
import ObjectMapper

struct Promotion: Decodable, Mappable {
    
    var id: Int?
    var promo_type: Int?
    var discount_percent: Int?
    var valid_thru: String?
    var terms: String?
    var business_id: Int?
    var created_by: String?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        id <- map["id"]
        promo_type <- map["promo_type"]
        discount_percent <- map["discount_percent"]
        valid_thru <- map["valid_thru"]
        terms <- map["terms"]
        business_id <- map["business_id"]
        created_by <- map["created_by"]
    }
}
