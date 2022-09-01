//
//  UISegmentedControl+kit.swift
//  Template
//
//  Created by Avadh on 05/07/22.
//

import Foundation
import UIKit

extension UISegmentedControl {
    func selectedSegmentTitleTintColor(_ color: UIColor) {
        self.setTitleTextAttributes([.foregroundColor: color, .font: UIFont.mySystemFont(ofSize: 12, weight: .medium)], for: .selected)
    }
    func segmentTitleTintColor(_ color: UIColor) {
        self.setTitleTextAttributes([.foregroundColor: color, .font: UIFont.mySystemFont(ofSize: 12, weight: .medium)], for: .normal)
    }
    func segmentBackGroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }
    
    func setDefaultStyle() {
        self.segmentBackGroundColor(Asset.formColor.color)
        self.segmentTitleTintColor(Asset.secondaryTextColor.color)
        self.selectedSegmentTitleTintColor(Asset.primaryColor.color)
        self.layer.cornerRadius = 10
    }
}
