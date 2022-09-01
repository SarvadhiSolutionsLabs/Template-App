//
//  User.swift
//  Template
//
//  Created by Avadh on 12/05/22.
//

import Foundation
import ObjectMapper

struct ErrorResult: Decodable, Mappable {
    
    var error_code: String?
    var error_message: String?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        error_code <- map["error_code"]
        error_message <- map["error_message"]
    }
}

struct SuccessResult: Decodable, Mappable {
    
    var message: String?
    var token: String?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        message <- map["message"]
        token <- map["token"]
    }
}

struct User: Decodable, Mappable {
    
    var id: Int?
    var user_name: String?
    var user_email: String?
    var user_password: String?
    var user_type: Int?
    var user_profile: String?
    var message: String?
    var access_code: String?
    var user_id: String?
    var user_token: String?
    var error_code: String?
    var error_message: String?
    var otp: String?
    var is_business_admin: Bool?
    var business_id: Int?
    var client_id: String?
    var is_ban: Bool?
    var token: String?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        id <- map["id"]
        user_name <- map["user_name"]
        user_email <- map["user_email"]
        user_password <- map["user_password"]
        user_type <- map["user_type"]
        user_profile <- map["user_profile"]
        message <- map["message"]
        access_code <- map["access_code"]
        user_id <- map["user_id"]
        user_token <- map["user_token"]
        error_code <- map["error_code"]
        error_message <- map["error_message"]
        otp <- map["otp"]
        is_business_admin <- map["is_business_admin"]
        business_id <- map["business_id"]
        client_id <- map["client_id"]
        is_ban <- map["is_ban"]
        token <- map["token"]
    }
}

extension Decodable {
    var asDictionary: [String: Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label: String?, value: Any) -> (String, Any)? in
            guard let label = label else { return nil }
            return (label, value)
        }).compactMap { $0 })
        return dict
    }
}
