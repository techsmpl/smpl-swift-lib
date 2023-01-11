//
//  TestReducer.swift
//  Smpl
//
//  Created by CanGokceaslan on 22.11.2022.
//

import Foundation;
import ReSwift;
import Alamofire;

struct FetchingDeviceUid: Action {
	
}

struct FetchedDeviceUid: Action {
	
}

struct AddCredentialsToStore: Action {
	public var payload:NSDictionary;
	
	init(payload:NSDictionary){
		self.payload = payload;
	}
}

struct AddDeviceUid: Action {
	public var payload:String;
	
	init(payload:String){
		self.payload = payload;
	}
}

func userDeviceInformationsReducer(action: Action, state: AppState?) -> AppState {
	var state = state ?? AppState()
	
	switch action {
		// SETS API KEY AND APP ID into ReSwift Main Store to use again
		case let action as AddCredentialsToStore:
			let credentials = action.payload["credentials"] as! NSDictionary;
			state.apiKey = credentials["apiKey"] as? String;
			state.appId = credentials["appId"] as? String;
			state.debugMode = credentials["debugMode"] as! Bool;
			if(action.payload["user"] != nil){
				state.user = action.payload["user"] as? Parameters;
			}
		// THIS REDUCER HOLDS THE INFORMATION IF DEVICEUID is currently being fetched
		case _ as FetchingDeviceUid:
			state.fetchingDeviceUid = true;
		// This reducers sets the store's deviceUid
		case let action as AddDeviceUid:
			state.deviceUid = action.payload;
			state.fetchingDeviceUid = false;
		// THIS REDUCER HOLDS THE INFORMATION IF DEVICEUID is fetched
		case _ as FetchedDeviceUid:
			state.fetchedDeviceUid = true;
		default:
			break
	}
	
	return state
}
