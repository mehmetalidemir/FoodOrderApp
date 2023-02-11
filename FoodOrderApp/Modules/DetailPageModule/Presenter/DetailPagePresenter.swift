//
//  DetailPagePresenter.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 10.02.2023.
//

import Foundation

class DetailPagePresenter: ViewToPresenterDetailPageProtocol, InteractorToPresenterDetailPageProtocol {
    var detailPageInteractor: PresenterToInteractorDetailPageProtocol?
    var detailPageView: PresenterToViewDetailPageProtocol?


    func getCartInfo() {
        detailPageInteractor?.getCartInfoI()

    }

    func deleteFromCart(sepet_yemek_id: String) {
        detailPageInteractor?.deleteFromCartI(sepet_yemek_id: sepet_yemek_id)

    }

    func minus() {
        detailPageInteractor?.minusI()

    }

    func plus() {
        detailPageInteractor?.plusI()

    }

    func setTotalPrice(price: Int) {
        detailPageInteractor?.setTotalPriceI(price: price)

    }

    func addToCart(food: Foods, unit: String) {
        detailPageInteractor?.addToCartI(food: food, unit: unit)

    }

    func cartInfoToPresenter(cartFood: [FoodsCart]) {
        detailPageView?.cartInfoToView(cartFood: cartFood)
    }

    func unitDataToPresenter(number: Int) {
        detailPageView?.unitDataToView(number: number)


    }

    func totalPriceDataToPresenter(number: Int) {
        detailPageView?.totalPriceDataToView(number: number)

    }


}
