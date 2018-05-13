//
// Created by yokoyas000 on 2018/05/14.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

@testable import TDDExample

class CurrencyRateRepositoryStub: CurrencyRateRepositoryProtocol {
    private let rate: CurrencyRate

    init(rate: CurrencyRate) {
        self.rate = rate
    }

    func get(from: Currency, to: Currency) -> CurrencyRate {
        return self.rate
    }
}

class CurrencyRateRepositorySpy: CurrencyRateRepositoryProtocol {
    typealias CallArg = (from: Currency, to: Currency)
    var callArgs: [CallArg] = []

    func get(from: Currency, to: Currency) -> CurrencyRate {
        self.callArgs.append(CallArg(from: from, to: to))
        return CurrencyRate(0)
    }
}