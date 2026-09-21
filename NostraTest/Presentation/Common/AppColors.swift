//
//  AppColors.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import UIKit

enum AppColors {
    static let primaryGreen = UIColor(hex: "#55B26E")
    static let secondaryGreen = UIColor(hex: "#EAF7EE")
    static let primaryGray = UIColor(hex: "#757575")
}

extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
