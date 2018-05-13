//
// Created by yokoyas000 on 2018/05/07.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

struct Money: Equatable {
    let currency: Currency
    private let amount: Int

    init(amount: Int, currency: Currency) {
        self.amount = amount
        self.currency = currency
    }

    func times(_ multiplier: Int) -> Money {
        return Money(
            amount: self.amount * multiplier,
            currency: self.currency
        )
    }

    func addition(_ money: Money) -> Money {
        return Money(
            amount: self.amount + money.amount,
            currency: self.currency
        )
    }

    func exchange(
        to currency: Currency,
        by repository: CurrencyRateRepositoryProtocol
    ) -> Money {
        let rate = repository.get(from: self.currency, to: currency)
        return Money(
            //amount: self.amount * rate.value,
            amount: self.amount,
            currency: .dollar
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
