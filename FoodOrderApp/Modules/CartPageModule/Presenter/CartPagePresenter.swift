//
//  CartPagePresenter.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 11.02.2023.
//

import Foundation

class CartPagePresenter: ViewToPresenterCartPageProtocol, InteractorToPresenterCartPageProtocol {
    var cartPageInteractor: PresenterToInteractorCartPageProtocol?
    var cartPageView: PresenterToViewCartPageProtocol?

    func changeCartFoodCount(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String, sepet_yemek_id: String, yeniAdet: String) {
        cartPageInteractor?.changeCartFoodCountI(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, sepet_yemek_id: sepet_yemek_id, yeniAdet: yeniAdet)
    }
    func getCartFood() {
        cartPageInteractor?.getCartFoodI()
    }
    func deleteCartFood(sepet_yemek_id: String, kullanici_adi: String) {
        cartPageInteractor?.deleteCartFoodI(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    func sendDataToPresenter(foodsCart: [FoodsCart], totalPrice: Int) {
        cartPageView?.sendDataToView(foodsCart: foodsCart, totalPrice: totalPrice)
    }
}
