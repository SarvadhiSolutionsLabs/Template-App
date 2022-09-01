//
//  Date+kit.swift
//  Template
//
//  Created by Avadh on 08/07/22.
//

import Foundation

extension Date {
    func dateTimeConvert(_ formatter: String = "dd MMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: self)
    }
}
