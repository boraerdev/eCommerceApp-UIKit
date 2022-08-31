//
//  MidTableViewCell.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 30.08.2022.
//

import UIKit
import SnapKit

protocol MidTableViewCellDelegate {
    func categoryTapped()
}

class MidTableViewCell: UITableViewCell {
    
    static public var delegate : MidTableViewCellDelegate?
    static let identifier  = "MidTableViewCell"
    private var tempItem : Item?
    
    private lazy var categoryButton: UIButton = {
       let btn = UIButton()
        btn.setTitleColor(.orange, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        return btn
    }()
    
    private lazy var titleLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 22, weight: .regular)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var descLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 17, weight: .regular)
        lbl.textColor = .black.withAlphaComponent(0.5)
        lbl.numberOfLines = 0
        return lbl
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
        addTargets()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints(){
        contentView.addSubview(categoryButton)
        categoryButton.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
                .offset(10)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(categoryButton)
            make.top.equalTo(categoryButton.snp.bottom)
                .offset(10)
        }
        
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(10)
            make.top.equalTo(titleLabel.snp.bottom)
                .offset(10)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descLabel.text = nil
        titleLabel.text = nil
        categoryButton.titleLabel?.text = nil
    }
    
    func configure(item: Item){
        categoryButton.setTitle(item.category?.name, for: .normal)
        tempItem = item
        titleLabel.text = item.title
        descLabel.text = item.description
    }
    
    func addTargets(){
        categoryButton.addTarget(self, action: #selector(categoryTapped), for: .touchUpInside)
    }
    
    
}
extension MidTableViewCell {
    @objc func categoryTapped(){
        MidTableViewCell.delegate?.categoryTapped()
    }
}
