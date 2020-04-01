//
//  UBaseCollectionReusableView.swift
//  shop_test
//
//  Created by 姚智豪 on 2020/3/18.
//  Copyright © 2020 姚智豪. All rights reserved.
//

import UIKit
import Reusable

class UBaseCollectionReusableView: UICollectionReusableView,Reusable {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {}
    
}
