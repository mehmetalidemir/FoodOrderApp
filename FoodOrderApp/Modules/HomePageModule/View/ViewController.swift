//
//  ViewController.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 8.02.2023.
//

import UIKit
import Kingfisher
import Alamofire

class ViewController: UIViewController {
    var homePagePresenterObject: ViewToPresenterHomePageProtocol?
    var allFoods = [Foods]()


    @IBOutlet weak var foodCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        HomePageRouter.createModule(ref: self)
        homePagePresenterObject?.getAllFoods()
    }


}

extension ViewController {
    func setup () {
        foodCollectionView.dataSource = self
        foodCollectionView.delegate = self
    }
}

extension ViewController: PresenterToViewHomePageProtocol {
    func sendDataToView(foods: [Foods]) {
        self.allFoods = foods
        DispatchQueue.main.async {
            self.foodCollectionView.reloadData()
        }
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allFoods.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCollectionViewCell

        let url = "http://kasimadalan.pe.hu/yemekler/resimler/"
        let tempFood = allFoods[indexPath.row]

        if let url = URL(string: "\(url)\(tempFood.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.foodImage.kf.setImage(with: url)
            }

        }
        cell.foodName.text = tempFood.yemek_adi
        cell.foodPrice.text = "\(tempFood.yemek_fiyat!)₺"

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = allFoods[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: food)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let food = sender as? Foods {
                let gidilecekVC = segue.destination as! DetailPageViewController
                gidilecekVC.food = food
            }
        }
      
    }


}
