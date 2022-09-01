//
//  UITableView+kit.swift
//  Template
//
//  Created by Avadh on 18/05/22.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(ofType type: T.Type) {
        let cellName = String(describing: T.self)
        
        if Bundle.main.path(forResource: cellName, ofType: "nib") != nil {
            let nib = UINib(nibName: cellName, bundle: Bundle.main)
            register(nib, forCellReuseIdentifier: cellName)
        } else {
            register(T.self, forCellReuseIdentifier: cellName)
        }
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    func dequeueCell<T: UITableViewCell>(ofType type: T.Type, forIndexPath indexPath: IndexPath) -> T? {
        let cellName = String(describing: T.self)
        let cell = dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? T
        cell?.selectionStyle = .none
        return cell
    }
    
    func noDataView(_ image: UIImage? = nil, _ title: String = "", _ description: NSAttributedString? = nil) {
        let noDataView = NoDataFoundView.fromNib() as? NoDataFoundView
        if image != nil {
            noDataView?.vwImg.isHidden = false
            noDataView?.img.tintColor = Asset.secondaryTextColor.color
            noDataView?.img.image = image?.withTintColor(Asset.secondaryTextColor.color, renderingMode: .alwaysTemplate)
        } else {
            noDataView?.vwImg.isHidden = true
        }
        
        let formattedString = NSMutableAttributedString()
            .attribute(text: title, color: Asset.secondaryTextColor.color, spacing: 0.5, lineHeight: 24)
        noDataView?.lblTitle.attributedText = formattedString
        noDataView?.lblTitle.textAlignment = .center
        if description == nil {
            noDataView?.vwDescription.isHidden = true
        } else {
            noDataView?.vwDescription.isHidden = false
            noDataView?.lblDescription.attributedText = description
        }
        noDataView?.lblDescription.textAlignment = .center
        self.backgroundView = noDataView
    }
    
    func clearNoDataView() {
        self.backgroundView = nil
    }
    
    func setBottomScrollInset() {
        self.contentInsetAdjustmentBehavior = .never
        self.contentInset.bottom = 20
    }
    
    func swipeActionFontChange(font: UIFont? = .systemFont(ofSize: 10, weight: .regular)) {
        if #available(iOS 13.0, *) {
            for subview in self.subviews where NSStringFromClass(type(of: subview)) == "_UITableViewCellSwipeContainerView" {
                for swipeContainerSubview in subview.subviews where NSStringFromClass(type(of: swipeContainerSubview)) == "UISwipeActionPullView" {
                    for case let button as UIButton in swipeContainerSubview.subviews {
                        button.titleLabel?.font = font
                    }
                }
            }
        } else {
            for subview in self.subviews where NSStringFromClass(type(of: subview)) == "UISwipeActionPullView" {
                for case let button as UIButton in subview.subviews {
                    button.titleLabel?.font = font
                    button.widthAnchor.constraint(equalToConstant: 137).isActive = true
                }
            }
        }
    }
    
    func hideRefreshControl() {
        self.refreshControl?.endRefreshing()
    }
    
    func footerButton(title: String, titleAlign: UIControl.ContentHorizontalAlignment? = .center, icon: UIImage? = nil, color: UIColor? = nil, target: Any?, action: Selector, border: ViewSide = .none, font: UIFont = UIFont.mySystemFont(ofSize: 14.0, weight: .medium)) {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 60))
        let button = UIButton()
        if icon != nil {
            button.setImage(icon, for: .normal)
        }
        if color != nil {
            button.setTitleColor(color, for: .normal)
        }
        button.contentHorizontalAlignment = titleAlign ?? .center
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        var frameY: CGFloat = 0
        if border != .none {
            frameY = (border == .top) ? 20 : 0
            footerView.frame.origin.y = frameY
            footerView.addBorder(toSide: border, withColor: Asset.outlineColor.color.cgColor, andThickness: 1)
        }
        switch titleAlign {
        case .left:
            button.frame = CGRect(x: 20, y: frameY, width: footerView.frame.size.width - 20, height: 60)
        default:
            button.frame = CGRect(x: 0, y: frameY, width: footerView.frame.size.width - 20, height: 60)
        }
        
        button.addTarget(target, action: action, for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: self.frame.size.width - 20).isActive = true
        footerView.addSubview(button)
        self.tableFooterView = footerView
    }
    
    func fillFooterButton(buttons: [UIButton], titleAlign: UIControl.ContentHorizontalAlignment? = .center) {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 20, width: self.frame.size.width, height: 100))
        let stackView = UIStackView(frame: CGRect(x: 40, y: 20, width: screenSize.width - 80, height: 55))
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        footerView.addSubview(stackView)
        
        if buttons.count > 1 {
            stackView.frame = CGRect(x: 20, y: 20, width: screenSize.width - 40, height: 55)
        }
        
        for button in buttons {
            button.heightAnchor.constraint(equalToConstant: 55).isActive = true
            button.backgroundColor = Asset.fillButtonColor.color
            button.tintColor = Asset.primaryColor.color
            button.setTitleColor(Asset.primaryColor.color, for: .normal)
            button.layer.cornerRadius = 10
            button.contentHorizontalAlignment = titleAlign ?? .center
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
            button.titleLabel?.font = UIFont.mySystemFont(ofSize: 14.0, weight: .bold)
            stackView.addArrangedSubview(button)
        }
        
        self.tableFooterView = footerView
        
    }
}
