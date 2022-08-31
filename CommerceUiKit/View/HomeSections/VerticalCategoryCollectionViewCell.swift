//
//  VerticalCategoryCollectionViewCell.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 30.08.2022.
//

import UIKit
import Kingfisher

class VerticalCategoryCollectionViewCell: UICollectionViewCell {
    static let identfier = "VerticalCategoryCollectionViewCell"
    
    private lazy var bgImage: UIImageView = {
       let bgImage = UIImageView()
        bgImage.contentMode = .scaleAspectFill
        bgImage.clipsToBounds = true
        bgImage.layer.masksToBounds = true
        return bgImage
    }()
    
    private lazy var rectengla: UIView = {
       let rectangle = UIView()
        rectangle.backgroundColor = .systemBackground
        rectangle.layer.cornerRadius = 20
        rectangle.layer.maskedCorners = [.layerMaxXMinYCorner]
        return rectangle
    }()
    
    private lazy var label: UILabel = {
       let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    override func prepareForReuse() {
        super.removeFromSuperview()
        label.text = nil
        bgImage.image = nil
     
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        makeConstraints()
    }
    
    func makeConstraints(){
        addSubview(bgImage)
        bgImage.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        addSubview(rectengla)
        rectengla.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
            make.width.equalTo(180)
            make.height.equalTo(40)
            
        }
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(rectengla)
        }
    }
    
    func configure(category: Category?){
        guard let url = URL(string: category?.image ?? "") else {fatalError("")}
        let processor = DownsamplingImageProcessor(size: bgImage.bounds.size)
        bgImage.kf.indicatorType = .activity
        bgImage.kf.setImage(with: url)
        
        label.text = category?.name ?? ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
