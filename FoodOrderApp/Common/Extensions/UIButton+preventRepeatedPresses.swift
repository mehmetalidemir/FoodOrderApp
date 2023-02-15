//
//  Extensions.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 13.02.2023.
//

import UIKit

extension UIButton {
    func preventRepeatedPresses(inNext seconds: Double = 1) {
        self.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            self.isUserInteractionEnabled = true
        }
    }
}
