//
//  HorizontalItemsCollectionReusableView.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 30.08.2022.
//

import UIKit
import SnapKit
class HorizontalItemsCollectionReusableView: UICollectionReusableView {
        static let identifier = "HorizontalItemsCollectionReusableView"
    
    private lazy var label: UILabel = {
       let label = UILabel()
        label.text = "Offers"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview()
                
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
