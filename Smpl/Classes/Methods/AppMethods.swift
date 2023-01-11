//
//  AppMethods.swift
//  Alamofire
//
//  Created by CanGokceaslan on 28.11.2022.
//

import Foundation;
import Alamofire;

public func logEvent(key:String, parameters: Parameters){
	let deviceId:String = UIDevice.current.identifierForVendor!.uuidString;
	//logger("Device ID:",deviceId)
	//Fetch Sceneraios if not exists
	Task{
		while((mainStore.state.appId == nil || mainStore.state.apiKey == nil)){
			//logger("Credentials are empty waiting for 0.3 seconds");
			try await Task.sleep(nanoseconds: 0_300_000_000)
		}
		
		if(mainStore.state.fetchingDeviceUid != true && mainStore.state.deviceUid == nil){
			runSmpl(credentials: ["apiKey": mainStore.state.apiKey!, "appId": mainStore.state.appId!], user: mainStore.state.user)
		}
		
		if(mainStore.state.fetchedScenarios != true && mainStore.state.fetchingSceneraios != true){
			await getSceneraios()
		}
		
		
		var headers = HTTPHeaders();
		//headers.add(name: "eventkey", value: "SMPL_USER/SMPLE_LOG_USER_EVENT");
		//headers.add(name: "deviceId", value: "4a549970-cd0a-4a1b-a591-1c1ae88a0eb3");
		headers.add(name: "platform", value: "IOS");
		headers.add(name: "deviceId", value: deviceId);
		headers.add(name:"appId", value: mainStore.state.appId!);
		headers.add(name:"x-api-key",value: mainStore.state.apiKey!);
		headers.add(name: "eventkey", value: key)
		//logger(headers);
		let response = await SmplApi.post(path: "/v2/logevent", params: parameters, headers:headers);
		
		//logger(response);
		
		let currentScenarios:[NSDictionary] = mainStore.state.scenarios.filter{
			if let rules = $0["rules"] as? NSDictionary{
				//logger("RULES",rules)
				if let then = rules["then"] as? NSDictionary {
					if let eventKeys = then["eventKey"] as? NSArray{
						return eventKeys.contains(key)
					}
					return false;
				}
				return false;
			}
			return false;
		};
		
		Task {
			let scenarioIds = currentScenarios.map { $0["scenarioId"]! }
			
			await runScenarios(eventKey: key, params: ["scenarioIds":scenarioIds])
		}
	}

}

private func getSceneraios()async{
	mainStore.dispatch(FetchingScenarios());
	Task{
		var headers = HTTPHeaders();
		//headers.add(name: "eventkey", value: "SMPL_USER/SMPLE_LOG_USER_EVENT");
		headers.add(name:"x-api-key",value: mainStore.state.apiKey!);
		headers.add(name:"appId", value:mainStore.state.appId!);
		//logger(headers);
		let response = await SmplApi.get(path: "/worked-scenarios", params: [:], headers:headers);
		//mainStore.dispatch(AddViews(payload: [response.data?.node]))
		if let node = response.data?["node"] as? NSDictionary{
			//logger(node["configs"]!);
			if let scenarios = node["scenarios"] as? [NSDictionary]{
				mainStore.dispatch(AddScenarios(payload: scenarios))
				//print("Scenarios::",scenarios)
				//logger(mainStore.state.scenarios)
			}
		}
	}
}

private func runScenarios(eventKey:String, params:Parameters)async {
	//print("Params::",params)
	Task{
		var headers = HTTPHeaders();
		//headers.add(name: "eventkey", value: "SMPL_USER/SMPLE_LOG_USER_EVENT");
		headers.add(name:"x-api-key",value: mainStore.state.apiKey!);
		headers.add(name:"appId", value: mainStore.state.appId!);
		//headers.add(name: "deviceId", value: deviceId);
		headers.add(name: "deviceUid", value: mainStore.state.deviceUid! ?? "");
		headers.add(name: "eventkey", value: eventKey)
		//logger(headers);
		let response = await SmplApi.post(path: "/scenario-run", params: params, headers:headers);
		//mainStore.dispatch(AddViews(payload: [response.data?.node]))
		//logger(response);
		if let node = response.data?["node"] as? NSDictionary{
			//logger(node);
			if let configs = node["configs"] as? [NSDictionary]{
				//logger("Config Count:",configs.count)
				mainStore.dispatch(AddViews(payload: configs))
				//logger(mainStore.state.scenarios)
				//print("Configs",configs);
			}
		}
	}
}
