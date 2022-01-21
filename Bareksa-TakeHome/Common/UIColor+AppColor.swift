//
//  UIColor+AppColor.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 21/01/22.
//

import UIKit

extension UIColor {
    static let productGreen = UIColor(red: 0.888, green: 0.92, blue: 0.865, alpha: 1)
    static let productPurple = UIColor(red: 0.88, green: 0.857, blue: 0.922, alpha: 1)
    static let productBlue = UIColor(red: 0.877, green: 0.91, blue: 0.933, alpha: 1)
    static let appDarkGreen = UIColor(red: 0.294, green: 0.545, blue: 0.149, alpha: 1)
    static let appLightGreen = UIColor(red: 0.51, green: 0.765, blue: 0.255, alpha: 1)
    static let lineGreen = UIColor(red: 0.4, green: 0.502, blue: 0.329, alpha: 1)
    static let linePurple = UIColor(red: 0.447, green: 0.369, blue: 0.612, alpha: 1)
    static let lineBlue = UIColor(red: 0.428, green: 0.595, blue: 0.714, alpha: 1)
    
    static func getProductColor(index: Int) -> UIColor {
        switch index {
        case 0:
           return .productGreen
        case 1:
            return .productPurple
        default:
            return .productBlue
        }
}
    static func getLineColor(index: Int) -> UIColor {
        switch index {
        case 0:
           return .lineGreen
        case 1:
            return .linePurple
        default:
            return .lineBlue
        }
    }
}
