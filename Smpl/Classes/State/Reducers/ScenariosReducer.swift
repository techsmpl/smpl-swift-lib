//
//  TestReducer.swift
//  Smpl
//
//  Created by CanGokceaslan on 22.11.2022.
//

import Foundation;
import ReSwift;

struct AddScenarios: Action {
	public var payload:[NSDictionary];
	
	init(payload:[NSDictionary]){
		self.payload = payload;
	}
	
}

struct FetchingScenarios: Action {
	
}


func scenariosReducer(action: Action, state: AppState?) -> AppState {
	var state = state ?? AppState()
	
	switch action {
		case let action as FetchingScenarios:
			state.fetchingSceneraios = true;
		case let action as AddScenarios:
			state.fetchedScenarios = true;
			state.scenarios = (action.payload);
		default:
			break
	}
	
	return state
}
