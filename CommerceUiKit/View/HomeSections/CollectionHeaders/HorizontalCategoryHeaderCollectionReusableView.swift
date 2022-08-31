//
//  HorizontalCategoryHeaderCollectionReusableView.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 30.08.2022.
//

import UIKit

//MARK: HorizontalCategoryHeaderCollectionReusableView
class HorizontalCategoryHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "HorizontalCategoryHeaderCollectionReusableView"
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(Row1HorizontalCategoryHeaderCollectionReusableView.self, forCellReuseIdentifier: Row1HorizontalCategoryHeaderCollectionReusableView.identifier)
        tableView.register(Row2HorizontalCategoryHeaderCollectionReusableView.self, forCellReuseIdentifier: Row2HorizontalCategoryHeaderCollectionReusableView.identifier)
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.left.bottom.top.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HorizontalCategoryHeaderCollectionReusableView: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Row1HorizontalCategoryHeaderCollectionReusableView.identifier, for: indexPath) as! Row1HorizontalCategoryHeaderCollectionReusableView
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Row2HorizontalCategoryHeaderCollectionReusableView.identifier, for: indexPath) as! Row2HorizontalCategoryHeaderCollectionReusableView
            return cell

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Row1HorizontalCategoryHeaderCollectionReusableView.identifier, for: indexPath)
            return cell
        }
    }
}


//MARK: Row1HorizontalCategoryHeaderCollectionReusableView
class Row1HorizontalCategoryHeaderCollectionReusableView: UITableViewCell{
    static let identifier = "Row1HorizontalCategoryHeaderCollectionReusableView"
    
    private lazy var dashButton: UILabel = {
       let label = UILabel()
        label.text = "aldinaldin"
        return label
    }()
    private lazy var heartButton: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)), for: .normal)
        btn.tintColor = .label.withAlphaComponent(0.5)

        return btn
    }()
    private lazy var plusButton: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(systemName: "bell", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)), for: .normal)
        btn.tintColor = .label.withAlphaComponent(0.5)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeContraints()
        selectionStyle = .none
    }
    
    func makeContraints(){
        contentView.addSubview(dashButton)
        contentView.addSubview(heartButton)
        contentView.addSubview(plusButton)
        dashButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
                .offset(10)
            make.centerY.equalToSuperview()
        }
        heartButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
                .offset(-10)
            make.centerY.equalToSuperview()
        }
        plusButton.snp.makeConstraints { make in
            make.right.equalTo(heartButton.snp.left)
                .offset(-10)
            make.centerY.equalToSuperview()
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: Row2HorizontalCategoryHeaderCollectionReusableView
class Row2HorizontalCategoryHeaderCollectionReusableView: UITableViewCell{
    static let identifier = "Row2HorizontalCategoryHeaderCollectionReusableView"
    
    private lazy var searchbar: UISearchBar = {
       let searchb = UISearchBar()
        searchb.searchBarStyle = .minimal
        return searchb
    }()
    
    private lazy var searchButon: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)), for: .normal)
        btn.tintColor = .label.withAlphaComponent(0.5)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
        selectionStyle = .none
    }
    
    func makeConstraints(){
        contentView.addSubview(searchbar)
        contentView.addSubview(searchButon)
        searchbar.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(searchButon.snp.left)
                .offset(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
        }
        searchButon.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
