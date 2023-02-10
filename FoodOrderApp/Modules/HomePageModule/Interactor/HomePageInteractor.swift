//
//  HomePageInteractor.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 8.02.2023.
//

import Foundation
import Alamofire



class HomePageInteractor: PresenterToInteractorHomePageProtocol {
    var homePagePresenter: InteractorToPresenterHomePageProtocol?
    var allFoods = [Foods]()


    func getAllFoodsInteractor() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            if let data = response.data {
                do {
                    let answer = try JSONDecoder().decode(FoodsResponse.self, from: data)
                    if let foods = answer.yemekler {
                        self.allFoods = foods
                        self.homePagePresenter?.sendDataToPresenter(foods: foods)
                    }
                } catch {
                    print(error.localizedDescription.description)
                }
            }
        }
    }

}
