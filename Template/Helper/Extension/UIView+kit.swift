//
//  UIView+kit.swift
//  Template
//
//  Created by Avadh on 05/07/22.
//

import Foundation
import UIKit

extension UIView {
    func addTapGesture(action : @escaping () -> Void) {
        let tap = MyTapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }

    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
        sender.action!()
    }
    
    var asImage: UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    func setlayoutView() {
        self.layoutIfNeeded()
        self.setNeedsLayout()
        self.setNeedsDisplay()
    }
}

class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action: (() -> Void)?
}
