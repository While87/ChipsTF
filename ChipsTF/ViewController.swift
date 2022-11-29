//
//  ViewController.swift
//  ChipsTF
//
//  Created by Vladimir Gorbunov on 10/24/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var tf = TFView(with: ["Футбол", "Баскетбол", "Волейбол", "Рэгби", "Лыжи", "Бег", "Бокс"], header: "Вид спорта", placeholder: "Например футбол")
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.addSubview(tf)
        tf.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(40.0)
            make.top.equalToSuperview().inset(200.0)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tf.updateCollectionView()
    }
}

