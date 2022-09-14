//
//  AppColor.swift
//  CoinList
//
//  Created by Yerem Sargsyan on 13.09.22.
//

import Foundation
import UIKit

struct AppColors {
    
    struct Background {
        static let `default` = UIColor(light: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), dark: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        static let lowPercentage = UIColor(light: #colorLiteral(red: 0.9411764706, green: 0.1607843137, blue: 0.2039215686, alpha: 0.09611339443), dark: #colorLiteral(red: 1, green: 0.3019607843, blue: 0.3019607843, alpha: 0.1518156544))
        static let highPercentage = UIColor(light: #colorLiteral(red: 0.2039215686, green: 0.7019607843, blue: 0.2862745098, alpha: 0.1025632139), dark: #colorLiteral(red: 0.4235294118, green: 0.8117647059, blue: 0.3490196078, alpha: 0.152665094))
        static let secondary = UIColor(light: #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1), dark: #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1))
    }
    
    struct Text {
        static let `default` = UIColor(light: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), dark: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        static let secondary = UIColor(light: #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), dark: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1))
        static let ghost = UIColor(light: #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), dark: #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1))
        static let lowPercentage = UIColor(light: #colorLiteral(red: 0.9411764706, green: 0.1607843137, blue: 0.2039215686, alpha: 1), dark: #colorLiteral(red: 1, green: 0.3019607843, blue: 0.3019607843, alpha: 1))
        static let highPercentage = UIColor(light: #colorLiteral(red: 0.2039215686, green: 0.7019607843, blue: 0.2862745098, alpha: 1), dark: #colorLiteral(red: 0.4235294118, green: 0.8117647059, blue: 0.3490196078, alpha: 1))
        static let darkGray = UIColor(light: #colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.2980392157, alpha: 1), dark: #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1))
    }
    
    struct Image {
        static let upPrice = UIColor(light: #colorLiteral(red: 1, green: 0.5764705882, blue: 0.1960784314, alpha: 1), dark: nil)
        static let downPrice = UIColor(light: #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 1), dark: #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1))
        static let lowPercentage = UIColor(light: #colorLiteral(red: 0.9411764706, green: 0.1607843137, blue: 0.2039215686, alpha: 1), dark: #colorLiteral(red: 1, green: 0.3019607843, blue: 0.3019607843, alpha: 1))
        static let highPercentage = UIColor(light: #colorLiteral(red: 0.2039215686, green: 0.7019607843, blue: 0.2862745098, alpha: 1), dark: #colorLiteral(red: 0.4235294118, green: 0.8117647059, blue: 0.3490196078, alpha: 1))
    }
}

public extension UIColor {

    /// Creates a color object that generates its color data dynamically using the specified colors.
    /// - Parameters:
    ///   - light: The color for light mode.
    ///   - dark: The color for dark mode.
    convenience init(light: UIColor, dark: UIColor?) {
        self.init { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return dark ?? light
            }
            return light
        }
    }
}
