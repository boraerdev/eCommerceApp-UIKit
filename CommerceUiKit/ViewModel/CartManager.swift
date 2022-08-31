//
//  CartManager.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 31.08.2022.
//

import Foundation

protocol CartManagerDelegate: AnyObject{
    func changedData(item: [CartItem])
}

class CartManager{
    static let shared = CartManager()
    var cart : [CartItem] = []
    lazy var cartPrice = 0
    
    weak var  delegate : CartManagerDelegate?
    
    func addToCart(item: CartItem){
        
        if let index = cart.firstIndex(where: {item.item.id == $0.item.id}){
            var qua = item.quantity
            qua += 1
            cart[index] = CartItem(item: item.item, quantity: qua)
        } else {
            cart.append(CartItem(item: item.item))
        }
        var top = 0
        for i in cart{
            top += (i.item.price ?? 0) * i.quantity
        }
        cartPrice = top
    }
    
    func minusCart(item: CartItem){
        var top = 0
        if let index = cart.firstIndex(where: {item.item.id == $0.item.id}){
            if item.quantity > 1{
                var qua = item.quantity
                qua -= 1
                cart[index] = CartItem(item: item.item, quantity: qua)
                for i in cart{
                    top += (i.item.price ?? 0) * i.quantity
                }
                cartPrice = top
            }else if item.quantity == 1 {
                cart.remove(at: index)
                for i in cart{
                    top += (i.item.price ?? 0) * i.quantity
                }
                cartPrice = top

            }
        }
    }
}

struct CartItem: Equatable{
    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.item.id == rhs.item.id
    }
    
    var item: Item
    var quantity: Int = 1
}
