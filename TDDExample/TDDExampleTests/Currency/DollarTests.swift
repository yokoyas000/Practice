//
// Created by yokoyas000 on 2018/05/13.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import XCTest
@testable import TDDExample

class DollarTests: XCTestCase {
    /**
   - [ ] 通過の足し算
       - [ ] $5 + 10 CHF = $10(レートが 2:1 の場合)
           - [ ] 10 CHF = $5(レートが 2:1 の場合)
       - [x] $5 + $5 = $10
       - [ ] レートを計算する
           - [ ] Dollar -> Franc で 1/2 Dollar になる(Dollar:Franc = 2:1 の場合)
           - [ ] Franc -> Dollar で 2 Franc になる(Dollar:Franc = 2:1 の場合)
   - [ ] 金額に数値をかけたら期待の金額になること
       - [x ] 5 Doll * 2 = 10 Doll
       - [x] 掛け算の副作用がきになる
       - [ ] 少数も対応できないとだめ
       - [x] amount は private
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

    // レートを計算する
    func testExchange() {
        let franc = Money(amount: 10, currency: .franc)
        let dollarFromfranc = franc.exchange(
            to: .dollar,
            by: CurrencyRateRepositoryStub(rate: CurrencyRate(0.5))
        )
        let dollar = Money(amount: 5, currency: .dollar)
        XCTAssertEqual(dollar, dollarFromfranc)

        let franc2 = Money(amount: 20, currency: .franc)
        let dollarFromfranc2 = franc.exchange(
            to: .dollar,
            by: CurrencyRateRepositoryStub(rate: CurrencyRate(0.5))
        )
        let dollar2 = Money(amount: 10, currency: .dollar)
        XCTAssertEqual(dollar2, dollarFromfranc2)

        let dollar3 = Money(amount: 20, currency: .dollar)
        let francFromDollar = franc.exchange(
            to: .dollar,
            by: CurrencyRateRepositoryStub(rate: CurrencyRate(2))
        )
        let franc3 = Money(amount: 10, currency: .franc)
        XCTAssertEqual(franc3, francFromDollar)
    }

    // レートを計算した上で足し算
    func testDollarAndFrancAddition() {
        let dollar = Money(amount: 5, currency: .dollar)
        let franc = Money(amount: 10, currency: .franc)
        let expected = Money(amount: 10, currency: .dollar)
        let actual = dollar.addition(franc)
        XCTAssertEqual(expected, actual)
    }

    // 同通過で足し算
    func testDollarAddition() {
        let lhsfive = Money(amount: 5, currency: .dollar)
        let rhsfive = Money(amount: 5, currency: .dollar)
        let expected = Money(amount: 10, currency: .dollar)
        let actual = lhsfive.addition(rhsfive)
        XCTAssertEqual(expected, actual)
    }

}

extension DollarTests {
    class CurrencyRateRepositoryStub: CurrencyRateRepositoryProtocol {
        private let rate: CurrencyRate

        init(rate: CurrencyRate) {
            self.rate = rate
        }

        func get(from: Currency, to: Currency) -> CurrencyRate {
            return self.rate
        }
    }
}
