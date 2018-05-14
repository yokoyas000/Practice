//
// Created by yokoyas000 on 2018/05/13.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

/**
 I部12章: 自分案

 Example:
    let money = Money(amount: 5, currency: .dollar)
    let exchanger = MoneyExchanger(
        by: CurrentRateRepository(
            with: CurrencyRateAPI()
        )
    )
    let addedMoney = testMoney.plus(
        Money(amount: 5, currency: .franc),
        by: exchanger
    )
 **/



// - MARK: MoneyExchanger

protocol MoneyExchangerProtocol {
    func exchange(money: Money, toCurrency: Currency) -> Money
}

struct MoneyExchanger {
    private let rateRepository: CurrencyRateRepositoryProtocol

    init(by repository: CurrencyRateRepositoryProtocol) {
        self.rateRepository = repository
    }

    func exchange(money: Money, toCurrency: Currency) -> Money {
        let rate = self.rateRepository.get(from: money.currency, to: toCurrency)
        return Money(
            amount: money.amount * rate.value,
            currency: toCurrency
        )
    }
}



// - MARK:　CurrencyRateRepository

protocol CurrencyRateRepositoryProtocol {
    func get(from: Currency, to: Currency) -> CurrencyRate
}

struct CurrencyRateRepository: CurrencyRateRepositoryProtocol {

    private let api: CurrencyRateAPIProtocol

    init(with api: CurrencyRateAPIProtocol) {
        self.api = api
    }

    func get(from leftCurrency: Currency, to rightCurrency: Currency) -> CurrencyRate {
        let result = self.api.get(from: leftCurrency, to: rightCurrency)
        return CurrencyRate(result)
    }
}


// - MARK: CurrencyRate

struct CurrencyRate {
    let value: Float

    init(_ value: Float) {
        self.value = value
    }
}

protocol CurrencyRateAPIProtocol {
    func get(from: Currency, to: Currency) -> Float
}