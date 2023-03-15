//
//  DeviceUserMethods.swift
//  Smpl
//
//  Created by CanGokceaslan on 22.12.2022.
//

import Foundation;
import Alamofire;

public func runSmpl(credentials: NSDictionary, user: Parameters?){

	guard let apiKey: String = credentials["apiKey"] as? String else {
		return;
	}
	guard let appId: String = credentials["appId"] as? String else {
		return;
	}
	
	guard let debugMode: Bool = credentials["debugMode"] as? Bool else {
		return;
	}
	
	if(mainStore.state.apiKey == nil || mainStore.state.appId == nil){
		mainStore.dispatch(AddCredentialsToStore(payload: ["credentials":[
			"apiKey": apiKey,
			"appId": appId,
			"debugMode": debugMode
		],
	   "user": user as Any
	  ]))
	}
	
	mainStore.dispatch(FetchingDeviceUid())
	
	Task{
		var counter = 0;
		while((mainStore.state.messagingEnabled == true && mainStore.state.messagingToken == nil && counter <= 10)){
			//logger("Credentials are empty waiting for 0.3 seconds");
			try await Task.sleep(nanoseconds: 0_300_000_000)
			counter = counter + 1;
			print("Smpl Info:: Messaging Enabled, Token is not taken. Counter:", counter);
		}
		
		let deviceId:String = await UIDevice.current.identifierForVendor!.uuidString;
		var headers = HTTPHeaders();
		//headers.add(name: "eventkey", value: "SMPL_USER/SMPLE_LOG_USER_EVENT");
		headers.add(name:"x-api-key",value: mainStore.state.apiKey!);
		headers.add(name:"appId", value: mainStore.state.appId!);
		headers.add(name: "deviceId", value: deviceId);
		headers.add(name: "platform", value:"IOS");
		if(mainStore.state.messagingToken != nil){
			headers.add(name: "token",value: mainStore.state.messagingToken!)
		}
		print(headers);
		if(user?["systemUserId"] != nil){
			headers.add(name:"systemUserId", value: user!["systemUserId"] as! String)
		}
		let response = await SmplApi.post(path:"/device/credentials",params:(user) ?? [:], headers:headers);
		if let node = response.data?["node"] as? NSDictionary {
			if let deviceUid = node["deviceUid"] as? String {
				mainStore.dispatch(AddDeviceUid(payload:deviceUid))
				mainStore.dispatch(FetchedDeviceUid())
			}
		}
	}
}
