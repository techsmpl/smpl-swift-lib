//
//  ScenarioMethods.swift
//  Smpl
//
//  Created by CanGokceaslan on 27.12.2022.
//

import Foundation;
import Alamofire;

public func createScenarioTracking(parameters: Parameters)async{
	Task{
		//let deviceId:String = await UIDevice.current.identifierForVendor!.uuidString;
		let startDate = Date();
		var headers = HTTPHeaders();
		//headers.add(name: "eventkey", value: "SMPL_USER/SMPLE_LOG_USER_EVENT");
		headers.add(name:"x-api-key",value: mainStore.state.apiKey!);
		headers.add(name:"appId", value: mainStore.state.appId!);
		//headers.add(name: "platform", value:"IOS");
		let response = await SmplApi.post(path:"/tracking/create",params:parameters, headers:headers);
		
		//print(response);
		
		if let node = response.data?["node"] as? NSDictionary{
			//logger(node);
			//print("node",node)
			if let trackingId = node["trackingId"] as? String{
				mainStore.dispatch(AddTrackingToViews(payload: [
					"trackingId":trackingId,
					"scenarioId":parameters["scenarioId"] as! String,
					"startDate":startDate
				]
				))
			}
		}
		//print("RESPONSE:",response)
	}
}

public func updateScenarioTracking(parameters: Parameters){
	Task{
		//let deviceId:String = await UIDevice.current.identifierForVendor!.uuidString;
		var headers = HTTPHeaders();
		//headers.add(name: "eventkey", value: "SMPL_USER/SMPLE_LOG_USER_EVENT");
		headers.add(name:"x-api-key",value: mainStore.state.apiKey!);
		headers.add(name:"appId", value: mainStore.state.appId!);
		//headers.add(name: "platform", value:"IOS");
		//print("Parameters::",parameters)
		let response = await SmplApi.put(path:"/tracking/update",params:parameters, headers:headers);
		
		
		//print(response);
		
		if let node = response.data?["node"] as? NSDictionary{
			//logger(node);
			if let trackingId = node["trackingId"] as? [NSDictionary]{
				
			}
		}
		//print("RESPONSE:",response)
	}
}
