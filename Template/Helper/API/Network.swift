//
//  Network.swift
//  Template
//
//  Created by Avadh on 12/05/22.
//

import Foundation
import Alamofire
import ObjectMapper

private let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate

extension URLRequestConvertible {
    
    func request<T: BaseMappable, P: BaseMappable>(
        decodeType type: T.Type,
        errorType error: P.Type,
        showLoader loader: Bool = true,
        success successCallback: @escaping (_ message: String, _ response: T?) -> Void,
        error errorCallback: @escaping (_ statusCode: Int, _ message: String, _ response: P?) -> Void,
        failure failureCallback: @escaping (_ error: Error?) -> Void,
        completion completionCallback: @escaping () -> Void) where T: Decodable, P: Decodable {
            if loader {
                Loader.shared.show()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                AF.request(self).responseDecodable { (response: DataResponse<T, AFError>) in
                    var responseJSON = [String: Any]()
                    if let data = response.data {
                        responseJSON = data.getJson()
                    }
                    
                    var responseString: String?
                    if responseJSON.isEmpty {
                        responseString = response.data?.getString()
                    } else {
                        if responseJSON["data"] != nil {
                            responseString = responseJSON["data"] as? String ?? ""
                        }
                    }
                    
                    var json = [String: Any]()
                    if let responseString = responseString {
                        let data = try? (responseString.aesDecrypt())
                        if data == "" {
                            json = [:]
                        } else {
                            json = (data ?? "").stringToDict() as? [String: Any] ?? [:]
                        }
                    } else {
                        if responseJSON["data1"] != nil {
                            json = responseJSON["data1"] as? [String: Any] ?? [:]
                        } else {
                            json = responseJSON
                        }
                    }
                    Loader.shared.dismiss()
                    completionCallback()
                    switch response.response?.statusCode {
                    case 401:
                        StorageManager.clearData()
                        delegate?.loadRootViewController()
                        delegate?.window?.rootViewController?.toast(message: "Unauthorized!!!")
                        return
                    case 200, 201:
                        var message = ""
                        if let msg = json["message"] as? String {
                            message = msg
                        }
                        switch response.result {
                        case .success:
                            let result = ObjectMapper.Mapper<T>().map(JSON: json)
                            successCallback(message, result)
                        case .failure((let error)):
                            failureCallback(error)
                        }
                    case 204, 206, 400, 402, 404, 406, 409, 412, 422, 403:
                        let result = ObjectMapper.Mapper<P>().map(JSON: json)
                        var message = responseJSON["error_message"] as? String ?? ""
                        if message == "" {
                            message = "Method not found!".localized()
                        }
                        switch response.result {
                        case .success:
                            errorCallback(response.response?.statusCode ?? 400, message, result)
                        case .failure((let error)):
                            failureCallback(error)
                        }
                    default:
                        break
                    }
                }
            })
            
//            AF.request(self).responseDecodable(of: T.self) { (response: AFDataResponse<T>) in
//                completionCallback()
//                switch response.response?.statusCode {
//                case 401, 403:
//                    return
//                case 200:
//                    let message = responseJSON?["message"] as? String ?? ""
//                    switch response.result {
//                    case .success(let result):
//                        successCallback("", result)
//                        break
//                    case .failure((let error)):
//                        failureCallback(error)
//                    }
//                case 204,402,404,412,206,422,400,406:
//                    let result = try? response.result.get()
//                    errorCallback(response.response?.statusCode ?? 400, result.message, result!)
//                    break
//                default:
//                    break
//                }
//            }
        }
    
    func request<T: BaseMappable, P: BaseMappable>(
        decodeType type: [T].Type,
        errorType error: P.Type,
        showLoader loader: Bool = true,
        success successCallback: @escaping (_ message: String, _ response: [T]?) -> Void,
        error errorCallback: @escaping (_ statusCode: Int, _ message: String, _ response: P?) -> Void,
        failure failureCallback: @escaping (_ error: Error?) -> Void,
        completion completionCallback: @escaping () -> Void) where T: Decodable, P: Decodable {
            if loader {
                Loader.shared.show()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                AF.request(self).responseDecodable { (response: DataResponse<T, AFError>) in
                    var responseJSON = [String: Any]()
                    if let data = response.data {
                        responseJSON = data.getJson()
                    }
                    
                    var responseString: String?
                    if responseJSON.isEmpty {
                        responseString = response.data?.getString()
                    } else {
                        if responseJSON["data"] != nil {
                            responseString = responseJSON["data"] as? String ?? ""
                        }
                    }
                    
                    var json = [[String: Any]]()
                    if let responseString = responseString {
                        let data = try? (responseString.aesDecrypt())
                        if data == "" {
                            json = [[:]]
                        } else {
                            json = (data ?? "").stringToArray()
                        }
                    } else {
                        if responseJSON["data1"] != nil {
                            json = responseJSON["data1"] as? [[String: Any]] ?? [[:]]
                        } else {
                            json = [responseJSON]
                        }
                    }
                    Loader.shared.dismiss()
                    completionCallback()
                    switch response.response?.statusCode {
                    case 401:
                        StorageManager.clearData()
                        delegate?.loadRootViewController()
                        delegate?.window?.rootViewController?.toast(message: "Unauthorized!!!")
                    case 200, 201:
                        var message = ""
                        if json.count != 0 {
                            if let msg = json[0]["message"] as? String {
                                message = msg
                            }
                        }
                        switch response.result {
                        case .success:
                            let result = ObjectMapper.Mapper<T>().mapArray(JSONObject: json)
                            successCallback(message, result)
                        case .failure((let error)):
                            failureCallback(error)
                        }
                    case 204, 206, 400, 402, 404, 406, 409, 412, 422, 403:
                        let result = ObjectMapper.Mapper<P>().map(JSON: json[0])
                        var message = responseJSON["error_message"] as? String ?? ""
                        if message == "" {
                            message = "Method not found!".localized()
                        }
                        switch response.result {
                        case .success:
                            errorCallback(response.response?.statusCode ?? 400, message, result)
                        case .failure((let error)):
                            failureCallback(error)
                        }
                    default:
                        break
                    }
                }
            })
        }
}

extension Data {
    
    func getJson() -> [String: Any] {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] ?? [:]
            return json
        } catch { print("erroMsg")
            return [:]
        }
    }
    
    func getString() -> String {
        let str = String(decoding: self, as: UTF8.self)
        return str
    }
}

extension Dictionary {
    
    func dictToString() -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        let tempString = NSString(data: jsonData ?? Data(), encoding: String.Encoding.utf8.rawValue)! as String
        return tempString
    }
    
    func getJsonData() -> Data? {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        return jsonData ?? nil
    }
    
}
