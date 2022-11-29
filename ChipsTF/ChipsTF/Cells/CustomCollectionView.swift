//
//  CustomCollectionView.swift
//  ChipsTF
//
//  Created by Vladimir Gorbunov on 10/24/22.
//

import UIKit

class CustomCollectionView: UICollectionView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
                    invalidateIntrinsicContentSize()
                }
    }
    
    override var intrinsicContentSize: CGSize {
           return contentSize
       }

}
