//
//  Double+NumberFormatter.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 21/01/22.
//

import Foundation

extension Double {
    var formattedPrice: String {
        switch self {
        case ..<1_000:
            return String(format: "%.0f", locale: Locale.current, self)
        case 1_000 ..< 999_999:
            return String(format: "%.1f Ribu", locale: Locale.current, self / 1_000).replacingOccurrences(of: ".0", with: "")
        case 1_000_000 ..< 999_999_999:
            return String(format: "%.1f Juta", locale: Locale.current, self / 1_000_000).replacingOccurrences(of: ".0", with: "")
        case 1_000_000_000 ..< 999_999_999_999:
            return String(format: "%.1f Miliyar", locale: Locale.current, self / 1_000_000_000).replacingOccurrences(of: ".0", with: "")
        default:
            return String(format: "%.1f Triliun", locale: Locale.current, self / 1_000_000_000_000).replacingOccurrences(of: ".0", with: "")
        }
    }
}
