//
//  Bareksa_TakeHomeTests.swift
//  Bareksa-TakeHomeTests
//
//  Created by Iqbal Zauqul Adib on 19/01/22.
//

import XCTest
@testable import Bareksa_TakeHome

class PriceFormatterTest: XCTestCase {

    func test() throws {
        let date = 1000000.0
        let mil = date.formattedPrice
        XCTAssertEqual(mil,"1 Juta")
    }
    
    func testPrice() {
        let date = "2015-06-08"
        XCTAssertEqual(date.stringDateFormatter(), "08 Jun 2015")
    }

}
