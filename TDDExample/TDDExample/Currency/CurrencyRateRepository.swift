//
// Created by yokoyas000 on 2018/05/13.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

// - MARK:　CurrencyRateRepository

protocol CurrencyRateRepositoryProtocol {
    func get(from: Currency, to: Currency) -> CurrencyRate
}

struct CurrencyRateRepository: CurrencyRateRepositoryProtocol {

    private let api: CurrencyRateAPIProtocol

    init(with api: CurrencyRateAPIProtocol) {
        self.api = api
    }

    func get(from fromCurrency: Currency, to toCurrency: Currency) -> CurrencyRate {
        let result = self.api.get(from: fromCurrency, to: toCurrency)
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

struct CurrencyRateAPI: CurrencyRateAPIProtocol {

    private let rateList: [Pair: Float] = [
        Pair(from: .dollar, to: .dollar): 1,
        Pair(from: .dollar, to: .franc): 0.5,
        Pair(from: .franc, to: .franc): 1,
        Pair(from: .franc, to: .dollar): 2,
    ]

    func get(from: Currency, to: Currency) -> Float {
        // TODO: force unwrap
        return self.rateList[Pair(from: from, to: to)]!
    }



    struct Pair: Hashable {
        let from: Currency
        let to: Currency

        var hashValue: Int {
            return self.from.rawValue.hashValue ^ self.to.rawValue.hashValue
        }

        static func == (lhs: Pair, rhs: Pair) -> Bool {
            return lhs.from == rhs.from
                && lhs.to == rhs.to
        }
    }
}
