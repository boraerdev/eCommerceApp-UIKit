//
//  Item.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 30.08.2022.
//

import Foundation

struct Item : Codable {
    let id : Int?
    let title : String?
    let price : Int?
    let description : String?
    let category : Category?
    let images : [String]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case price = "price"
        case description = "description"
        case category = "category"
        case images = "images"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        category = try values.decodeIfPresent(Category.self, forKey: .category)
        images = try values.decodeIfPresent([String].self, forKey: .images)
    }

}

extension Int{
    func toCurrency() -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? "NaN"
    }
}
