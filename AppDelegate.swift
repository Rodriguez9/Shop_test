//
//  AppDelegate.swift
//  shop_test
//
//  Created by 姚智豪 on 2020/2/23.
//  Copyright © 2020 姚智豪. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var reachability: NetworkReachabilityManager? = {
        return NetworkReachabilityManager(host: "http://app.u17.com")
    }()
    
    var orientation: UIInterfaceOrientationMask = .portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configBase()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = UTabBarController()
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientation
    }
    
    func configBase(){
        
        //MARK : 键盘处理
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        let defaults = UserDefaults.standard
        if defaults.value(forKey: String.sexTypeKey) == nil {
            defaults.set(1, forKey: String.sexTypeKey)
            defaults.synchronize()
        }
        //MARK: 网络监控
        reachability?.listener = { status in
            switch status {
            case .reachable(.wwan): break
                
            default:
                break
            }
        }
        reachability?.startListening()
    }
}

extension UIApplication{
    //MARK : 强制旋转屏幕
    class func changeOrientationTo(landscapeRight: Bool){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        if landscapeRight == true {
            delegate.orientation = .landscapeRight
            UIApplication.shared.supportedInterfaceOrientations(for: delegate.window)
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        }else{
            delegate.orientation = .portrait
            UIApplication.shared.supportedInterfaceOrientations(for: delegate.window)
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        }
    }
}

