//
//  UTabBarController.swift
//  shop_test
//
//  Created by 姚智豪 on 2020/2/25.
//  Copyright © 2020 姚智豪. All rights reserved.
//

import UIKit

class UTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        // Do any additional setup after loading the view.
    }
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?){
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: nil,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            addChild(UNavigationController(rootViewController: childController))
        }
    }
}

extension UTabBarController{
    //状态栏的风格
    override var preferredStatusBarStyle: UIStatusBarStyle{
        guard let select = selectedViewController else { return .lightContent}
        return select.preferredStatusBarStyle
    }
}
