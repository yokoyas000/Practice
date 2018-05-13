//
// Created by yokoyas000 on 2018/05/14.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

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