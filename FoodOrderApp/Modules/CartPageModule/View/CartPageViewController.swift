//
//  CartPageViewController.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 11.02.2023.
//

import UIKit

class CartPageViewController: UIViewController {
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonDeleteAll: UIBarButtonItem!
    @IBOutlet weak var totalPriceLabel2: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!

    var totalCartPrice = 0
    var cartPagePresenterObject: ViewToPresenterCartPageProtocol?
    var allFoodsCart = [FoodsCart]()

    override func viewDidLoad() {
        super.viewDidLoad()
        CartPageRouter.createModule(ref: self)
        cartTableView.dataSource = self
        cartTableView.delegate = self
        self.cartTableView.estimatedRowHeight = 200
        self.cartTableView.rowHeight = UITableView.automaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        cartPagePresenterObject?.getCartFood()
    }

    @IBAction func buttonDeleteAll(_ sender: Any) {
        indicator.startAnimating()
        let alert = UIAlertController(title: "Sepeti boşalt".localized(), message: "Sepetinizdeki tüm ürünlerin silineceğinden emin misiniz?".localized(), preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Tamam".localized(), style: .cancel) { action in
            for i in self.allFoodsCart {
                self.cartPagePresenterObject?.deleteCartFood(sepet_yemek_id: i.sepet_yemek_id!, kullanici_adi: i.kullanici_adi!)
            }
        }
        let cancelAction = UIAlertAction(title: "İptal".localized(), style: .default)
        indicator.stopAnimating()
        alert.addAction(okeyAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }

    @IBAction func buttonConfirmCart(_ sender: Any) {
        if totalCartPrice > 0 {
            let alert = UIAlertController(title: "Siparişiniz Alındı".localized(), message: "15 dakikada kapınızda".localized(), preferredStyle: .alert)
            let okeyAction = UIAlertAction(title: "Tamam".localized(), style: .default)
            alert.addAction(okeyAction)
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Sepetiniz Boş".localized(), message: "Sepetinize ürün ekleyip devam edebilirsiniz.".localized(), preferredStyle: .alert)
            let okeyAction = UIAlertAction(title: "Tamam".localized(), style: .default)
            alert.addAction(okeyAction)
            self.present(alert, animated: true)
        }
    }
}

extension CartPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFoodsCart.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartPageTableViewCell

        cell.delegate = self
        cell.indexPath = indexPath

        let url = "http://kasimadalan.pe.hu/yemekler/resimler/"
        let tempFood = allFoodsCart[indexPath.row]

        if let url = URL(string: "\(url)\(tempFood.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.foodImageView.kf.setImage(with: url)
            }
        }
        cell.foodNameLabel.text = tempFood.yemek_adi
        if let foodPrice = Int(tempFood.yemek_fiyat!), let foodAdetInt = Int(tempFood.yemek_siparis_adet!) {
            let totalFoodPrice = foodPrice * foodAdetInt
            cell.foodPrice.text = "\(totalFoodPrice)₺"
            cell.unitLabel.text = "\(tempFood.yemek_siparis_adet!)"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil".localized()) { (contextualAction, view, bool) in

            let food = self.allFoodsCart[indexPath.row]
            let alertTitle = NSLocalizedString("Sil".localized(), comment: "Title for delete alert")
            let confirmationMessage = String(format: NSLocalizedString("%@ silinsin mi?".localized(), comment: "Confirmation message when deleting an item"), food.yemek_adi!)
            let alert = UIAlertController(title: alertTitle, message: confirmationMessage, preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "İptal".localized(), style: .cancel)
            alert.addAction(cancelAction)
            let yesAction = UIAlertAction(title: "Tamam".localized(), style: .destructive) { action in
                self.cartPagePresenterObject?.deleteCartFood(sepet_yemek_id: food.sepet_yemek_id!, kullanici_adi: food.kullanici_adi!)
            }
            alert.addAction(yesAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension CartPageViewController: PresenterToViewCartPageProtocol {
    func sendDataToView(foodsCart: [FoodsCart], totalPrice: Int) {
        indicator.startAnimating()

        self.allFoodsCart = foodsCart
        self.totalCartPrice = totalPrice
        self.totalPriceLabel.text = "\(String(totalPrice))₺"
        self.totalPriceLabel2.text = "\(String(totalPrice))₺"

        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }

        if allFoodsCart.isEmpty {
            buttonDeleteAll.isEnabled = false
        }
        else {
            buttonDeleteAll.isEnabled = true
        }
        indicator.stopAnimating()

        if let tabItems = tabBarController?.tabBar.items {
            let cartItem = tabItems[1]
            let temp = self.allFoodsCart.count
            if temp > 0 {
                cartItem.badgeValue = String(temp)
            } else {
                cartItem.badgeValue = nil
            }
        }
    }
}

extension CartPageViewController: CartPlusOrMinus {

    func cartPlus(indexPath: IndexPath) {
        indicator.startAnimating()

        let cartFood = allFoodsCart[indexPath.row]
        var unit = cartFood.yemek_siparis_adet
        var unitInt = Int(unit!)!
        if unitInt < 30 {
            unitInt += 1
            unit = String(unitInt)
            cartPagePresenterObject?.changeCartFoodCount(yemek_adi: cartFood.yemek_adi!, yemek_resim_adi: cartFood.yemek_resim_adi!, yemek_fiyat: cartFood.yemek_fiyat!, sepet_yemek_id: cartFood.sepet_yemek_id!, yeniAdet: unit!)
        }
        else {
            let alert = UIAlertController(title: "En fazla 30 adet Sipariş verebilirsiniz.".localized(), message: "", preferredStyle: .alert)

            let okeyAction = UIAlertAction(title: "Tamam".localized(), style: .cancel)
            alert.addAction(okeyAction)
            self.present(alert, animated: true)
            indicator.stopAnimating()
        }
    }

    func cartMinus(indexPath: IndexPath) {
        indicator.startAnimating()

        let cartFood = allFoodsCart[indexPath.row]
        var unit = cartFood.yemek_siparis_adet
        var unitInt = Int(unit!)!
        if unitInt > 1 {
            unitInt -= 1
            unit = String(unitInt)
            cartPagePresenterObject?.changeCartFoodCount(yemek_adi: cartFood.yemek_adi!, yemek_resim_adi: cartFood.yemek_resim_adi!, yemek_fiyat: cartFood.yemek_fiyat!, sepet_yemek_id: cartFood.sepet_yemek_id!, yeniAdet: unit!)
        }
        else if unitInt == 1 {
            let alertTitle = NSLocalizedString("Ürün silinecek".localized(), comment: "Title for delete confirmation alert")
            let confirmationMessage = String(format: NSLocalizedString("Sepetinizde 1 adet %@ var. Silmek istediğinize Emin misiniz?".localized(), comment: "Confirmation message when deleting an item from cart"), cartFood.yemek_adi!)
            let alert = UIAlertController(title: alertTitle, message: confirmationMessage, preferredStyle: .alert)

            let okeyAction = UIAlertAction(title: "Tamam".localized(), style: .cancel) { action in
                self.cartPagePresenterObject?.deleteCartFood(sepet_yemek_id: cartFood.sepet_yemek_id!, kullanici_adi: cartFood.kullanici_adi!)
            }
            let cancelAction = UIAlertAction(title: "İptal".localized(), style: .default)
            alert.addAction(okeyAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
            indicator.stopAnimating()
        }
        else {
            print("Hata".localized())
            indicator.stopAnimating()
        }
    }
}
