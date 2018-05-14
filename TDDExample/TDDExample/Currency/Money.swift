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

    func times(_ multiplier: Float) -> Money {
        let amount = self.amount * multiplier
        return Money(amount: amount, currency: self.currency)
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.currency == rhs.currency
            && lhs.amount == rhs.amount
    }
}


struct MoneyRateCalculator {
    private let rateRepository: CurrencyRateRepositoryProtocol

    init(rateRepository: CurrencyRateRepositoryProtocol) {
        self.rateRepository = rateRepository
    }

    func plus(augend: Money, addend: Money) -> Money {
        let addendExchanged = self.exchange(money: addend, toCurrency: augend.currency)
        return Money(amount: augend.amount + addendExchanged.amount, currency: augend.currency)
    }

    func exchange(money: Money, toCurrency: Currency) -> Money {
        let rate = self.rateRepository.get(from: money.currency, to: toCurrency)
        let amount = money.amount * rate.value
        return Money(amount: amount, currency: toCurrency)
    }

}


//struct MoneySum {
//    let augend: Money
//    let addend: Money
//
//    func reduce(rateBy repository: CurrencyRateRepositoryProtocol) -> Money {
//        let addendExchanged = addend.exchange(toCurrency: augend.currency, rateBy: repository)
//        return Money(amount: augend.amount + addendExchanged.amount, currency: augend.currency)
//    }
//}
//
//struct MoneyExchange {
//    let money: Money
//
//    func reduce(toCurrency: Currency, rateBy repository: CurrencyRateRepositoryProtocol) -> Money {
//        let rate = repository.get(from: self.money.currency, to: toCurrency)
//        let amount = self.money.amount * rate.value
//        return Money(amount: amount, currency: toCurrency)
//    }
//}
//
//struct MoneyMultiply {
//    let money: Money
//
//    func reduce(_ multiplier: Float) -> Money {
//        let amount = self.money.amount * multiplier
//        return Money(amount: amount, currency: self.money.currency)
//    }
//}
