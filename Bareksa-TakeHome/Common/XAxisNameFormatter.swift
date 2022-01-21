//
//  XAxisNameFormatter.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 19/01/22.
//

import Foundation
import Charts
final class XAxisNameFormater: NSObject, IAxisValueFormatter {
    func stringForValue( _ value: Double, axis _: AxisBase?) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id")
        formatter.dateFormat = "MMM yy"

        return formatter.string(from: Date(timeIntervalSince1970: value/1000))
    }

}
