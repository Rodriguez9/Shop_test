//
//  Global.swift
//  shop_test
//
//  Created by 姚智豪 on 2020/2/24.
//  Copyright © 2020 姚智豪. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import MJRefresh

extension UIColor{
    class var background: UIColor {
           return UIColor(r: 242, g: 242, b: 242)
       }
       
       class var theme: UIColor {
           return UIColor(r: 29, g: 221, b: 43)
       }
}

extension String{
    static let searchHistoryKey = "searchHistoryKey"
    static let sexTypeKey = "sexTypeKey"
}

extension NSNotification.Name{
     static let USexTypeDidChange = NSNotification.Name("USexTypeDidChange")
}

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

var topVC: UIViewController?{
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.windows[0].rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

var isIphoneX:Bool{
    return UIDevice.current.userInterfaceIdiom == .phone
        && (max(UIScreen.main.bounds.height,UIScreen.main.bounds.width) == 812
        || max(UIScreen.main.bounds.height,UIScreen.main.bounds.width) == 896)
}

private func _topVC(_ vc: UIViewController?) -> UIViewController?{
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    }else if vc is UITabBarController{
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    }else{
        return vc
    }
}


//MARK: Kingfisher
//圖片處理，當作用在ImageView或者UIButton類是
extension KingfisherWrapper where Base: KFCrossPlatformImageView{
    @discardableResult
    public func setImage(urlString: String?, placeholder: Placeholder? = UIImage(named: "normal_placeholder_h")) -> DownloadTask?{
        return  setImage(with: URL(string: urlString ?? ""), placeholder:placeholder , options: [.transition(.fade(0.5))])
    }
}

extension KingfisherWrapper where Base: UIButton{
@discardableResult
     public func setImage(urlString: String?, for state: UIControl.State, placeholder: UIImage? = UIImage(named: "normal_placeholder_h")) -> DownloadTask? {
         return setImage(with: URL(string: urlString ?? ""),
         for: state,
         placeholder: placeholder,
         options: [.transition(.fade(0.5))])
    }
}

//MARK: SnapKit
//约束布局
extension ConstraintView{
    var usnp: ConstraintBasicAttributesDSL{
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }else{
            return self.snp
        }
    }
}

extension UICollectionView{
    func reloaData(animation: Bool = true){
        if animation {
            reloaData()
        }else{
            //禁用视图过渡动画
            UIView.performWithoutAnimation {
                reloaData()
            }
        }
    }
}
