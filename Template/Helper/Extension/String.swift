//
//  String.swift
//  Template
//
//  Created by Avadh on 09/05/22.
//

import Foundation
import UIKit

extension String {
    
    func stringToDict() -> Any? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as Any
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func stringToArray() -> [[String: Any]] {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] ?? [[:]]
            } catch {
                print(error.localizedDescription)
            }
        }
        return [[:]]
    }
    
    func convertProfile(width: CGFloat = 80, height: CGFloat = 80, fontSize: CGFloat = 20) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = Asset.softBlueColor.color
        nameLabel.textColor = Asset.primaryColor.color
        nameLabel.font = UIFont.mySystemFont(ofSize: fontSize, weight: .semibold)
        var initials = ""
        let initialsArray = self.components(separatedBy: " ")
        if let firstWord = initialsArray.first {
            if let firstLetter = firstWord.first {
                initials += String(firstLetter).capitalized }
        }
        if initialsArray.count > 1 {
            let lastWord = initialsArray[1]
            if let lastLetter = lastWord.first {
                initials += String(lastLetter).capitalized
            }
        }
        nameLabel.text = initials
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
    
    func generateQRCode() -> UIImage? {
        let data = self.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
        
    static func random(of n: Int) -> String {
        //        abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890
        let digits = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        return String(Array(0..<n).map { _ in digits.randomElement()! })
    }
    
    func dateTimeConvert(_ formatter: String = "dd MMM yyyy  HH : mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = formatter
        if date != nil {
            return dateFormatter.string(from: date!)
        } else {
            return ""
        }
    }
    
    func dateTimeConvertForAPI(_ inputFormatter: String = "dd MMM yyyy HH:mm", _ outputFormatter: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormatter
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = outputFormatter
        if date != nil {
            return dateFormatter.string(from: date!)
        } else {
            return ""
        }
    }
    
    func toDate(_ formatter: String = "dd MMM yyyy HH:mm") -> Date? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = formatter
        let outputFormatter = DateFormatter()
        let date = dateFormatter.date(from: self) ?? nil
        outputFormatter.dateFormat = "yyyy-MMM-dd HH:mm"
        return outputFormatter.date(from: outputFormatter.string(from: date!)) ?? nil
    }
    
    func sizeForView(font: UIFont, width: CGFloat = 0.0) -> CGSize {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.size
    }

}
