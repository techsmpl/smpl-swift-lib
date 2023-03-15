//
//  Messaging.swift
//  Smpl
//
//  Created by CanGokceaslan on 15.03.2023.
//

import Foundation;
import ReSwift;
import Alamofire;

struct EnableMessaging: Action {
	
}

struct SetMessagingToken: Action {
	public var payload:String;
	
	init(payload:String){
		self.payload = payload;
	}
}


func messagingReducer(action: Action, state: AppState?) -> AppState {
	var state = state ?? AppState()
	
	switch action {
		case _ as EnableMessaging:
			print("SMPL Info:: Messaging Enabled");
			state.messagingEnabled = true;
		case let action as SetMessagingToken:
			state.messagingEnabled = true;
			state.messagingToken = action.payload;
			print(state)
		default:
			break
	}
	
	return state
}
