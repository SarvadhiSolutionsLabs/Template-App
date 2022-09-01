//
//  UserTask.swift
//  Template
//
//  Created by Avadh on 06/07/22.
//

import Foundation
import ObjectMapper

struct UserTask: Decodable, Mappable {
    
    var id: Int?
    var task_name: String?
    var task_description: String?
    var user_id: String?
    var client_id: String?
    var client_name: String?
    var is_reminder: Bool?
    var reminder_time: String?
    var is_completed: Bool?
    var created_by: String?
    var client_details: Client?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        id <- map["id"]
        task_name <- map["task_name"]
        task_description <- map["task_description"]
        user_id <- map["user_id"]
        client_id <- map["client_id"]
        is_reminder <- map["is_reminder"]
        reminder_time <- map["reminder_time"]
        is_completed <- map["is_completed"]
        created_by <- map["created_by"]
        client_details <- map["client_details"]
    }
}
