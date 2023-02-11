//
//  DetailPageRouter.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 10.02.2023.
//

import Foundation

class DetailPageRouter{
    static func createModule(ref: DetailPageViewController){
        let presenter = DetailPagePresenter()
        ref.detailPagePresenterObject = presenter
        ref.detailPagePresenterObject?.detailPageInteractor = DetailPageInteractor()
        ref.detailPagePresenterObject?.detailPageInteractor?.detailPagePresenter = presenter
        ref.detailPagePresenterObject?.detailPageView = ref
    }
}
