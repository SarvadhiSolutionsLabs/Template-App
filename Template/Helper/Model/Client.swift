//
//  Client.swift
//  Template
//
//  Created by Avadh on 20/07/22.
//

import Foundation
import ObjectMapper

struct Client: Decodable, Mappable {
    
    var id: Int?
    var client_name: String?
    var client_user_id: String?
    var client_email: String?
    var client_access_code: String?
    var business_active: Bool?
    var is_subscribed: Bool?
    var business_id: Int?
    var deleted_by: String?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        id <- map["id"]
        client_name <- map["client_name"]
        client_user_id <- map["client_user_id"]
        client_email <- map["client_email"]
        client_access_code <- map["client_access_code"]
        business_active <- map["business_active"]
        is_subscribed <- map["is_subscribed"]
        business_id <- map["business_id"]
        deleted_by <- map["deleted_by"]
    }
}
