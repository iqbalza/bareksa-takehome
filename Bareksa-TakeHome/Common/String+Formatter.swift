//
//  String.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 19/01/22.
//

import Foundation

extension String {
    func miliSecFromDate(dateFormat: String) -> Double{
            let formatter = DateFormatter()
            formatter.dateFormat = dateFormat
            let ObjDate = formatter.date(from: self)
                
            return ObjDate!.timeIntervalSince1970*1000
    }
    
    func stringDateFormatter() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id")
        formatter.dateFormat = "yyyy-MM-dd"
        let ObjDate = formatter.date(from: self)
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: ObjDate!)
    }
}
