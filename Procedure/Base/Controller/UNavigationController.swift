//
//  UNavigationController.swift
//  shop_test
//
//  Created by 姚智豪 on 2020/3/18.
//  Copyright © 2020 姚智豪. All rights reserved.
//

import UIKit

class UNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //interactivePopGestureRecognizer:当前手势
        guard let interactionGes = interactivePopGestureRecognizer else { return  }
        guard let targetView = interactionGes.view else { return }
        guard let internalTargets = interactionGes.value(forKeyPath: "targets") as? [NSObject] else { return }
        guard let internalTarget = internalTargets.first?.value(forKey: "target") else {return}
        let action = Selector(("handleNavigationTransition:"))
        let fullScreenGes = UIPanGestureRecognizer(target: internalTarget, action: action)
        targetView.addGestureRecognizer(fullScreenGes)
        fullScreenGes.delegate = self
        interactionGes.isEnabled = false
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //如果不是处于栈顶
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

extension UNavigationController:UIGestureRecognizerDelegate{

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let isLeftToRight = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight
        guard let ges = gestureRecognizer as? UIPanGestureRecognizer else {return true}
        if ges.translation(in: gestureRecognizer.view).x * (isLeftToRight ? 1 : -1) <= 0 || disablePopGesture {
            return false
        }
        return viewControllers.count != 1
    }
}

extension UNavigationController{
    override var preferredStatusBarStyle: UIStatusBarStyle{
        guard let topVC = topViewController else { return .lightContent }
        return topVC.preferredStatusBarStyle
    }
}

enum UNavigationBarStyle {
    case theme
    case clear
    case white
}

extension UINavigationController{
    
    private struct AssociatedKeys {
        static var disablePopGesture: Void?
    }
    
    var disablePopGesture:Bool{
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.disablePopGesture) as? Bool ?? false)
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.disablePopGesture, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func barStyle(_ style: UNavigationBarStyle){
        switch style {
            case .theme:
                   navigationBar.barStyle = .black
                   navigationBar.setBackgroundImage(UIImage(named: "nav_bg"), for: .default)
                   navigationBar.shadowImage = UIImage()
               
               case .clear:
                   navigationBar.barStyle = .black
                   navigationBar.setBackgroundImage(UIImage(), for: .default)
                   navigationBar.shadowImage = UIImage()
               case .white:
                   navigationBar.barStyle = .black
                   navigationBar.setBackgroundImage(UIColor.white.image(), for: .default)
                   navigationBar.shadowImage = nil
               }
    }
    
    
}
