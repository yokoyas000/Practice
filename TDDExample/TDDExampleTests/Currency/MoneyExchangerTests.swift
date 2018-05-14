//
// Created by yokoyas000 on 2018/05/14.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import XCTest
@testable import TDDExample

class MoneyExchangerTests: XCTestCase {

    func testExchange() {
        let testRateValue: Float = 2
        let testMoney = Money(amount: 5, currency: .dollar)
        let exchanger = MoneyExchanger(
            by: CurrencyRateRepositoryStub(rate: CurrencyRate(testRateValue))
        )
        let testExchangeCurrency = Currency.franc

        let expected = Money(
            amount: testMoney.amount * testRateValue,
            currency: testExchangeCurrency
        )

        let actual = exchanger.exchange(money: testMoney, toCurrency: testExchangeCurrency)

        XCTAssertEqual(expected, actual)
    }

}
