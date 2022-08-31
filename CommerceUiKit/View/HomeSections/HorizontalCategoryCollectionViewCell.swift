//
//  HorizontalCategoryCollectionViewCell.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 30.08.2022.
//

import UIKit
import SnapKit

class HorizontalCategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "HorizontalCategoryCollectionViewCell"
    
    lazy var label: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    lazy var bg: UIView = {
        let bg = UIView()
        bg.backgroundColor = .orange
        bg.layer.cornerRadius = 3
        bg.layer.zPosition = -1
        return bg
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
     
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.addSubview(bg)
        label.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        bg.snp.makeConstraints { make in
            make.right.bottom.equalTo(label)
            make.width.equalTo(50)
            make.height.equalTo(5)
        }
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 20
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(_ text: String, curIndex: Int, selectedIndex: Int){
        label.text = text
        label.textColor = selectedIndex == curIndex ? .label : .black.withAlphaComponent(0.5)
        bg.isHidden = selectedIndex == curIndex ? false : true

        
    }
}
