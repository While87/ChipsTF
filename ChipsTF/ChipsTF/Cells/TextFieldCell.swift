//
//  TextFieldCell.swift
//  ChipsTF
//
//  Created by Vladimir Gorbunov on 10/24/22.
//

import UIKit
import SnapKit


final class TextFieldCell: CommonInitCollectionViewCell {
    var textField = TextFieldCell.makeTextField()
    static let defaultId = UUID().uuidString
    
    override func commonInit() {
        textField.delegate = self
        
        self.contentView.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    //TODO: Check if need!
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension TextFieldCell {
    static func makeTextField() -> UITextField {
        let tf = UITextField()
        tf.textColor = .red
        //TODO: Style
        tf.font = UIFont.systemFont(ofSize: 13.0)
        tf.placeholder = "Some"
        
        return tf
    }
}

extension TextFieldCell: UITextFieldDelegate {
    
}
