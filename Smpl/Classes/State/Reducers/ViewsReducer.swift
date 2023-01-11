//
//  TestReducer.swift
//  Smpl
//
//  Created by CanGokceaslan on 22.11.2022.
//

import Foundation;
import ReSwift;

import Alamofire;

struct CheckPopup: Action {
	
}

struct AddViews: Action {
    public var payload:[NSDictionary];
    
    init(payload:[NSDictionary]){
        self.payload = payload;
    }

}
struct RemoveView: Action {
    public var payload:NSDictionary;
    init(payload:NSDictionary){
        self.payload = payload;
    }
}


struct AddTrackingToViews: Action {
	public var payload: NSDictionary;
	init(payload: NSDictionary){
		self.payload = payload;
	}
}

func viewsReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    switch action {
		case _ as CheckPopup:
			if(state.views.count >  0){
				state.popupAwake = true;
				Task{
					await createScenarioTracking(parameters:[
						"scenarioId": mainStore.state.views[0]["scenarioId"]!,
						"deviceUid": mainStore.state.deviceUid!
					])
				}
			}
		case let action as AddViews:
			state.views = action.payload + state.views;
			if(state.views.count > 0){
				state.popupAwake = true;
				Task{
					await createScenarioTracking(parameters:[
						"scenarioId": mainStore.state.views[0]["scenarioId"]!,
						"deviceUid": mainStore.state.deviceUid!
					])
				}
			}
			//print(state.views)
		case let action as RemoveView:
			state.popupAwake = false;
			let currentTracking: NSMutableDictionary = [:];
			state.views = state.views.filter{
				if let scenarioId = $0["scenarioId"] as? String {
					if(scenarioId == action.payload["scenarioId"] as! String){
						//print("Scenario",scenarioId, action.payload["scenarioId"]!)
						currentTracking["trackingId"] = $0["trackingId"];
						currentTracking["startDate"] = $0["startDate"];
						currentTracking["endDate"] = Date();
						currentTracking["closed"] = true;
						currentTracking["duration"] = (currentTracking["endDate"] as! Date).timeIntervalSince(currentTracking["startDate"] as! Date) * 1000;
						//print(currentTracking)
						return false;
					}else{
						return true;
					}
				}else{
					return true;
				}
			};

			Task{
				let dict = NSDictionary(dictionary: currentTracking);
				updateScenarioTracking(parameters: [
					"trackingId": dict["trackingId"]!,
					"analytics":[
						"openedAt": Int((dict["startDate"] as? Date)!.timeIntervalSince1970),
						"closedAt": Int((dict["endDate"] as? Date)!.timeIntervalSince1970),
						"closed": true,
						"duration": Int(truncating: dict["duration"] as! NSNumber)
					]
				])
				try await Task.sleep(nanoseconds: 40_000_000);
				mainStore.dispatch(CheckPopup())
			}
		case let action as AddTrackingToViews:
			state.views = state.views.map { (dict)-> NSDictionary in
				let modifiedDict:NSMutableDictionary = NSMutableDictionary(dictionary: dict);
				let currentScenario = modifiedDict["scenarioId"];
				if(currentScenario as! String == action.payload["scenarioId"] as! String){
					modifiedDict["trackingId"] = action.payload["trackingId"]!;
					modifiedDict["startDate"] = action.payload["startDate"];
					//$0.setValue(action.payload["trackingId"] as! String, forKey: "trackingId")
				}
				return NSDictionary(dictionary: modifiedDict);
			}
		default:
			break
	}

    return state
}
