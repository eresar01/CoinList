//
//  Percent.swift
//  CoinList
//
//  Created by Yerem Sargsyan on 13.09.22.
//

import Foundation
import UIKit

struct Percent {
    struct Model {
        var text: String
        var icon: UIImage?
        var color: UIColor
        var bacgroundColor: UIColor
    }

    enum Style {
        case low
        case high
        
        var icon: UIImage? {
            switch self {
            case .low:
                return UIImage(systemName: "arrowtriangle.down.fill")
            case .high:
                return UIImage(systemName: "arrowtriangle.up.fill")
            }
        }
        
        var color: UIColor {
            switch self {
            case .low:
                return AppColors.Text.lowPercentage
            case .high:
                return AppColors.Text.highPercentage
            }
        }
        
        var bacgroundColor: UIColor {
            switch self {
            case .low:
                return AppColors.Background.lowPercentage
            case .high:
                return AppColors.Background.highPercentage
            }
        }
    }

}
