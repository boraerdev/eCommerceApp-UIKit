//
//  CategoryProductsViewController.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 30.08.2022.
//

import UIKit
import Combine


final class CategoryProductsViewController: UIViewController {
    
    public var categoryId: Int?
    private lazy var allCategoryItems: [Item] = []
    var cancellable = Set<AnyCancellable>()
    
    //MARK: UI
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 8, height: (view.frame.width / 2) + 90)
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HorizontalItemCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalItemCollectionViewCell.identifier)
        return collectionView
    }()

    
    //MARK: Core Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        getCategoryItems()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
    }

}

extension CategoryProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allCategoryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalItemCollectionViewCell.identifier, for: indexPath) as! HorizontalItemCollectionViewCell
        cell.configure(item: allCategoryItems[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ItemDetailViewController()
        vc.needItem = allCategoryItems[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


//MARK: ViewModel
extension CategoryProductsViewController{
    func getCategoryItems(){
        Services.shared.getCategoryProducts(categoryId: String(categoryId ?? 0))
            .sink { _ in
            } receiveValue: { [weak self] returned in
                self?.allCategoryItems = returned
                self?.collectionView.reloadData()
            }
            .store(in: &cancellable)
    }
    
}

extension CategoryProductsViewController: HorizontalItemCollectionViewCellDelegate{
    func addToCartTapped(CartItem: CartItem) {
        CartManager.shared.addToCart(item: CartItem)
        tabBarController?.tabBar.items?[2].badgeValue = String(CartManager.shared.cart.count)
    }
}
