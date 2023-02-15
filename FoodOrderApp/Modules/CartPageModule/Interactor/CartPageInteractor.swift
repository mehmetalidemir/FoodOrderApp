//
//  CartPageInteractor.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 11.02.2023.
//

import Foundation
import Alamofire

class CartPageInteractor: PresenterToInteractorCartPageProtocol {
    
    var cartPagePresenter: InteractorToPresenterCartPageProtocol?

    func changeCartFoodCountI(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String, sepet_yemek_id: String, yeniAdet: String) {

        let param: Parameters = ["sepet_yemek_id": sepet_yemek_id, "kullanici_adi": "demir"]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: param).response { response in
            if let data = response.data {
                do {
                    let answer = try JSONSerialization.jsonObject(with: data)
                    print(answer)

                } catch {
                    print(error.localizedDescription)
                }
            }
        }

        addToCartI(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yeniAdet)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

            self.getCartFoodI()
        }
    }

    func addToCartI(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String, yemek_siparis_adet: String) {

        if let intUnit = Int(yemek_siparis_adet), let intFiyat = Int(yemek_fiyat) {

            let params: Parameters = ["yemek_adi": yemek_adi, "yemek_resim_adi": yemek_resim_adi, "yemek_fiyat": intFiyat, "yemek_siparis_adet": intUnit, "kullanici_adi": "demir"]

            AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response { response in
                if let data = response.data {
                    do {
                        let cevap = try JSONSerialization.jsonObject(with: data)
                        print(cevap)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }

        } }


    func getCartFoodI() {
        var totalPrice = 0
        var foodTotalPrice = 0
        let emptyAnswerArray: [FoodsCart] = []
        let param: Parameters = ["kullanici_adi": "demir"]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: param).response { response in
            if let data = response.data {
                do {
                    let answer = try JSONDecoder().decode(FoodsCartResponse.self, from: data)

                    if var answerArray = answer.sepet_yemekler {
                        for food in answerArray {
                            foodTotalPrice = Int(food.yemek_siparis_adet!)! * Int(food.yemek_fiyat!)!
                            totalPrice += foodTotalPrice
                        }
                        answerArray.sort(by: { ($0.yemek_adi!) < ($1.yemek_adi!) })
                        self.cartPagePresenter?.sendDataToPresenter(foodsCart: answerArray, totalPrice: totalPrice)
                    }

                } catch {
                    self.cartPagePresenter?.sendDataToPresenter(foodsCart: emptyAnswerArray, totalPrice: 0)
                }
            }
        }
    }

    func deleteCartFoodI(sepet_yemek_id: String, kullanici_adi: String) {
        let param: Parameters = ["sepet_yemek_id": sepet_yemek_id, "kullanici_adi": "demir"]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: param).response { response in
            if let data = response.data {
                do {
                    let answer = try JSONSerialization.jsonObject(with: data)
                    print(answer)
                    self.getCartFoodI()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
