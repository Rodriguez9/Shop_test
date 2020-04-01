//
//  UBaseTableViewHeaderFooterView.swift
//  shop_test
//
//  Created by 姚智豪 on 2020/3/18.
//  Copyright © 2020 姚智豪. All rights reserved.
//

import UIKit
import Reusable
import SnapKit

//放置在表部分顶部或底部的可重用视图，以显示该部分的其他信息。
class UBaseTableViewHeaderFooterView: UITableViewHeaderFooterView,Reusable {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        config()
    }
    
    func config(){}
}
