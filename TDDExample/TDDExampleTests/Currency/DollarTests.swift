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
        let dollar = Money(amount: 5, currency: .dollar)
        let franc = Money(amount: 10, currency: .franc)
        let rateFrancToDollar: Float = 0.5
        let result = dollar.plus(
            franc,
            rateBy: CurrencyRateRepositoryStub(rate: CurrencyRate(rateFrancToDollar))
        )

        XCTAssertEqual(Money(amount: 10, currency: .dollar), result)
    }

    // - [ ] 通貨の変換
    func testMoneyExchange() {
        let moneyAmount: Float = 5
        let rate: Float = 2
        let result = Money(amount: moneyAmount, currency: .dollar)
            .exchange(
                toCurrency: .franc,
                rateBy: CurrencyRateRepositoryStub(rate: CurrencyRate(rate))
            )
        XCTAssertEqual(
            Money(amount: moneyAmount * rate, currency: .franc),
            result
        )
    }

}

class MoneySumTests: XCTestCase {
    func testReduce() {
        let augend: Float = 2
        let addend: Float = 4
        let sum = MoneySum(
            augend: Money(amount: augend, currency: .dollar),
            addend: Money(amount: addend, currency: .franc)
        )

        let rateFranToDollar: Float = 2
        let reduce = sum.reduce(
            rateBy: CurrencyRateRepositoryStub(rate: CurrencyRate(rateFranToDollar))
        )

        let expectedAmount = augend + (addend * rateFranToDollar)
        XCTAssertEqual(
            Money(amount: expectedAmount, currency: .dollar),
            reduce
        )
    }
}
