//
// Created by yokoyas000 on 2018/05/07.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

struct Money: Equatable {
    let currency: Currency
    let amount: Float

    init(amount: Float, currency: Currency) {
        self.amount = amount
        self.currency = currency
    }

    func times(_ multiplier: Int) -> Money {
        return Money(
            amount: self.amount * Float(multiplier),
            currency: self.currency
        )
    }

    func addition(
        _ money: Money,
        by exchanger: MoneyExchangerProtocol
    ) -> Money {
        let exchangedMoney = exchanger.exchange(money: money, toCurrency: self.currency)
        return Money(
            amount: self.amount + exchangedMoney.amount,
            currency: self.currency
        )
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.currency == rhs.currency
            && lhs.amount == rhs.amount
    }
}




//final class Dollar: MoneyProtocol {
//    let currency: String = "USD"
//    private let amount: Int
//
//    init(amount: Int) {
//        self.amount = amount
//    }
//
//    func times(_ multiplier: Int) -> Dollar {
//        return Dollar(amount: self.amount * multiplier)
//    }
//
//    static func == (lhs: Dollar, rhs: Dollar) -> Bool {
//        return lhs.amount == rhs.amount
//    }
//}
//
//final class Franc: MoneyProtocol {
//    let currency: String = "CHF"
//    private let amount: Int
//
//    init(amount: Int) {
//        self.amount = amount
//    }
//
//    func times(_ multiplier: Int) -> Franc {
//        return Franc(amount: self.amount * multiplier)
//    }
//
//    static func == (lhs: Franc, rhs: Franc) -> Bool {
//        return lhs.amount == rhs.amount
//    }
//}
