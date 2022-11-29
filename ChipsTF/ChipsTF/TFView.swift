//
//  TFView.swift
//  ChipsTF
//
//  Created by Vladimir Gorbunov on 10/24/22.
//

import UIKit
import SnapKit

final class TFView: UIView {
    
    private var searchItemsList: [Any]?
    private(set) var selectedItemList: [Any]?
    
    private var collectionView: UICollectionView = makeCollectionview()
    private var tableView: UITableView = makeTableView()
    private var headerLbl: UILabel = UILabel()
    private var clearButton: UIImageView = makeClearButton()
    private var bottomStroke: UIView = UIView()
    private var bottomHighlighter: UIView = UIView()
    private var placeholder: String?
    
    var isActive: Bool = false {
        didSet {
            bottomHighlighter.isHidden = isActive ? false : true
            
            if isActive {
                //TODO:
                headerLbl.attributedText = NSMutableAttributedString(string: "")
            } else {
                headerLbl.attributedText = NSMutableAttributedString(string: "")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(with searchList: [Any], header: String, placeholder: String) {
        self.init(frame: .zero)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(ChipCell.self,
                                     forCellWithReuseIdentifier: ChipCell.defaultId)
        self.collectionView.register(TextFieldCell.self,
                                     forCellWithReuseIdentifier: TextFieldCell.defaultId)
        
        
        //        tableView.delegate = self
        //        tableView.dataSource = self
        
        self.searchItemsList = searchList
        self.selectedItemList = searchList
        
        self.headerLbl = TFView.makeHeaderLbl(title: header)
        self.placeholder = placeholder
        
        self.commonInit()
    }
    
    private func commonInit() {
        
        
        backgroundColor = .clear
        bottomStroke.backgroundColor = .gray
        bottomHighlighter.backgroundColor = .blue
        bottomHighlighter.isHidden = true
        
        //Header
        addSubview(headerLbl)
        
        //ClearButton
        addSubview(clearButton)
        
        //Collection
        addSubview(collectionView)
        
        //BottomHighlighter
        addSubview(bottomStroke)
        addSubview(bottomHighlighter)
        
        //TableView
        addSubview(tableView)
        
        headerLbl.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
        }
        
        clearButton.snp.makeConstraints { make in
            make.size.equalTo(24.0)
            make.right.equalToSuperview()
            make.centerY.equalTo(collectionView.snp.centerY)
        }
        
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(clearButton.snp.left).offset(-12.0)
            make.top.equalTo(headerLbl.snp.bottom).offset(10.0)
            make.height.equalTo(0.0)
        }
        
        bottomStroke.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).offset(13.0)
            make.height.equalTo(0.5)
        }
        
        bottomHighlighter.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(2.0)
            make.top.equalTo(collectionView.snp.bottom).offset(13.0)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(bottomStroke.snp.bottom)
        }
    }
    
    
    func updateCollectionView() {
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        
        collectionView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
        self.layoutIfNeeded()
    }
}

private extension TFView {
    static func makeCollectionview() -> UICollectionView {
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        
        alignedFlowLayout.minimumLineSpacing = 8.0
        alignedFlowLayout.minimumInteritemSpacing = 8.0
        alignedFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let cv = CustomCollectionView(frame: .zero, collectionViewLayout: alignedFlowLayout)
        
        return cv
    }
    
    static func makeTableView() -> UITableView {
        let tv = UITableView()
        
        return tv
    }
    
    static func makeClearButton() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "textField_clear_btn")
        
        return imageView
    }
    
    static func makeHeaderLbl(title: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        //TODO:
        //        var style = Typography.Fonts.Heading.h1Style
        //        style.color = Typography.Colors.System.black80.color
        //        label.attributedText = title.styled(with: style)
        
        label.attributedText = NSMutableAttributedString(string: title)
        
        return label
    }
}

extension TFView: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TFView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 120, height: 28.0)
    }
}

extension TFView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count =  selectedItemList?.count ?? 0
        return count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let totalCount =  selectedItemList?.count ?? 0
        
        if indexPath.row == totalCount {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextFieldCell.defaultId,
                                                                for: indexPath) as? TextFieldCell else {
                fatalError("Can't dequeue cell for ChipCell")}
            
            updateCollectionView()
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipCell.defaultId,
                                                                for: indexPath) as? ChipCell else {
                fatalError("Can't dequeue cell for ChipCell")}
            cell.label.text = selectedItemList?[indexPath.row] as? String
            cell.closeButton.tag = indexPath.row
            cell.closeButton.addTarget(self, action: #selector(removeCell(_:)), for: .touchUpInside)
            updateCollectionView()
            return cell
        }
    }
}

private extension TFView {
    @objc func removeCell(_ sender: UIButton) {
        let index = sender.tag
        
      //  var hitPoint = sender.convert(CGPoint.zero, to: collectionView)
      //  guard var hitIndex = collectionView.indexPathForItem(at: hitPoint) else { return }

        self.selectedItemList?.remove(at: index)
        
        collectionView.reloadData()
    }
}

//extension TFView: UITableViewDelegate {
//
//}
//
//extension TFView: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}
