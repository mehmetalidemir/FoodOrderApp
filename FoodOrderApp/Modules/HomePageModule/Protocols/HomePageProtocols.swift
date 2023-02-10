//
//  HomePageProtocols.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 8.02.2023.
//

import Foundation

protocol ViewToPresenterHomePageProtocol {
    var homePageInteractor: PresenterToInteractorHomePageProtocol? { get set }
    var homePageView: PresenterToViewHomePageProtocol? { get set }
    func getAllFoods()
}

protocol PresenterToInteractorHomePageProtocol {
    var homePagePresenter: InteractorToPresenterHomePageProtocol? { get set }
    func getAllFoodsInteractor()

}

protocol InteractorToPresenterHomePageProtocol {
    func sendDataToPresenter(foods: [Foods])

}

protocol PresenterToViewHomePageProtocol {
    func sendDataToView(foods: [Foods])
}


protocol PresenterToRouterHomePageProtocol {
    static func createModule(ref: ViewController)
}
