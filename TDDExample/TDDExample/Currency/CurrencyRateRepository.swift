//
// Created by yokoyas000 on 2018/05/13.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//



protocol CurrencyRateRepositoryProtocol {
    func get(from: Currency, to: Currency) -> CurrencyRate
}

struct CurrencyRateRepository: CurrencyRateRepositoryProtocol {

    private let api: CurrencyRateAPIProtocol

    init(with api: CurrencyRateAPIProtocol) {
        self.api = api
    }

    func get(from leftCurrency: Currency, to rightCurrency: Currency) -> CurrencyRate {
        let rate = self.api.get(from: leftCurrency, to: rightCurrency)
        return CurrencyRate(rate)
    }
}


// - MARK: Entity
// TODO: 別ファイル
struct CurrencyRate {
    let value: Float

    init(_ value: Float) {
        self.value = value
    }
}

protocol CurrencyRateAPIProtocol {
    func get(from: Currency, to: Currency) -> Float
}