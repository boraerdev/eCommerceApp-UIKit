//
//  CartViewController.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 30.08.2022.
//

import UIKit
import SnapKit

class CartViewController: UIViewController {
    
    
    //MARK: UI
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(CartItemTableViewCell.self, forCellReuseIdentifier: CartItemTableViewCell.identifier)
        tv.rowHeight = 140
        tv.estimatedRowHeight = 140
        tv.separatorStyle = .none
        return tv
    }()
    
    private lazy var checkBtn: UIButton = {
       let btn = UIButton()
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .orange
        btn.setImage(UIImage(systemName: "chevron.right.circle", withConfiguration: UIImage.SymbolConfiguration( hierarchicalColor: .white)), for: .normal)
        tabBarItem.badgeColor = .orange
        btn.titleLabel?.textColor = .white
        btn.isHidden = true
        return btn
    }()

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
        tableView.dataSource = self
        tableView.frame = view.bounds
        makeConstraints()
        title = "Cart"
        tabBarItem.badgeValue = String(CartManager.shared.cart.count)
        tabBarItem.badgeColor = .orange
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        if CartManager.shared.cartPrice != 0 {
            checkBtn.isHidden = false
            checkBtn.setTitle(CartManager.shared.cartPrice.toCurrency(), for: .normal)
        }
        tabBarItem.badgeValue = String(CartManager.shared.cart.count)
        tabBarItem.badgeColor = .orange

    }
    
    func makeConstraints(){
        view.addSubview(tableView)
        tableView.addSubview(checkBtn)
        checkBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                .offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
      
    }

}


//MARK: TableView Data Delegate
extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CartManager.shared.cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTableViewCell.identifier, for: indexPath) as! CartItemTableViewCell
        cell.delegate = self
        cell.configure(item: CartManager.shared.cart[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ItemDetailViewController()
        vc.needItem = CartManager.shared.cart[indexPath.row].item
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension CartViewController: CartItemTableViewCellDelegate {
    func miniusTapped(CartItem: CartItem) {
        CartManager.shared.minusCart(item: CartItem)
        tabBarController?.tabBar.items?[2].badgeValue = CartManager.shared.cart.count > 0 ? String(CartManager.shared.cart.count) : nil
        checkBtn.setTitle(CartManager.shared.cartPrice.toCurrency(), for: .normal)
        tableView.reloadData()
        checkBtn.isHidden = CartManager.shared.cartPrice > 0 ? false : true
    }
    
    func addTapped(CartItem: CartItem) {
        CartManager.shared.addToCart(item: CartItem)
        checkBtn.setTitle(CartManager.shared.cartPrice.toCurrency(), for: .normal)
        tableView.reloadData()
        tabBarController?.tabBar.items?[2].badgeValue = String(CartManager.shared.cart.count)
        
    }
}

