//
//  CartPageTableViewCell.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 11.02.2023.
//

import UIKit

class CartPageTableViewCell: UITableViewCell {

    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!

    var delegate: CartPlusOrMinus?
    var indexPath: IndexPath?

    @IBAction func minusButton(_ sender: UIButton) {
        sender.preventRepeatedPresses()
        delegate?.cartMinus(indexPath: indexPath!)
    }

    @IBAction func plusButton(_ sender: UIButton) {
        sender.preventRepeatedPresses()
        delegate?.cartPlus(indexPath: indexPath!)
    }
}
