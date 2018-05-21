//
// Created by yokoyas000 on 2018/05/22.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import XCTest
@testable import PromiseKit

class PromiseTests: XCTestCase {

    func testFulfill() {
        let promise = Promise<Int> { resolve, _ in
            DispatchQueue.main.async {
                resolve(0)
            }
        }

        let e = self.expectation(description: "promise")

        promise.then { x in
            XCTAssertEqual(0, x)
            e.fulfill()
        }

        self.waitForExpectations(timeout: 3.0)
    }

    func testReject() {
        let promise = Promise<Int> { _, reject in
            DispatchQueue.main.async {
                reject(PromiseError(message: "reject"))
            }
        }

        let e = self.expectation(description: "promise")

        promise.catch { error in
            XCTAssertEqual("reject", (error as! PromiseError).message)
            e.fulfill()
        }

        self.waitForExpectations(timeout: 3.0)
    }

}