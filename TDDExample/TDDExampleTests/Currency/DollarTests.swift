//
// Created by yokoyas000 on 2018/05/13.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import XCTest
@testable import TDDExample

class DollarTests: XCTestCase {

    // 通過の乗算
    func testMoneyMultiplication() {
        let five = Money(amount: 5, currency: .dollar)
        XCTAssertEqual(Money(amount: 10, currency: .dollar), five.times(2))
        XCTAssertEqual(Money(amount: 15, currency: .dollar), five.times(3))
    }

    // 通過の種類の比較
    func testCompareDollarToFrance() {
        let dollar = Money(amount: 5, currency: .dollar)
        let franc = Money(amount: 5, currency: .franc)
        XCTAssertNotEqual(dollar, franc)
    }

    // レートを計算した上で足し算
    func testDollarAndFrancAddition() {
        let dollar = Money(amount: 5, currency: .dollar)
        let franc = Money(amount: 10, currency: .franc)
        let rateFrancToDollar: Float = 0.5
        let calculator = MoneyRateCalculator(rateRepository: CurrencyRateRepositoryStub(rate: CurrencyRate(rateFrancToDollar)))
        let result = calculator.plus(augend: dollar, addend: franc)

        XCTAssertEqual(Money(amount: 10, currency: .dollar), result)
    }

    // - [ ] 通貨の変換
    func testMoneyExchange() {
        let moneyAmount: Float = 5
        let rate: Float = 2
        let calculator = MoneyRateCalculator(rateRepository: CurrencyRateRepositoryStub(rate: CurrencyRate(rate)))
        let result = calculator.exchange(
            money: Money(amount: moneyAmount, currency: .dollar),
            toCurrency: .franc
        )

        XCTAssertEqual(
            Money(amount: moneyAmount * rate, currency: .franc),
            result
        )
    }

}
