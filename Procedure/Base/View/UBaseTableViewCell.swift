//
//  UBaseTableViewCell.swift
//  shop_test
//
//  Created by 姚智豪 on 2020/3/18.
//  Copyright © 2020 姚智豪. All rights reserved.
//

import UIKit
import Reusable

class UBaseTableViewCell: UITableViewCell,Reusable {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        
    }

}
