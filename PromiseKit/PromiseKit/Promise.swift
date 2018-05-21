//
// Created by yokoyas000 on 2018/05/21.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import Foundation

public class Promise<T> {
    typealias FulfillCallback = (T) -> Void
    typealias RejectCallback = (Error) -> Void

    public init(_ executor: (@escaping (T) -> Void, @escaping (Error) -> Void) -> Void) {
        executor(self.onFulfilled, self.onRejected)
    }

    public func then<U>(_ onFulfilled: @escaping (T) -> U) -> Promise<U> {
        switch self.currentState {
        case .pending:
            return Promise<U> { resolve, _ in
                self.fulfillCallbacks.append { value -> Void in
                    let result = onFulfilled(value)
                    resolve(result)
                }
            }
        case .fulfilled(let value):
            let result = onFulfilled(value)
            return Promise<U>.resolve(result)
        case .rejected(let error):
            return Promise<T>.reject(error)
        }

    }

    public func `catch`(_ onRejected: @escaping (Error) -> Void) -> Promise<T> {
        switch self.currentState {
        case .pending, .fulfilled:
            return Promise<T> { _, _ in
                self.rejectCallbacks.append { error in
                    onRejected(error)
                }
            }
        case .rejected(let error):
            return Promise<T>.reject(error)
        }
    }

    static func resolve<U>(_ value: U) -> Promise<U> {
        return Promise<U> { resolve, _ in
            resolve(value)
        }
    }

    static func reject<T>(_ error: Error) -> Promise<T> {
        return Promise<T> { _, reject in
            reject(error)
        }
    }

    // - MARK: Private

    private var currentState: State<T, Error> = .pending
    private var fulfillCallbacks: [FulfillCallback] = []
    private var rejectCallbacks: [RejectCallback] = []

    private func onFulfilled(value: T) {
        switch self.currentState {
        case .pending:
            self.currentState = .fulfilled(value)
            self.fulfillCallbacks.forEach { callback in
                callback(value)
            }
        default:
            return
        }
    }

    private func onRejected(error: Error) {
        switch self.currentState {
        case .pending:
            self.currentState = .rejected(error)
            self.rejectCallbacks.forEach { callback in
                callback(error)
            }
        default:
            return
        }
    }
}



public enum State<T, E> {
    case pending
    case fulfilled(T)
    case rejected(E)

    public enum Result {
        case success(T)
        case failure(E)
    }
}



public struct PromiseError: Error {
    let message: String
}