//
//  Business.swift
//  Template
//
//  Created by Avadh on 24/08/22.
//

import Foundation
import ObjectMapper

struct Business: Decodable, Mappable {
    
    var id: Int?
    var business_name: String?
    var business_logo: String?
    var business_desc: String?
    var user_id: String?
    var business_email: String?
    var business_address: String?
    var business_phone: Int?
    var business_photos: String?
    var is_active: Bool?
    var created_by: String?
    var is_ban: Bool?
    var zip_code: String?
    var category_id: Int?
    var business_city: String?
    var business_country: String?
    var is_promoted: Bool?
    var createdAt: String?
    var updatedAt: String?
    var deletedAt: String?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        id <- map["id"]
        business_name <- map["business_name"]
        business_logo <- map["business_logo"]
        business_desc <- map["business_desc"]
        user_id <- map["user_id"]
        business_email <- map["business_email"]
        business_address <- map["business_address"]
        business_phone <- map["business_phone"]
        business_photos <- map["business_photos"]
        is_active <- map["is_active"]
        created_by <- map["created_by"]
        is_ban <- map["is_ban"]
        zip_code <- map["zip_code"]
        category_id <- map["category_id"]
        business_city <- map["business_city"]
        business_country <- map["business_country"]
        is_promoted <- map["is_promoted"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        deletedAt <- map["deletedAt"]
    }
}
