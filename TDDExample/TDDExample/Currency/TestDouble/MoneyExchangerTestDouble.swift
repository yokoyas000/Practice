//
// Created by yokoyas000 on 2018/05/14.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

@testable import TDDExample

struct MoneyExchangerStub: MoneyExchangerProtocol {
    private let money: Money

    init(money: Money) {
        self.money = money
    }

    func exchange(money: Money, toCurrency: Currency) -> Money {
        return self.money
    }
}
