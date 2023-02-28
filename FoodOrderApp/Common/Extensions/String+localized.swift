//
//  String+localized.swift
//  FoodOrderApp
//
//  Created by Mehmet Ali Demir on 20.02.2023.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            value: self,
            comment: self
        )
    }
}
