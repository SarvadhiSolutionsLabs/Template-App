//
//  TabbarViewController.swift
//  Template
//
//  Created by Avadh on 23/05/22.
//

import UIKit
import Localize_Swift

class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNavigationBar()
        self.selectedIndex = 0
        
        self.tabBar.layer.masksToBounds = false
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -5)
        self.tabBar.layer.shadowRadius = 10
        self.tabBar.layer.shadowColor = Asset.shadowColor.color.withAlphaComponent(0.25).cgColor
        self.tabBar.layer.shadowOpacity = 1
        
//        let space = StoryboardScene.Space.spaceViewController.instantiate()
        
//        switch StorageManager.userDetails?.user_type {
//        case 1:
//            viewControllers = [
//                createTabController(viewController: space, image: Asset.tabSpace.image, selectedImage: Asset.tabSpaceSelected.image, title: "Space".localized())]
//        default: break
//        }
        // Do any additional setup after loading the view.
    }
    
    fileprivate func createTabController(viewController: UIViewController, image: UIImage, selectedImage: UIImage, title: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
//        viewController.view.backgroundColor = .white
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage
        navController.tabBarItem.title = title
        return navController
    }

}
