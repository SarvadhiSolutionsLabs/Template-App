//
//  Route.swift
//  Template
//
//  Created by Avadh on 12/05/22.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case login(Parameters?)
    case register(Parameters?)
    case forgotPassword(Parameters?)
    case verifyOtp(Parameters?)
    case setPassword(Parameters?)
    case logout(Parameters?)
    case changePassword(Parameters?)
    case deleteUser(Parameters?)
    case getUserSpace(Parameters?)
    case getUnits(Parameters?)
    case createSpace(Parameters?)
    case getBoxStatus(Parameters?)
    case addBoxStatus(Parameters?)
    case deleteBoxStatus(Int?)
    case makeDefaultBoxStatus(Int?)
    case getTask(Parameters?)
    case completeTask(Int?, Parameters?)
    case createTask(Parameters?)
    case updateTask(Int?, Parameters?)
    case deleteTask(Int?)
    case getClient(Parameters?)
    case addClient(Parameters?)
    case getClientSpace(Parameters?)
    case addClientSpace(Parameters?)
    case getDeletedClient(Parameters?)
    case deleteClient(Int?)
    case getPromotion(Parameters?)
    case addPromotion(Parameters?)
    case updatePromotion(Int?, Parameters?)
    case deletePromotion(Int?)
    case getTips(Parameters?)
    case addTips(Parameters?)
    case updateTips(Int?, Parameters?)
    case deleteTips(Int?)
    case getBusinessCategory(Parameters?)
    case getBusinessByCategory(Int?)

    var baseURL: String {
        switch self {
//        case .login:
//            return "http://localhost:3001/api/v1/"
        default:
//            #if DEBUG
//            return "http://192.168.22.112:3001/api/v1/"
//            #else
            return "http://3.225.40.83:8081/api/v1/"
//            #endif
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUserSpace, .getUnits, .getBoxStatus, .getTask, .getClient, .getDeletedClient, .getBusinessCategory, .getBusinessByCategory:
            return .get
        case .changePassword, .makeDefaultBoxStatus, .completeTask, .updateTask, .updatePromotion, .updateTips:
            return .put
        case .deleteBoxStatus, .deleteTask, .deleteUser, .deleteClient, .deletePromotion, .deleteTips:
            return .delete
        default:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login: return "auth/login"
        case .register: return "auth/register"
        case .forgotPassword: return "auth/password/forgot"
        case .verifyOtp: return "auth/password/verify"
        case .setPassword: return "auth/password/reset"
        case .logout: return "auth/logout"
        case .changePassword: return "users/update/password"
        case .deleteUser: return "users"
        case .getUserSpace: return "user_space/self"
        case .getUnits: return "unit/uc"
        case .createSpace: return "user_space/add"
        case .getBoxStatus: return "box_status"
        case .addBoxStatus: return "box_status/add"
        case .deleteBoxStatus(let id):
            return "box_status/\(id ?? 0)"
        case .makeDefaultBoxStatus(let id):
            return "box_status/default/\(id ?? 0)"
        case .getTask: return "task"
        case .completeTask(let id, _):
            return "task/update/\(id ?? 0)"
        case .createTask: return "task/add"
        case .updateTask(let id, _):
            return "task/\(id ?? 0)"
        case .deleteTask(let id):
            return "task/\(id ?? 0)"
        case .getClient: return "client"
        case .addClient: return "client/add"
        case .getClientSpace: return "user_space/all_spaces"
        case .addClientSpace: return "user_space/add/client"
        case .getDeletedClient: return "client/deleted"
        case .deleteClient(let id):
            return "client/\(id ?? 0)"
        case .getPromotion: return "promo"
        case .addPromotion: return "promo/add"
        case .updatePromotion(let id, _):
            return "promo/\(id ?? 0)"
        case .deletePromotion(let id):
            return "promo/\(id ?? 0)"
        case .getTips: return "tricks"
        case .addTips: return "tricks/add"
        case .updateTips(let id, _):
            return "tricks/\(id ?? 0)"
        case .deleteTips(let id):
            return "tricks/\(id ?? 0)"
        case .getBusinessCategory:
            return "business/category"
        case .getBusinessByCategory(let id):
            return "business/categorywise/\(id ?? 0)"
        }
    }
    
    var apiHeader: HTTPHeaders? {
        switch self {
        default:
            if !StorageManager.loginToken.isEmpty {
                return ["x-api-key": StorageManager.loginToken]
            }
        }
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL().appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        if apiHeader != nil {
            request.headers = apiHeader ?? [:]
        }
        
        switch self {
            // for .get - request = try URLEncoding.default.encode(request, with: parameters)
            // for .post - request = try JSONEncoding.default.encode(request, with: parameters)
        case let .login(parameters),
            let .forgotPassword(parameters),
            let .register(parameters),
            let .verifyOtp(parameters),
            let .setPassword(parameters),
            let .logout(parameters),
            let .changePassword(parameters),
            let .createSpace(parameters),
            let .addBoxStatus(parameters),
            let .createTask(parameters),
            let .addClient(parameters),
            let .getClientSpace(parameters),
            let .addClientSpace(parameters),
            let .getPromotion(parameters),
            let .addPromotion(parameters),
            let .getTips(parameters),
            let .addTips(parameters):
            // .post
            request = try JSONEncoding.default.encode(request, with: parameters?.toEncrypt())
        case let .getUserSpace(parameters),
            let .getUnits(parameters),
            let .getBoxStatus(parameters),
            let .completeTask(_, parameters),
            let .updateTask(_, parameters),
            let .updatePromotion(_, parameters),
            let .updateTips(_, parameters):
            // .put, .get
            request = try URLEncoding.default.encode(request, with: parameters?.toEncrypt())
        case .deleteBoxStatus, .makeDefaultBoxStatus, .getTask, .deleteTask, .getClient, .getDeletedClient, .deleteUser, .deleteClient, .deletePromotion, .deleteTips, .getBusinessCategory, .getBusinessByCategory:
            // .get, .delete
            request = try URLEncoding.default.encode(request, with: nil)
            //        case let .register(parameters):
            //            request = try JSONEncoding.default.encode(request, with: parameters?.toEncrypt())
        }
        return request
    }
}

extension Parameters {
    func toEncrypt() -> [String: Any] {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        let tempString = NSString(data: jsonData ?? Data(), encoding: String.Encoding.utf8.rawValue)! as String
        let data = try? tempString.aesEncrypt()
        let dict: [String: Any] = ["data": data ?? ""]
        return dict
    }
}
