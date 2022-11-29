//
//  ChipCell.swift
//  ChipsTF
//
//  Created by Vladimir Gorbunov on 10/24/22.
//

import UIKit
import SnapKit

final class ChipCell: CommonInitCollectionViewCell {    
    var label = makeLabel()
    var closeButton = makeImageView()
    static let defaultId = UUID().uuidString
    
    override func commonInit() {
        self.backgroundColor = .clear
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.cornerRadius = 6.0
        self.clipsToBounds = true
        
        self.contentView.addSubview(label)
        self.contentView.addSubview(closeButton)
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(10.0)
            make.right.equalTo(closeButton.snp.left).offset(-6.0)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(7.0)
            make.size.equalTo(16.0)
        }
    }
    
    //TODO: Check if need!
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension ChipCell {
    static func makeLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .red
        //TODO: Style
        label.font = UIFont.systemFont(ofSize: 13.0)
        
        return label
    }
    
    static func makeImageView() -> UIButton {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "textField_chip_close"), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }
}
