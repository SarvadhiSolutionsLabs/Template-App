//
//  UITextField+kit.swift
//  Template
//
//  Created by Avadh on 11/07/22.
//

import Foundation
import UIKit

extension CustomTextField {
    func datePicker<T>(target: T,
                       doneAction: Selector,
                       cancelAction: Selector,
                       datePickerMode: UIDatePicker.Mode = .date,
                       index: Int = 0,
                       selectedDate: Date = Date()) {
        let screenWidth = screenSize.width
        self.tintColor = .clear
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : target
            let action: Selector? = {
                switch style {
                case .cancel:
                    return cancelAction
                case .done:
                    return doneAction
                default:
                    return nil
                }
            }()
            
            let barButtonItem = CustomBarButtonItem(barButtonSystemItem: style,
                                                target: buttonTarget,
                                                action: action)
            barButtonItem.tintColor = Asset.mainTextColor.color
            barButtonItem.tag = self.tag
            barButtonItem.indexTag = index
            return barButtonItem
        }
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWidth,
                                                    height: 216))
        datePicker.locale = Locale.init(identifier: "en_gb")
        datePicker.date = selectedDate
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = datePickerMode
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screenWidth,
                                              height: 44))
        toolBar.setItems([buttonItem(withSystemItemStyle: .cancel),
                          buttonItem(withSystemItemStyle: .flexibleSpace),
                          buttonItem(withSystemItemStyle: .done)],
                         animated: true)
        self.inputAccessoryView = toolBar
    }
}
