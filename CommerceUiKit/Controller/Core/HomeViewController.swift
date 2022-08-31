//
//  ViewController.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 30.08.2022.
//

import UIKit
import Combine
import SnapKit

final class HomeViewController: UIViewController {
    enum SectionPart: Int{
        case horizontalcategory
        case veritcalCategory
        case horizontalItems
    }
    
    //MARK: UI Elements
    let waitBg: UIView = {
       let bg = UIView()
        bg.backgroundColor = .systemBackground
        return bg
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {sectionKey,_  -> NSCollectionLayoutSection in
            
            let section0headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .fractionalHeight(0.12))
            let section2headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .fractionalHeight(0.05))

            let section0header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: section0headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            let section2header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: section2headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)

            
            guard let section = SectionPart.init(rawValue: sectionKey) else {fatalError("")}
            switch section {
                
//MARK: Sections
            case .horizontalcategory :
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .estimated(120),
                    heightDimension: .estimated(40)),
                                                             subitem: item,
                                                             count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)
                section.boundarySupplementaryItems = [section0header]
                return section
                
                
            case .veritcalCategory:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(140)),
                                                             subitem: item,
                                                             count: 1)
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            
            case .horizontalItems:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 10, trailing: 2)
                
                let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(500)), subitem: item, count: 2)
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(500)),
                                                             subitem: verticalGroup,
                                                             count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.interGroupSpacing = 10
                section.boundarySupplementaryItems = [section2header]
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                return section
                
                
            default:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .estimated(120),
                    heightDimension: .absolute(120)),
                                                             subitem: item,
                                                             count: 1)
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        })
        
        
//MARK: CV Registers
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(HorizontalCategoryCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalCategoryCollectionViewCell.identifier)
        cv.register(VerticalCategoryCollectionViewCell.self, forCellWithReuseIdentifier: VerticalCategoryCollectionViewCell.identfier)
        cv.register(HorizontalCategoryHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HorizontalCategoryHeaderCollectionReusableView.identifier)
        cv.register(HorizontalItemsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HorizontalItemsCollectionReusableView.identifier)
        cv.register(HorizontalItemCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalItemCollectionViewCell.identifier)
        
        
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    //MARK: Variables
    private var allCategories: [Category] = []
    let indicator = UIActivityIndicatorView()
    private lazy var selectedIndex : Int = 0
    var cancellable = Set<AnyCancellable>()
    private lazy var firsatCategoryItems: [Item] = []
    
    
    //MARK: Core Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllCategories()
        createCv()
        makeConstraints()
        getLimitedCategoryItem(id: 0, limit: "/products?offset=0&limit=10")
        navigationController?.navigationBar.tintColor = .orange
        handleAuth()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    
    func createCv(){
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    
    
    //MARK: Constraints
    func makeConstraints(){
        view.addSubview(waitBg)
        waitBg.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        waitBg.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
}



//MARK: CollectionView Data Delegete
extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return allCategories.count
        } else if section == 1 {
            switch allCategories.count{
            case 0:
                return 2
            default: allCategories.count
            }
        }
        else if section == 2 {
            return firsatCategoryItems.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = SectionPart.init(rawValue: indexPath.section) else {fatalError("")}
        switch section {
        case .horizontalcategory:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCategoryCollectionViewCell.identifier, for: indexPath) as! HorizontalCategoryCollectionViewCell
            if allCategories.isEmpty{
                return cell
            } else {
                cell.configuration(allCategories[indexPath.row].name ?? "", curIndex: indexPath.row, selectedIndex: selectedIndex)
            }
            return cell
        case .veritcalCategory:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCategoryCollectionViewCell.identfier, for: indexPath) as! VerticalCategoryCollectionViewCell
            
            if allCategories.isEmpty {
                return cell
            }else {
                cell.configure(category: self.allCategories[indexPath.row])
            }
            return cell
        case .horizontalItems:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalItemCollectionViewCell.identifier, for: indexPath) as! HorizontalItemCollectionViewCell
            if firsatCategoryItems.isEmpty {
                return cell
            } else {
                cell.delegate = self
                cell.configure(item: firsatCategoryItems[indexPath.row])
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            selectedIndex = indexPath.row
            
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 2), at: [.centeredVertically, .centeredHorizontally] , animated: true)
            collectionView.reloadData()

        }
        else if indexPath.section == 1 {
            let vc = CategoryProductsViewController()
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.title = allCategories[indexPath.row].name ?? ""
            vc.categoryId = allCategories[indexPath.row].id ?? 0
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 2 {
            let vc = ItemDetailViewController()
            vc.needItem = firsatCategoryItems[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let section = SectionPart.init(rawValue: indexPath.section) else {fatalError("")}
        switch section {
        case .horizontalcategory:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HorizontalCategoryHeaderCollectionReusableView.identifier, for: indexPath)
            return header
            
        case .veritcalCategory:
            UICollectionReusableView()
            
        case .horizontalItems:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HorizontalItemsCollectionReusableView.identifier, for: indexPath)
            return header
        }
        return UICollectionReusableView()
    }
    
    
    
}

//MARK: ViewModel Funcs

extension HomeViewController{
    func getAllCategories(){
        print("func girdi")
        indicator.startAnimating()
        Services.shared.getAllCategories()
            .sink { _ in
                
            } receiveValue: { [weak self] returned in
                    self?.allCategories = returned
                self?.indicator.stopAnimating()
                self?.collectionView.reloadData()
                self?.waitBg.isHidden = true
            }
            .store(in: &cancellable)
    }
    
    func getLimitedCategoryItem(id: Int, limit: String){
        print("get limit girdi")
        Services.shared.getOfferProducts()
            .sink { tur in
                switch tur{
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("OK")
                }
            } receiveValue: { [weak self] returned in
                self?.firsatCategoryItems = returned
                self?.collectionView.reloadData()
            }
            .store(in: &cancellable)

    }
    
}


//MARK: Auth
extension HomeViewController{
    func handleAuth(){
        if AuthService.shared.accessKey == nil {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}


//MARK: Cell Delegate
extension HomeViewController: HorizontalItemCollectionViewCellDelegate{
    func addToCartTapped(CartItem: CartItem) {
        CartManager.shared.addToCart(item: CartItem)
        tabBarController?.tabBar.items?[2].badgeValue = CartManager.shared.cart.count > 0 ? String(CartManager.shared.cart.count) : nil
        tabBarController?.tabBar.items?[2].badgeColor = .orange
    }
}
