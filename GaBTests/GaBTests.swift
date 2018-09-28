//
//  GaBTests.swift
//  GaBTests
//
//  Created by Alain Gabellier on 28/09/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import XCTest
@testable import GaB

class GaBTests: XCTestCase {
    
    var ATVC = AddTransactionVC()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDateToString() {
        let date = Date()
        let stringFormat = "dd-MM-yyyy"
        XCTAssertEqual( dateToString(date, stringFormat), "28-09-2018")
    }
    
    func testFloatToString() {
        let float:Float = 0
        let resp = "0,00"
        XCTAssertEqual(floatToString(float, 2), resp)
    }
    
    func testValidText(){
        let UITF = UITextField()
        UITF.text = "1.4"
        let errorMessage = "Ca marche pas"
        XCTAssertEqual(ATVC.validText(UITF, errorMessage: errorMessage), "1.4")
    }
    
    func testValidNum() {
        let UITF = UITextField()
        UITF.text = "1.0"
        let errorMessage = "Ca marche pas"
        XCTAssertEqual(ATVC.validNum(UITF, errorMessage: errorMessage), 1.0)
    }


}
