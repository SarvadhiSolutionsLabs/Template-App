//
//  NSMutableAttributedString+kit.swift
//  Template
//
//  Created by Avadh on 12/08/22.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
//      let formattedString = NSMutableAttributedString()
//      formattedString
//           .attribute("Select the division(s) opened for registration for this event.", .regular, Asset.primaryColor.color)
//           .attribute("\n \nNote: Use “Manage Divisions” to add, edit, or remove your overall divisions.")
    @discardableResult func attribute(text: String, fontStyle: UIFont.Weight = .regular, size: CGFloat = 14, color: UIColor = Asset.mainTextColor.color, spacing: Double? = nil, lineHeight: CGFloat? = nil) -> NSMutableAttributedString {
        
        var attrs: [NSAttributedString.Key: Any] = [.font: UIFont.mySystemFont(ofSize: size, weight: fontStyle), .foregroundColor: color]
        if let spacing = spacing {
            attrs = [.font: UIFont.mySystemFont(ofSize: size, weight: fontStyle), .foregroundColor: color, .kern: spacing]
        }
        
        if let lineHeight = lineHeight {
            let style = NSMutableParagraphStyle()
            style.minimumLineHeight = lineHeight
            attrs = [.font: UIFont.mySystemFont(ofSize: size, weight: fontStyle), .foregroundColor: color, .kern: spacing ?? 0.5, .paragraphStyle: style]
        }
        
        let str = NSMutableAttributedString(string: text, attributes: attrs)
        append(str)
        return self
    }
   
}
