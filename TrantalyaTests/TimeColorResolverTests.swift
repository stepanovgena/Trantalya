//
//  TrantalyaTests.swift
//  TrantalyaTests
//
//  Created by Gennady Stepanov on 16.10.2022.
//

import XCTest
@testable import Trantalya

/// - Tag: TimeColorResolverTests [tests](x-source-tag://TimeColorResolver) entity
class TimeColorResolverTests: XCTestCase {
    var resolver: TimeColorResolver!
    var calendar: Calendar!
    var referenceComponents: DateComponents!
    
    override func setUp() {
        calendar = Calendar.current
        referenceComponents = DateComponents()
        resolver = TimeColorResolver()
    }
    
    func testThatResovesCorrectly() {
        let expectedOutput: [TimeColor] = [
            .future,
            .past
        ]
    
        referenceComponents.hour = 16
        referenceComponents.minute = 35
        let referenceDate = calendar.date(from: referenceComponents)
        let futureDate = "16:55"
        let pastDate = "15:44"
        let input: [String] = [
            futureDate,
            pastDate
        ]
        
        for index in 0..<input.count {
            let actualDate = resolver.getColorForTime(
                time: input[index],
                referenceDate: referenceDate!
            )
            
            XCTAssertEqual(actualDate, expectedOutput[index])
        }
    }
}
