//
//  HorizontalItemCollectionViewCell.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 30.08.2022.
//

import UIKit
import SnapKit
import Kingfisher

protocol HorizontalItemCollectionViewCellDelegate: AnyObject {
    func addToCartTapped(CartItem: CartItem)
}

final class HorizontalItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "HorizontalItemCollectionViewCell"
    
    private var tempCartItem: CartItem?
    weak var delegate : HorizontalItemCollectionViewCellDelegate?
    
    //MARK: UI
    let itemImageBorder: UIView = {
       let imageview = UIView()
        imageview.layer.cornerRadius = 10
        imageview.backgroundColor = .clear
        imageview.layer.borderWidth = 0.5
        imageview.layer.borderColor = UIColor.label.withAlphaComponent(0.3)
            .cgColor
        return imageview
    }()

    let itemImage: UIImageView = {
       let imageview = UIImageView()
        imageview.image = UIImage(systemName: "house")
        imageview.backgroundColor = .blue
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = 8
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    let fiyatLabel: UILabel = {
       let label = UILabel()
        label.text = "7.187,99 TL"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .orange
        return label
    }()
    
    let acikalama: UILabel = {
       let label = UILabel()
        label.text = "7.187,99 TL"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.textColor = .label
        return label
    }()
    
    let buyButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("ADD TO CART", for: .normal)
        btn.setTitle("ADDED", for: .highlighted)
        btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        btn.backgroundColor = .clear
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.label.withAlphaComponent(0.5)
            .cgColor
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    
    //MARK: Core Funcs
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConstraints()
        addTargets()
    }
    
    override func prepareForReuse() {
        super.removeFromSuperview()
        acikalama.text = nil
        fiyatLabel.text = nil
        itemImage.image = nil
       
    }
    
    
    //MARK: Make Constraints
    func makeConstraints(){
        contentView.addSubview(itemImageBorder)
        contentView.addSubview(fiyatLabel)
        contentView.addSubview(acikalama)
        contentView.addSubview(buyButton)
        contentView.addSubview(itemImage)
        
        itemImageBorder.snp.makeConstraints { make in
            make.width.height.equalTo(contentView.frame.width)
            make.left.top.equalToSuperview()
        }
        itemImage.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(itemImageBorder)
            make.width.height.equalTo(contentView.frame.width - 20)
        }
        fiyatLabel.snp.makeConstraints { make in
            make.left.equalTo(itemImage)
            make.top.equalTo(itemImageBorder.snp.bottom)
                .offset(10)
        }
        acikalama.snp.makeConstraints { make in
            make.left.right.equalTo(itemImage)
            make.top.equalTo(fiyatLabel.snp.bottom)
                .offset(5)
        }
        buyButton.snp.makeConstraints { make in
            make.left.right.equalTo(itemImage)
            make.bottom.equalToSuperview()
        }
        
    }
    
    func configure(item: Item){
        tempCartItem = CartItem(item: item)
        guard let url = URL(string: item.images?[0] ?? "") else {return}
        let processor = DownsamplingImageProcessor(size: itemImage.bounds.size)
        itemImage.kf.indicatorType = .activity
        itemImage.kf.setImage(with: url)
        fiyatLabel.text = item.price?.toCurrency()
        acikalama.text = item.description ?? ""
    }
    
    
    //MARK: Add Targets
    func addTargets(){
        buyButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: @objc funcs
extension HorizontalItemCollectionViewCell {
    @objc func addToCartTapped(){
  
        delegate?.addToCartTapped(CartItem: tempCartItem!)
    }
}
