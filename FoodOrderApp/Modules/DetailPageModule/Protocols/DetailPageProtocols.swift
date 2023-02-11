//
//  DetailPageProtocols.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 10.02.2023.
//

import Foundation

protocol ViewToPresenterDetailPageProtocol {
    var detailPageInteractor: PresenterToInteractorDetailPageProtocol? { get set }
    var detailPageView: PresenterToViewDetailPageProtocol? { get set }
    func getCartInfo()
    func deleteFromCart(sepet_yemek_id: String)
    func minus()
    func plus()
    func setTotalPrice(price: Int)
    func addToCart(food: Foods, unit: String)
}
protocol PresenterToInteractorDetailPageProtocol {
    var detailPagePresenter: InteractorToPresenterDetailPageProtocol? { get set }
    func getCartInfoI()
    func deleteFromCartI(sepet_yemek_id: String)
    func minusI()
    func plusI()
    func setTotalPriceI(price: Int)
    func addToCartI(food: Foods, unit: String)
}

protocol InteractorToPresenterDetailPageProtocol {
    func cartInfoToPresenter(cartFood: [FoodsCart])
    func unitDataToPresenter(number: Int)
    func totalPriceDataToPresenter(number: Int)
}

protocol PresenterToViewDetailPageProtocol {
    func cartInfoToView(cartFood: [FoodsCart])
    func unitDataToView(number: Int)
    func totalPriceDataToView(number: Int)
}


protocol PresenterToRouterDetailPageProtocol {
    static func createModule(ref: DetailPageViewController)
}
