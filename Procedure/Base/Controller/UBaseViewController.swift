//
//  UBaseViewController.swift
//  shop_test
//
//  Created by 姚智豪 on 2020/3/2.
//  Copyright © 2020 姚智豪. All rights reserved.
//

import UIKit
import SnapKit
import Then
import Reusable
import Kingfisher

class UBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        if #available(iOS 11.0, *){
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }else{
            automaticallyAdjustsScrollViewInsets = false
        }
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    
    func configUI(){}
    
    func configNavigationBar(){
        guard let navi = navigationController else { return }
        if navi.visibleViewController == self {
            navi.barStyle(.theme)
            navi.disablePopGesture = false
            navi.setNavigationBarHidden(false, animated: true)
            if navi.viewControllers.count > 1 {
                navigationItem.leftBarButtonItem = UIBarButtonItem(
                    image: UIImage(named: "nav_back_white"),
                    target: self,
                    action: #selector(pressBack))
            }
        }
    }
    
    @objc func pressBack() {
        navigationController?.popViewController(animated: true)
    }

}

extension UBaseViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
