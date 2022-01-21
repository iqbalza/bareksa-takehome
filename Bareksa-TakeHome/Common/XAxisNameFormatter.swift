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
        return value.formatTime(format: "MMM yy")
    }

}

extension Double {
    func formatTime(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id")
        formatter.dateFormat = format

        return formatter.string(from: Date(timeIntervalSince1970: self/1000))
    }
}
