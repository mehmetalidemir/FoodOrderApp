//
//  Protocols.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 10.02.2023.
//

import Foundation

protocol DetailPageToHomePage {
    func sendBadgeCountToHomePage(badgeCount: Int)
}

protocol OrderDetailToCartPage {
    func deleteCart()
}

protocol CartPlusOrMinus {
    func cartPlus(indexPath: IndexPath)
    func cartMinus(indexPath: IndexPath)
}
