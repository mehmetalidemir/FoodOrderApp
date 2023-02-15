//
//  CartPageProtocols.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 11.02.2023.
//

import Foundation

protocol ViewToPresenterCartPageProtocol {
    var cartPageInteractor: PresenterToInteractorCartPageProtocol? { get set }
    var cartPageView: PresenterToViewCartPageProtocol? { get set }
    func getCartFood()
    func deleteCartFood(sepet_yemek_id: String, kullanici_adi: String)
    func changeCartFoodCount(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String, sepet_yemek_id: String, yeniAdet: String)
}
protocol PresenterToInteractorCartPageProtocol {
    var cartPagePresenter: InteractorToPresenterCartPageProtocol? { get set }
    func getCartFoodI()
    func deleteCartFoodI(sepet_yemek_id: String, kullanici_adi: String)
    func changeCartFoodCountI(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String, sepet_yemek_id: String, yeniAdet: String)
}

protocol InteractorToPresenterCartPageProtocol {
    func sendDataToPresenter(foodsCart: [FoodsCart], totalPrice: Int)
}

protocol PresenterToViewCartPageProtocol {
    func sendDataToView(foodsCart: [FoodsCart], totalPrice: Int)
}

protocol PresenterToRouterCartPageProtocol {
    static func createModule(ref: CartPageViewController)
}
