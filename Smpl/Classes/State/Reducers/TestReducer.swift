//
//  TestReducer.swift
//  Smpl
//
//  Created by CanGokceaslan on 22.11.2022.
//

import Foundation;
import ReSwift;

struct CounterActionIncrease: Action {}
struct CounterActionDecrease: Action {}

func counterReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    switch action {
    case _ as CounterActionIncrease:
        state.counter += 1
    case _ as CounterActionDecrease:
        state.counter -= 1
    default:
        break
    }

    return state
}
