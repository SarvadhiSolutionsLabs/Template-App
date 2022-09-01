//
//  UIViewController.swift
//  Template
//
//  Created by Avadh on 10/05/22.
//

import Foundation
import UIKit
import FittedSheets
import Toast_Swift
import Alamofire

protocol refreshDelegate: AnyObject {
    func handleRefresh(_ refreshControl: UIRefreshControl)
}

extension UIViewController: refreshDelegate {
    
    var sceneDelegate: SceneDelegate? {
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            return delegate
        }
        return nil
    }
    
    var refreshDelegate: refreshDelegate? {
        return self
    }
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = Asset.mainTextColor.color
        return refreshControl
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshDelegate?.handleRefresh(refreshControl)
    }
        
    func setRootViewController(vc: UIViewController) {
        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    func navigateViewController(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func navigatePopToViewController(vc: Any) {
        for element in (navigationController?.viewControllers ?? []) as Array where "\(type(of: element)).Type" == "\(type(of: vc))" {
            self.navigationController?.popToViewController(element, animated: true)
            break
        }
    }
    
    func navigatePopToRootViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func navigateBackViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func presentVC(_ style: UIModalPresentationStyle = .overFullScreen, vc: UIViewController) {
        vc.modalPresentationStyle = style
        self.navigationController?.present(vc, animated: true)
    }
    
    func dismiss() {
        self.dismiss(animated: true)
    }
    
    @objc func actionDismiss() {
        self.dismiss(animated: true)
    }
    
    func setBackGroundColor(color: UIColor = .white) {
        self.view.backgroundColor = color
    }
    
    func setCustomLargeTitle(title: String, color: UIColor = .clear) {
        let view = NavigationBar.fromNib() as? NavigationBar
        view?.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
        view?.heightAnchor.constraint(equalToConstant: 96).isActive = true
        view?.title = title
        view?.backgroundColor = color
        self.navigationItem.titleView = view
    }
    
    func setNavigationTitle(title: String = "", size: CGFloat = 16.0, weight: UIFont.Weight = .semibold, _ color: UIColor = Asset.mainTextColor.color) {
        self.setBackGroundColor(color: .systemBackground)
        self.title = title
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: size, weight: weight), .foregroundColor: color]
    }
    
    func setNavigationLargeTitleFont(size: CGFloat, weight: UIFont.Weight, _ color: UIColor = Asset.mainTextColor.color) {
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: size, weight: weight), .foregroundColor: color]
    }
    
    func backButton(tintColor: UIColor? = Asset.mainTextColor.color, addExtraView: UIView? = nil, image: UIImage = Asset.icBack.image ) {
        self.showNavigationBar()
        let backButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(btnActionBack))
        if tintColor != nil {
            backButton.tintColor = tintColor
        }
        if addExtraView != nil {
            let extraView = UIBarButtonItem(customView: addExtraView!)
            self.navigationItem.leftBarButtonItems = [backButton, extraView]
        } else {
            self.navigationItem.leftBarButtonItems = [backButton]
        }
    }
    
    func backButtonWithSelector(tintColor: UIColor? = Asset.mainTextColor.color, image: UIImage = Asset.icBack.image, selector: Selector ) {
        self.showNavigationBar()
        let backButton = UIBarButtonItem(image: image, style: .plain, target: self, action: selector)
        if tintColor != nil {
            backButton.tintColor = tintColor
        }
        self.navigationItem.leftBarButtonItems = [backButton]
    }
    
    func rightNavButton(image: UIImage? = nil, selector: Selector) {
        self.showNavigationBar()
        let backButton = UIBarButtonItem(image: image, style: .plain, target: self, action: selector)
//        backButton.tintColor = tintColor
        self.navigationItem.rightBarButtonItems = [backButton]
    }
    
    func cancelAlamofireRequests() {
        AF.session.getTasksWithCompletionHandler({ dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        })
    }
    
    func closeButton(tintColor: UIColor = Asset.mainTextColor.color) {
        let backButton = UIBarButtonItem(image: Asset.icBlackClose.image, style: .plain, target: self, action: #selector(btnActionBack))
        backButton.tintColor = tintColor
        self.navigationItem.leftBarButtonItems = [backButton]
    }
    
    func closeButtonWithSelector(tintColor: UIColor = Asset.mainTextColor.color, selector: Selector) {
        let backButton = UIBarButtonItem(image: Asset.icBlackClose.image, style: .plain, target: self, action: selector)
        backButton.tintColor = tintColor
        self.navigationItem.leftBarButtonItems = [backButton]
    }
    
    func closeDismissButton() {
        let backButton = UIBarButtonItem(image: Asset.icBlackClose.image, style: .plain, target: self, action: #selector(actionDismiss))
        backButton.tintColor = Asset.mainTextColor.color
        self.navigationItem.leftBarButtonItems = [backButton]
    }
    
    func showNavigationBar() {
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func hideNavigationBar() {
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func showTabBar() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func hideTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func btnActionBack() {
        self.navigateBackViewController()
    }
    
    func alert(title: String, subTitle: String, buttons: [String], image: UIImage? = nil, actions: [(() -> Void)]) {
        let vc = StoryboardScene.Main.customAlertViewController.instantiate()
        vc.mainTitle = title
        vc.subTitle = subTitle
        vc.image = image
        var buttona = [UIButton]()
        for index in 0..<buttons.count {
            let button = UIButton(type: .system)
            button.setTitleColor(Asset.primaryColor.color, for: .normal)
            button.frame.size.height = 30
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            button.titleLabel?.font = UIFont.mySystemFont(ofSize: 16.0, weight: .semibold)
            button.setTitle(buttons[index], for: .normal)
            button.addAction(for: .touchUpInside, actions[index])
            buttona.append(button)
        }
        vc.buttons = buttona
        self.presentVC(vc: vc)
    }
    
    func barButtonItem(_ target: Any?, action: Selector, image: UIImage? = nil, tintColor: UIColor = Asset.mainTextColor.color, title: String? = nil) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        if title != nil {
            button.setTitle(title, for: .normal)
        }
        if image != nil {
            button.setImage(image, for: .normal)
        }
        button.titleLabel?.font = .mySystemFont(ofSize: 14.0, weight: .semibold)
        button.tintColor = tintColor
        button.addTarget(target, action: action, for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.tintColor = tintColor
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
//        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return menuBarItem
    }
    
    func barButton(_ target: Any?, action: Selector, image: UIImage, title: String? = nil) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withTintColor(Asset.mainTextColor.color), for: .normal)
        button.setTitle(title, for: .normal)
        button.tintColor = Asset.mainTextColor.color
        button.addTarget(target, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return button
    }
    
    func openSheetView(vc: UIViewController, cornerRadius: CGFloat = 20, itemsCount: Int? = 2, rowHeight: Int = 95) {
        var contentSize: CGFloat = 250
        if itemsCount != nil {
            contentSize = CGFloat((itemsCount! * rowHeight) + 60)
        }
        if #available(iOS 15.0, *) {
            if let sheet = vc.sheetPresentationController {
                let detent1: UISheetPresentationController.Detent = ._detent(withIdentifier: "Test1", constant: contentSize)
                sheet.detents = [detent1]
                sheet.preferredCornerRadius = cornerRadius
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.prefersGrabberVisible = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
                vc.modalPresentationStyle = .custom
                vc.preferredContentSize.height = contentSize + 20
                present(vc, animated: true, completion: nil)
            }
        } else {
            vc.preferredContentSize.height = contentSize + 60
            let sheet = SheetViewController(controller: vc, sizes: [.fixed(contentSize + 60)])
            sheet.cornerRadius = cornerRadius
            self.present(sheet, animated: false, completion: nil)
        }
    }
    
    func openSheetViewWithClickable(vc: UIViewController, cornerRadius: CGFloat = 20, rowHeight: Int = 95, detentHeight2: CGFloat = 380) {
        let contentSize: CGFloat = CGFloat((rowHeight) + 60)
        if #available(iOS 15.0, *) {
            if let sheet = vc.sheetPresentationController {
                let detent1: UISheetPresentationController.Detent = ._detent(withIdentifier: "Test1", constant: contentSize)
                let detent2: UISheetPresentationController.Detent = ._detent(withIdentifier: "Test2", constant: detentHeight2)
                sheet.detents = [detent1, detent2]
                sheet.largestUndimmedDetentIdentifier = .init(rawValue: "Test2")
                sheet.preferredCornerRadius = cornerRadius
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.prefersGrabberVisible = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
                vc.modalPresentationStyle = .custom
                vc.preferredContentSize.height = contentSize + 20
                present(vc, animated: true, completion: nil)
            }
        } else {
            vc.preferredContentSize.height = contentSize + 60
            let sheet = SheetViewController(controller: vc, sizes: [.fixed(contentSize + 60)])
            sheet.cornerRadius = cornerRadius
            self.present(sheet, animated: false, completion: nil)
        }
    }
    
    func openSharingView(_ text: [String]?, _ images: [UIImage]?) {
        var activityViewController: UIActivityViewController?
        if text != nil {
            activityViewController = UIActivityViewController(activityItems: text ?? [], applicationActivities: nil)
        }
        if images != nil {
            activityViewController = UIActivityViewController(activityItems: images ?? [], applicationActivities: nil)
        }
        activityViewController?.popoverPresentationController?.sourceView = self.view
        if text != nil || images != nil {
            self.present(activityViewController!, animated: true, completion: nil)
        }
    }
    
    func toast(message: String) {
        self.sceneDelegate?.window?.makeToast(message, duration: 1.0, position: .bottom)
    }
    
    @objc func textViewDidTapped(recognizer: UITapGestureRecognizer) {
        guard let myTextView = recognizer.view as? UITextView else {
            return
        }
        changeTextViewToNormalState(textView: myTextView)
        recognizer.isEnabled = false
    }
        
    fileprivate func changeTextViewToNormalState(textView: UITextView) {
        textView.isEditable = true
        textView.dataDetectorTypes = []
        textView.becomeFirstResponder()
    }
}

extension CALayer {
    
    func applyShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0, y: CGFloat = 0, blur: CGFloat = 4, spread: CGFloat = 0) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

extension UIViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
