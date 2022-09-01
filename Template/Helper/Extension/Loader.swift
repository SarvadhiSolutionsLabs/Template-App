//
//  Loader.swift
//  Template
//
//  Created by Avadh on 04/08/22.
//

import Foundation
import KRProgressHUD

struct Loader {
    
    static let shared = Loader()
    
    func show() {
        KRProgressHUD.set(activityIndicatorViewColors: [Asset.mainTextColor.color])
        KRProgressHUD.set(maskType: .black)
        KRProgressHUD.show()
    }
    
    func dismiss() {
        KRProgressHUD.dismiss()
    }
}
