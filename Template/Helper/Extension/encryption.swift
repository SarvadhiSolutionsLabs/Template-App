//
//  encryption.swift
//  Template
//
//  Created by Avadh on 16/05/22.
//

import Foundation
import CryptoSwift
import Gzip

let teriff = "X76gFu0Y1alvMqzVU8yMSBbrofxZ1Dms"
let plan = "xYCVXRxdqAkMQZs5"

extension String {
    func aesEncrypt() throws -> String {
        do {
            let compress = compressData(str: self)
            // Key-32, IV - 16
            let encrypted = try AES(key: teriff, iv: plan, padding: .pkcs7).encrypt([UInt8](compress.data(using: .utf8)!))
            return /*compressData(Str: */Data(encrypted).base64EncodedString()// )
        } catch {
            
        }
        return ""
    }
    
    func aesDecrypt() throws -> String {
        do {
            guard let data = Data(base64Encoded: self) else { return "" }
            let decrypted = try AES(key: teriff, iv: plan, padding: .pkcs7).decrypt([UInt8](data))
            let decompress = decompressData(data: String(bytes: decrypted, encoding: .utf8) ?? self)
            return decompress
        } catch {
            
        }
        return ""
    }
}

func compressData(str: String) -> String {
    let string = str
    let data = string.data(using: .utf8)!
    let optimizedData: Data = try! data.gzipped()
    return randomString() + optimizedData.base64EncodedString()
//    return optimizedData.base64EncodedString()
}

func decompressData(data: String) -> String {
    // gunzip
    let decompressedData: String
    let tempData: Data
    
    guard let _: Data = Data(base64Encoded: data, options: .ignoreUnknownCharacters) else {
        return data
    }
    let data = String(data.dropFirst(16))
//    let data = String(data)
    let compressdata = Data(base64Encoded: data, options: .ignoreUnknownCharacters)!
    if compressdata.isGzipped {
        tempData = try! compressdata.gunzipped()
    } else {
        return data
    }
   
    decompressedData = String(decoding: tempData, as: UTF8.self)
    return decompressedData
}

func randomString() -> String {
    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/abcdefghijklmnopqrstuvwxyz"
    return String((0..<16).map { _ in letters.randomElement()! })
}
