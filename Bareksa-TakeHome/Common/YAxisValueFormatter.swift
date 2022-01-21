//
//  YAxisValueFormatter.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 21/01/22.
//

import Foundation
import Charts

final class YAxisNameFormater: NSObject, IAxisValueFormatter {
    func stringForValue( _ value: Double, axis _: AxisBase?) -> String {
        let valueString = String(format: "%.0f", value)
        return "\(valueString) %"
    }

}
