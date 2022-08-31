//
//  CartItemTableViewCell.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 31.08.2022.
//

import UIKit
import Kingfisher

protocol CartItemTableViewCellDelegate: AnyObject {
    func addTapped(CartItem : CartItem)
    func miniusTapped(CartItem: CartItem)
}

class CartItemTableViewCell: UITableViewCell {
    
    static let identifier = "CartItemTableViewCell"
    weak var delegate : CartItemTableViewCellDelegate?
    private var tempCartItem: CartItem?
    
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
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    let quantityLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    let descLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 2
        label.textColor = .black.withAlphaComponent(0.5)
        return label
    }()
    
    let priceLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .orange
        return label
    }()
    
    let plusButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        btn.backgroundColor = .clear
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.label.withAlphaComponent(0.5)
            .cgColor
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    let miniusButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("-", for: .normal)
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
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        makeConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: CartItem){
        tempCartItem = item
        itemImage.kf.setImage(with: URL(string: item.item.images?[0] ?? "")!)
        titleLabel.text = item.item.title
        descLabel.text = item.item.description
        priceLabel.text = item.item.price?.toCurrency()
        quantityLabel.text = String(item.quantity)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImage.image = nil
        titleLabel.text = nil
        descLabel.text = nil
        priceLabel.text = nil
        quantityLabel.text = nil
    }
    
    
    //MARK: Constraints
    func makeConstraints(){
        addSubview(itemImage)
        addSubview(itemImageBorder)
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(priceLabel)
        contentView.addSubview(plusButton)
        contentView.addSubview(miniusButton)
        addSubview(quantityLabel)
        
        itemImageBorder.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
                .offset(10)
            make.width.height.equalTo(130)
        }
        
        itemImage.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(itemImageBorder)
            make.width.height.equalTo(110)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImage)
            make.left.equalTo(itemImageBorder.snp.right)
                .offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(titleLabel.snp.bottom)
                .offset(5)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(descLabel.snp.bottom)
                .offset(5)
        }
        
        plusButton.snp.makeConstraints { make in
            make.bottom.equalTo(itemImageBorder)
            make.right.equalToSuperview()
                .offset(-10)
            make.width.height.equalTo(30)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(plusButton)
            make.right.equalTo(plusButton.snp.left)
                .offset(-10)
        }
        
        miniusButton.snp.makeConstraints { make in
            make.bottom.equalTo(plusButton)
            make.right.equalTo(quantityLabel.snp.left)
                .offset(-10)
            make.width.height.equalTo(plusButton)
        }
    }
    
    //MARK: Btn Targets
    func addTargets(){
        plusButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        miniusButton.addTarget(self, action: #selector(miniusTapped), for: .touchUpInside)
    }
    
}


//MARK: @objc Functions
extension CartItemTableViewCell{
    @objc func addTapped(){
        delegate?.addTapped(CartItem: tempCartItem!)
    }
    
    @objc func miniusTapped(){
        delegate?.miniusTapped(CartItem: tempCartItem!)
    }
}
