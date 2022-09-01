//
//  UIButton+kit.swift
//  Template
//
//  Created by Avadh on 17/05/22.
//

import Foundation
import UIKit

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping () -> Void?) {
        @objc class ClosureSleeve: NSObject {
            let closure:() -> Void?
            init(_ closure: @escaping () -> Void?) { self.closure = closure }
            @objc func invoke() { closure() }
        }
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

extension UIButton {
    func alignImageAndTitleVertically(padding: CGFloat = 6.0) {
        let imageSize: CGSize = imageView!.image!.size
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + padding), right: 0.0)
        let labelString = NSString(string: titleLabel!.text!)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: titleLabel!.font ?? UIFont()])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + padding), left: 0.0, bottom: 0.0, right: -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
        
        let height = ((imageSize.height) + (titleSize.height + padding)) + (edgeOffset * 2)
        self.translatesAutoresizingMaskIntoConstraints = true
        self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: self.bounds.size.width, height: height))
        self.setlayoutView()
    }
}
