//
//  StorageManager.swift
//  Template
//
//  Created by Avadh on 20/05/22.
//

import Foundation
import ObjectMapper

struct StorageManager {
    
    static let shared = StorageManager()
    private init() { }
    
    // MARK: - Keys to Store, Retrieve, Remove Data from  UserDefaults
    private static let userIsLogin = AppKeys.kIsLogIn
    private static let userJson = AppKeys.kUserJson
    private static let userToken = AppKeys.kUserToken
    private static let secondTime = AppKeys.kSecondTime
    private static let systemUnit = AppKeys.kSystemUnit

    public static func clearData() {
        UserDefaults.standard.set(nil, forKey: StorageManager.userIsLogin)
        UserDefaults.standard.set(nil, forKey: StorageManager.userJson)
        UserDefaults.standard.set(nil, forKey: StorageManager.userToken)
        UserDefaults.standard.set(nil, forKey: StorageManager.systemUnit)
        UserDefaults.standard.synchronize()
        NotificationManager.shared.removeAllNotifications()
    }
}

// MARK: - Store UserData in Userdefaults
extension StorageManager {
    public static func storeLogin(_ isLogin: Bool) {
        UserDefaults.standard.set(isLogin, forKey: StorageManager.userIsLogin)
        UserDefaults.standard.synchronize()
    }
    
    public static func storeToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: StorageManager.userToken)
        UserDefaults.standard.synchronize()
    }
    
    public static func storeSecondTime(_ isSecondTime: Bool) {
        UserDefaults.standard.set(isSecondTime, forKey: StorageManager.secondTime)
        UserDefaults.standard.synchronize()
    }
    
    public static func storeUserDetails(_ user: [String: Any]?) {
        UserDefaults.standard.set(user, forKey: StorageManager.userJson)
        UserDefaults.standard.synchronize()
    }
    
    public static func storeSystemUnit(_ unit: String) {
        UserDefaults.standard.set(unit, forKey: StorageManager.systemUnit)
        UserDefaults.standard.synchronize()
    }
}

// MARK: - Retrive UserData from Userdefaults

extension StorageManager {
    
    public static var isLogin: Bool {
        let isLogin = UserDefaults.standard.bool(forKey: StorageManager.userIsLogin)
        return isLogin
    }
    
    public static var isSecondTime: Bool {
        let isSecondTime = UserDefaults.standard.bool(forKey: StorageManager.secondTime)
        return isSecondTime
    }

    public static var loginToken: String {
        let token = UserDefaults.standard.string(forKey: StorageManager.userToken) ?? ""
        return token
    }
    
    public static var selectedSystemUnit: String {
        let token = UserDefaults.standard.string(forKey: StorageManager.systemUnit) ?? "Imperial"
        return token
    }
    
    public static var userDetails: User? {
        let userJson = UserDefaults.standard.value(forKey: StorageManager.userJson) as? [String: Any]
        let userDetails = ObjectMapper.Mapper<User>().map(JSON: userJson ?? [:])
        return userDetails
    }
    
}
