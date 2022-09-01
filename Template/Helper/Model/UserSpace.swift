//
//  UserSpace.swift
//  Template
//
//  Created by Avadh on 29/06/22.
//

import Foundation
import ObjectMapper

struct UserSpace: Decodable, Mappable {
    
    var id: Int?
    var user_id: String?
    var space_id: String?
    var space_name: String?
    var space_length: Int?
    var space_width: Int?
    var space_height: Int?
    var is_alias: Bool?
    var space_alias: String?
    var client_id: String?
    var created_by: String?
    var createdAt: String?
    var updatedAt: String?
    var deletedAt: String?
    var client_user_id: String?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        id <- map["id"]
        user_id <- map["user_id"]
        space_id <- map["space_id"]
        space_name <- map["space_name"]
        space_length <- map["space_length"]
        space_width <- map["space_width"]
        space_height <- map["space_height"]
        is_alias <- map["is_alias"]
        space_alias <- map["space_alias"]
        client_id <- map["client_id"]
        created_by <- map["created_by"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        deletedAt <- map["deletedAt"]
        client_user_id <- map["client_user_id"]
    }
}
