//
//  ItemDetailViewController.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 30.08.2022.
//

import UIKit
import SnapKit

class ItemDetailViewController: UIViewController {
    
    public var needItem: Item?
    var forAdd: Bool = false
    
    //MARK: UI
    
    private lazy var footer: UIView = {
       let footer = UIView()
        return footer
    }()
    
    private lazy var categoryButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        btn.setTitle(needItem?.category?.name, for: .normal)
        btn.setTitleColor(.orange, for: .normal)
        return btn
    }()
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(PagingImageTableViewCell.self, forCellReuseIdentifier: PagingImageTableViewCell.identifier)
        tableView.register(MidTableViewCell.self, forCellReuseIdentifier: MidTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var addToCartButton: UIButton =  {
       let btn = UIButton()
        btn.setTitle("ADD TO CART", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .orange
        btn.layer.cornerRadius = 2
        return btn
    }()
    
    private lazy var priceLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 17, weight: .bold)
        lbl.textColor = .label
        return lbl
    }()
    
    private lazy var addtoFav: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)), for: .normal)
        btn.tintColor = .red
        return btn
    }()
    
    private lazy var divider: UIView = {
       let div = UIView()
        div.backgroundColor = .secondarySystemBackground
        return div
    }()
    
    
    
    //MARK: Core Funs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MidTableViewCell.delegate = self
        makeConstraints()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        addToCartButton.backgroundColor = .orange
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    //MAKE: Constraints
    func makeConstraints(){
        view.addSubview(footer)
        footer.snp.makeConstraints { make in
            make.right.left.bottom.equalToSuperview()
            make.height.equalTo(90)
        }
        view.addSubview(divider)
        divider.snp.makeConstraints { make in
            make.width.top.equalTo(footer)
            make.height.equalTo(1)
        }
        view.addSubview(addToCartButton)
        addToCartButton.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(40)
            make.centerY.equalTo(footer)
                .offset(-10)
            make.right.equalToSuperview()
                .offset(-24)
        }
        view.addSubview(addtoFav)
        addtoFav.snp.makeConstraints { make in
            make.right.equalTo(addToCartButton.snp.left)
                .offset(-10)
            make.centerY.equalTo(footer)
                .offset(-10)
        }
        
        priceLabel.text = needItem?.price?.toCurrency()
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(footer)
                .offset(-10)
            make.left.equalToSuperview()
                .offset(24)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(footer.snp.top)
        }
        
    }

}


//MARK: TableView Data Delegate
extension ItemDetailViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PagingImageTableViewCell.identifier, for: indexPath) as! PagingImageTableViewCell
            cell.configure(item: needItem!)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MidTableViewCell.identifier, for: indexPath) as! MidTableViewCell
            cell.configure(item: needItem!)
            return cell
            
        default:
            UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 440
        case 1:
           return 100
        default: return 44
        }
        return CGFloat(40)
    }
    
    
    
    
}

extension ItemDetailViewController: MidTableViewCellDelegate {
    func categoryTapped() {
        let vc = CategoryProductsViewController()
        vc.categoryId = needItem?.category?.id
        vc.title = needItem?.category?.name
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ItemDetailViewController {
    func addTargets(){
        addToCartButton.addTarget(self, action: #selector(addtocartTapped), for: .touchUpInside)
    }
    
    @objc func addtocartTapped(){
        forAdd.toggle()
        if forAdd{
            addToCartButton.setTitle("ADDED", for: .normal)
            addToCartButton.backgroundColor = .green
            CartManager.shared.addToCart(item: CartItem(item: needItem!))
        } else {
            addToCartButton.setTitle("ADD TO CART", for: .normal)
            addToCartButton.backgroundColor = .orange
            CartManager.shared.minusCart(item: CartItem(item: needItem!))

        }
        tabBarController?.tabBar.items?[2].badgeValue = CartManager.shared.cart.count > 0 ? String(CartManager.shared.cart.count) : nil
    }
}
