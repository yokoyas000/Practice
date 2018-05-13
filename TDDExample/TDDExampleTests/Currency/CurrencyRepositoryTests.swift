//
// Created by yokoyas000 on 2018/05/13.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import XCTest
@testable import TDDExample

class CurrencyRepositoryTests: XCTestCase {

    func testGet() {
        let testValue: Float = 2
        let apiStub = CurrencyRateAPIStub(rate: testValue)
        let repository = CurrencyRateRepository(with: apiStub)

        let expected = CurrencyRate(testValue)
        let actual = repository.get(from: .franc, to: .dollar)
        XCTAssertEqual(expected.value, actual.value)
    }

}

extension CurrencyRepositoryTests {
    struct CurrencyRateAPIStub: CurrencyRateAPIProtocol {

        private let rate: Float

        init(rate: Float) {
            self.rate = rate
        }

        func get(from: Currency, to: Currency) -> Float {
            return self.rate
        }

//    func createValue(from: Currency, to: Currency) -> Float {
//        switch (from, to) {
//        case (.dollar, .dollar), (.franc, .franc):
//            return 1
//        case (.dollar, .franc) :
//            return 0.5
//        case (.franc, .dollar) :
//            return 2
//        }
//    }
    }
}
