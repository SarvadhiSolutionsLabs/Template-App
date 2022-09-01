//
//  UISearchBar+kit.swift
//  Template
//
//  Created by Avadh on 24/05/22.
//

import Foundation
import UIKit

extension UISearchBar {
    
    func updateHeight(height: CGFloat, image: UIImage = Asset.icSearchClose.image) {
        if let searchTextField = self.value(forKey: "searchField") as? UITextField {
            searchTextField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                searchTextField.heightAnchor.constraint(equalToConstant: height),
                searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
                searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
                searchTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
            ])
            searchTextField.clipsToBounds = true
            searchTextField.layer.cornerRadius = 10.0
        }
        setImage(image, for: .clear, state: .normal)
    }
    
    func setLeftImagePadding(_ image: UIImage, with padding: CGFloat = 0, text: String, leftView: UIView? = nil) {
        
        searchBarStyle = .minimal
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.tintColor = Asset.mainTextColor.color
        searchTextPositionAdjustment = UIOffset(horizontal: 5, vertical: 0)
    
        if padding != 0 {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fill
            stackView.translatesAutoresizingMaskIntoConstraints = false
            let paddingView = UIView()
            paddingView.translatesAutoresizingMaskIntoConstraints = false
            paddingView.widthAnchor.constraint(equalToConstant: padding).isActive = true
            paddingView.heightAnchor.constraint(equalToConstant: padding).isActive = true
            stackView.addArrangedSubview(paddingView)
            stackView.addArrangedSubview(imageView)
            searchTextField.leftView = stackView
            
            if let leftView = leftView {
                let stackView = UIStackView()
                stackView.axis = .horizontal
                stackView.alignment = .center
                stackView.distribution = .fill
                stackView.translatesAutoresizingMaskIntoConstraints = false
                let paddingView = UIView()
                paddingView.translatesAutoresizingMaskIntoConstraints = false
                paddingView.widthAnchor.constraint(equalToConstant: padding).isActive = true
                paddingView.heightAnchor.constraint(equalToConstant: padding).isActive = true
                stackView.addArrangedSubview(paddingView)
                stackView.addArrangedSubview(leftView)
                
                searchTextField.rightView = stackView
                searchTextField.rightViewMode = .always
                searchTextField.leftViewMode = .always
                searchTextField.layoutIfNeeded()
                searchTextField.layoutSubviews()
            } else {
//                searchTextField.rightViewMode = .always
                searchTextField.layoutIfNeeded()
                searchTextField.layoutSubviews()
            }
            
            searchTextField.attributedPlaceholder = NSAttributedString(string: text, attributes: [.foregroundColor: Asset.secondaryTextColor.color])
        } else {
            searchTextField.leftView = imageView
            searchTextField.rightView = leftView
        }
        searchTextField.backgroundColor = Asset.formColor.color
    }
    
    func removeRightView() {
        
    }
}
