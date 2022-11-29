//
//  CommonInitCollectionViewCell.swift
//  ArenaFun
//
//  Created by Александр Макушкин on 28.03.2022.
//

import UIKit

class CommonInitCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    func commonInit() {
    }
}
