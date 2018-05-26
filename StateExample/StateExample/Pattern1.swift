//
// Created by yokoyas000 on 2018/05/27.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

/**
 - 参考: http://tech.mercari.com/entry/2017/11/17/161508
 **/
enum Pattern1 {

    class Context<State, Input, Output> {
        typealias Transition = (Input) -> Reducer<State, Output>
        private let _transition: Transition

        init(_ transition: @escaping Transition) {
            self._transition = transition
        }

        func transition(from state: State, by input: Input) -> (next: State, result: Output) {
            return self._transition(input).run(from: state)
        }
    }

    struct Reducer<State, T> {
        typealias Run = (State) -> (State, T)
        private let _run: Run

        init(_ run: @escaping Run) {
            self._run = run
        }

        func run(from state: State) -> (next: State, result: T) {
            return self._run(state)
        }

        func map<U>(_ handler: @escaping (T) -> U) -> Reducer<State, U> {
            return Reducer<State, U> { state in
                let (nextState, result) = self._run(state)
                return (nextState, handler(result))
            }
        }

        func flatMap<U>(_ handler: @escaping (T) -> Reducer<State, U>) -> Reducer<State, U> {
            return Reducer<State, U> { state in
                let (nextState, result) = self._run(state)
                return handler(result).run(from: nextState)
            }
        }
    }


    // - MARK: 使用状況

    struct UseCase {
        init() {
            self.presenter(use: self.context())
        }

        func context() -> Context<SomeState, Event, String> {
            return Context<SomeState, Event, String> { (event: Event) -> Reducer<SomeState, String> in
                return self.doSomething(by: event)
            }
        }

        func presenter(use context: Context<SomeState, Event, String>) {
            let (state, output) = context.transition(from: .first, by: .doSimple)
            // MEMO: UI処理はここ？
            print(state, output)
        }

        private func doSomething(by event: Event) -> Reducer<SomeState, String> {
            switch event {
            case .doSimple:
                return self.reducer()
            }
        }

        private func reducer() -> Reducer<SomeState, String> {
            return Reducer<SomeState, String> { (state: SomeState) in
                // MEMO: ドメイン処理はここ？
                switch state {
                case .first:
                    return (.second, "something")
                case .second:
                    return (.first, "")
                }
            }
        }


        // - MARK:

        enum SomeState {
            case first
            case second
        }

        enum Event {
            case doSimple
        }
    }

}
