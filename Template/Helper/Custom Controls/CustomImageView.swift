//
//  customImageView.swift
//  Template
//
//
//  Created by Avadh on 09/05/22.
//

import UIKit

// MARK: Custom ImageView Class
// @IBDesignable
class CustomImageView: UIImageView {

    // MARK: Set ImageView cornerRadius
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    // MARK: Set ImageView borderWidth
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    // MARK: Set ImageView borderColor
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
//    @IBInspectable var tintcolor: UIImage? {
//        didSet {
//            self.tintColor = tintcolor?

    // MARK: Set ImageView tag
    var tag1 = 0

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
        }
