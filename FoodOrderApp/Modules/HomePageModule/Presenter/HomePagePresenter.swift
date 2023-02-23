//
//  HomePagePresenter.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 8.02.2023.
//

import Foundation

class HomePagePresenter: ViewToPresenterHomePageProtocol, InteractorToPresenterHomePageProtocol {
    var homePageInteractor: PresenterToInteractorHomePageProtocol?
    var homePageView: PresenterToViewHomePageProtocol?

    func searchFoods(searchText: String) {
        homePageInteractor?.searchFoodsI(searchText: searchText)
    }

    func getAllFoods() {
        homePageInteractor?.getAllFoodsInteractor()
    }

    func sendDataToPresenter(foods: [Foods]) {
        homePageView?.sendDataToView(foods: foods)
    }
}
