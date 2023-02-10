//
//  Foods.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 9.02.2023.
//

import Foundation

import Foundation

class Foods: Codable {
    var yemek_id: String?
    var yemek_adi: String?
    var yemek_resim_adi: String?
    var yemek_fiyat: String?

    init(yemek_id: String, yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String) {
        self.yemek_id = yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
    }
}

class FoodsResponse: Codable {
    var yemekler: [Foods]?
    var success: Int?
}
