//
// Created by yokoyas000 on 2018/05/27.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

/**
 - 参考: https://qiita.com/herara_ofnir3/items/4d28bf2615bebcba9b13
 **/

import RxSwift

enum Pattern2 {

    class Context<State, Event> {
        typealias Reducer = (State, Event) -> State

        let didChange: Observable<State>
        var currentState: State {
            return try! self.subject.value()
        }
        private let subject: BehaviorSubject<State>
        private let reducer: Reducer

        init(initialState: State, reducer: @escaping Reducer) {
            self.subject = BehaviorSubject<State>(value: initialState)
            self.didChange = self.subject.asObservable()
            self.reducer = reducer
        }

        func transition(by event: Event) {
            let next = self.reducer(self.currentState, event)
            self.subject.onNext(next)
        }

    }


    // - MARK: 使用感

    struct UseCase {
        init() {
            self.presenter(use: self.context())
        }

        func context() -> Context<SomeState, SomeEvent> {
            return Context<SomeState, SomeEvent>(
                initialState: .first,
                reducer: self.reducer
            )
        }

        func reducer(current state: SomeState, by event: SomeEvent) -> SomeState {
            switch (state, event) {
            case (.first, .doSimple), (.processed, .doSimple):
                self.doSimple()
                return .processing
            case (.processing, _):
                return .processing
            }
        }

        func presenter(use context: Context<SomeState, SomeEvent>) {
            // MEMO: ユーザー入力をどこかしらで受け取る
            context.transition(by: .doSimple)
            _ = context.didChange.subscribe(onNext: { _ in
                // MEMO: UI更新(多分)
            })
        }

        private func doSimple() {
            // MEMO: ドメイン処理(多分)
        }
    }


    // - MARK: 使用状況を想像しやすくするための諸々

    enum SomeState {
        case first
        case processing
        case processed
    }

    enum SomeEvent {
        case doSimple
        //case async
    }

}
