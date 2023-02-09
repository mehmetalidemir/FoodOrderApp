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

}

protocol PresenterToInteractorHomePageProtocol {
    var homePagePresenter: InteractorToPresenterHomePageProtocol? { get set }

}

protocol InteractorToPresenterHomePageProtocol {
}

protocol PresenterToViewHomePageProtocol {
}


protocol PresenterToRouterHomePageProtocol {
    static func createModule(ref: ViewController)
}
