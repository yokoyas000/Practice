//
// Created by yokoyas000 on 2018/05/21.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import Foundation

public class Promise<T> {

    typealias FulfillCallback = (T) -> Void
    typealias RejectCallback = (Error) -> Void

    public init( _ exec: (@escaping(T) -> Void, @escaping (Error) -> Void) -> Void) {
        exec(self.onFulfilled, self.onRejected)
    }

    static func resolve<U>(_ value: U) -> Promise<U> {
        return Promise<U> { resolve, _ in
            resolve(value)
        }
    }

    static func reject(_ error: Error) -> Promise<T> {
        return Promise<T> { _, reject in
            reject(error)
        }
    }

    // - MARK: Private

    private var currentState: PromiseState<T, Error> = .pending
    private var fulfillCallbacks: [FulfillCallback] = []
    private var rejectCallbacks: [RejectCallback] = []

    public func then<U>(_ resolve: @escaping (T) -> U) -> Promise<U> {
        switch self.currentState {
        case .pending:
            return Promise<U> { _resolve, _ in
                self.fulfillCallbacks.append { (value: T) -> Void in
                    let result: U = resolve(value)
                    _resolve(result)
                }
            }
        case .fulfilled(let value):
            let result = resolve(value)
            return Promise<U>.resolve(result)
        case .rejected(let error):
            return Promise<U>.reject(error)
        }
    }

    public func `catch`(_ reject: @escaping (Error) -> Void) -> Promise<T> {
        switch self.currentState {
        case .pending, .fulfilled:
            return Promise<T> { _, _ in
                self.rejectCallbacks.append(reject)
            }
        case .rejected(let error):
            reject(error)
            return Promise<T>.reject(error)
        }
    }



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



public enum PromiseState<T, E> {
    case pending
    case fulfilled(T)
    case rejected(E)
}



public struct PromiseError: Error {
    let message: String
}