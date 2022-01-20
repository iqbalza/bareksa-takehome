//
//  AppFont.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 20/01/22.
//

import Foundation
import UIKit

extension UIFont {
   static func appFont(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Medium", size: ofSize)!
    }
    
    static func boldAppFont(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat", size: ofSize)!
    }
}
