//
// Created by yokoyas000 on 2018/05/13.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import XCTest
@testable import TDDExample

class DollarTests: XCTestCase {
    /**
    - [ ] テストのリファクタがしたい！！！！！

    - [x] 通過の足し算
        - [x] $5 + 10 CHF = $10(レートが 2:1 の場合)
        - [x] $5 + $5 = $10
        - [x] レートを利用して両替する
    - [ ] 金額に数値をかけたら期待の金額になること
        - [x] 5 Doll * 2 = 10 Doll
        - [x] 掛け算の副作用がきになる
        - [ ] 少数も対応できないとだめ
        - [x] Dollar と France の重複を削除
        - [x] Dollar と France の比較
    - [x] レートを算出するRepository
   **/

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
        let testMoney = Money(amount: 5, currency: .dollar)

        let actual = testMoney.addition(
            Money(amount: 0, currency: .franc),
            by: MoneyExchangerStub(money: Money(amount: 5, currency: .dollar))
        )
        let expected = Money(amount: 10, currency: .dollar)
        XCTAssertEqual(expected, actual)
    }

}


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