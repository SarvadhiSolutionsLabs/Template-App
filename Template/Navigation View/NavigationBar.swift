//
//  NavigationBar.swift
//  Template
//
//  Created by Avadh on 26/05/22.
//

import UIKit

class NavigationBar: UIView {
    
    @IBOutlet var buttonStack: UIStackView!
    @IBOutlet var lblTitle: UILabel!
    
    var title: String = "" {
        didSet {
            lblTitle.text = title
        }
    }
    var buttons = [UIButton]() {
        didSet {
            for button in buttons {
                buttonStack.addArrangedSubview(button)
            }
        }
    }
}
