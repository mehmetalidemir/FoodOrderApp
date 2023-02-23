//
//  DetailPageViewController.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 10.02.2023.
//

import UIKit
import Kingfisher


class DetailPageViewController: UIViewController {

    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var foodPoint: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var foodCountLabel: UILabel!

    var cartFoods: [FoodsCart] = []
    var food: Foods?
    var detailPagePresenterObject: ViewToPresenterDetailPageProtocol?
    var delegate: DetailPageToHomePage?
    var badgeForCart = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        DetailPageRouter.createModule(ref: self)
        let url = "http://kasimadalan.pe.hu/yemekler/resimler/"
        if let f = food {
            if let url = URL(string: "\(url)\(f.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    self.foodImageView.kf.setImage(with: url)
                }
            }

            foodPriceLabel.text = "\(f.yemek_fiyat!)₺"
            foodNameLabel.text = f.yemek_adi
            let totalPrice = f.yemek_fiyat!
            let totalPriceString = String(format: NSLocalizedString("TOTAL_PRICE_LABEL_TEXT", comment: ""), totalPrice)
            totalPriceLabel.text = totalPriceString.localized()


            let randomDouble = Double.random(in: 0.0...5.0)
            let roundedDouble = String(format: "%.1f", randomDouble)
            let reviewCount = Int.random(in: 1...5000)
            let reviewCountString = String(reviewCount)
            foodPoint.text = "★" + roundedDouble + "(\(reviewCountString))"


            let randomPopularLabel = [
                NSLocalizedString("POPULAR_LABEL_1", comment: ""),
                NSLocalizedString("POPULAR_LABEL_2", comment: ""),
                NSLocalizedString("POPULAR_LABEL_3", comment: ""),
                NSLocalizedString("POPULAR_LABEL_4", comment: ""),
                NSLocalizedString("POPULAR_LABEL_5", comment: "")
            ]

            popularLabel.text = randomPopularLabel.randomElement()

        }

    }
    override func viewWillAppear(_ animated: Bool) {
        detailPagePresenterObject?.getCartInfo()
    }
    @IBAction func addToCartButton(_ sender: Any) {

        let alertContreller = UIAlertController(title: "✓", message: NSLocalizedString("ADDED_TO_CART_MESSAGE", comment: ""), preferredStyle: .alert)

        self.present(alertContreller, animated: true)
        let okeyAction = UIAlertAction(title: "Kapat".localized(), style: .cancel) {
            action in
            self.navigationController?.popViewController(animated: true)
        }
        alertContreller.addAction(okeyAction)

        var toplamUnitString = foodCountLabel.text!

        if let existCart = cartFoods.first(where: { $0.yemek_adi! == food?.yemek_adi! }) {
            self.detailPagePresenterObject?.deleteFromCart(sepet_yemek_id: existCart.sepet_yemek_id!, kullanici_adi: "demir")

            let toplamUnit = Int(existCart.yemek_siparis_adet!)! + Int(foodCountLabel.text!)!
            toplamUnitString = String(toplamUnit)
            badgeForCart = cartFoods.count
        } else {
            badgeForCart = cartFoods.count + 1

        }
        delegate?.sendBadgeCountToHomePage(badgeCount: badgeForCart)
        detailPagePresenterObject?.addToCart(food: food!, unit: toplamUnitString)
    }

    @IBAction func buttonMinus(_ sender: Any) {
        if let a = foodCountLabel.text {
            if let a = Int(a) {
                if a > 1 {
                    detailPagePresenterObject?.minus()
                    if let price = food?.yemek_fiyat {
                        detailPagePresenterObject?.setTotalPrice(price: Int(price)!)
                    }
                }
            }
        }
    }


    @IBAction func buttonPlus(_ sender: Any) {
        if let a = foodCountLabel.text {
            if let a = Int(a) {
                if a < 10 {
                    detailPagePresenterObject?.plus()
                    if let price = food?.yemek_fiyat {
                        detailPagePresenterObject?.setTotalPrice(price: Int(price)!)
                    }

                }
            }
        }
    }



}

extension DetailPageViewController: PresenterToViewDetailPageProtocol {


    func cartInfoToView(cartFood: [FoodsCart]) {
        self.cartFoods = cartFood
    }

    func unitDataToView(number: Int) {
        foodCountLabel.text = String(number)
    }

    func totalPriceDataToView(number: Int) {
        totalPriceLabel.text = "Toplam: \(String(number))₺"
    }
}
