//
//  Extensions.swift
//  CoinList
//
//  Created by Yerem Sargsyan on 14.09.22.
//

import Foundation

extension Double {
    var persent: Percent.Model {
        let type: Percent.Style = self > 0 ? .high : .low
        let value = self < 0 ? self * -1 : self
        let text = "\(value.percent)"
        return Percent.Model(text: text,
                             icon: type.icon,
                             color: type.color,
                             bacgroundColor: type.bacgroundColor)
    }
}

extension Formatter {
    static let number = NumberFormatter()
}

extension Locale {
    static let englishUS: Locale = .init(identifier: "en_US")
}

extension Numeric {
    func formatted(style: NumberFormatter.Style, locale: Locale? = nil) -> String {
        Formatter.number.locale = locale
        Formatter.number.numberStyle = style
        return Formatter.number.string(for: self) ?? ""
    }
    
    var currency:   String { formatted(style: .currency) }
    var currencyUS: String { formatted(style: .currency, locale: .englishUS) }
    var percent:    String { formatted(style: .decimal).replacingOccurrences(of: ".", with: ",") + "%" }
}
