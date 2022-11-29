//
//  CommonInitTableViewCell.swift
//  ArenaFun
//
//  Created by Александр Макушкин on 28.03.2022.
//

import UIKit

class CommonInitTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    func commonInit() {
    }
}
