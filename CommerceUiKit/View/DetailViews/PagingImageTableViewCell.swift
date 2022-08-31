//
//  PagingImageTableViewCell.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 30.08.2022.
//

import UIKit
import SnapKit
import Kingfisher

class PagingImageTableViewCell: UITableViewCell {
    
    static let identifier = "PagingImageTableViewCell"
    
    private lazy var scrollView : UIScrollView = {
       let sv = UIScrollView()
        sv.isPagingEnabled = true
        
        return sv
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollView.removeFromSuperview()
        for xview in scrollView.subviews{
            xview.removeFromSuperview()
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func makeConstraints(){
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.right.bottom.left.top.equalToSuperview()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .red
        selectionStyle = .none
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: Item){
        scrollView.contentSize = CGSize(width: Double(contentView.frame.width) * Double(item.images?.count ?? 0), height: contentView.frame.height)
        for i in 0..<(item.images?.count ?? 0){
            let imageView = UIImageView(frame: CGRect(x: contentView.frame.width * CGFloat(i), y: 0, width: contentView.frame.width, height: contentView.frame.height))
            guard let url = URL(string: item.images?[i] ?? "") else {return}
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.kf.setImage(with: url)
            scrollView.addSubview(imageView)
        }
        
        
        
    }
    
}
