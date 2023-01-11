//
//  Store.swift
//  Smpl
//
//  Created by CanGokceaslan on 22.11.2022.
//

import Foundation;
import ReSwift;
import Alamofire;

func combineReducers<T>(_ first: @escaping Reducer<T>, _ remainder: Reducer<T>...) -> Reducer<T> {
    return { action, state in
        let firstResult = first(action, state)
        let result = remainder.reduce(firstResult) { result, reducer in
            return reducer(action, result)
        }
        return result
    }
}

struct AppState {
	public var popupAwake: Bool = false;
	public var apiKey: String? = nil;
	public var appId: String? = nil;
	public var debugMode: Bool = true;
	public var fetchingDeviceUid: Bool = false;
	public var fetchedDeviceUid: Bool = false;
	public var deviceUid: String? = nil;
    public var counter: Int = 0;
	public var views: [NSDictionary] = [];
	public var currentViewAnalytics: NSDictionary = [:];
	public var scenarios: [NSDictionary] = [];
	public var fetchingSceneraios: Bool = false;
	public var fetchedScenarios: Bool = false;
	public var user: Parameters? = nil;
}

let mainStore = Store<AppState>(
    reducer: combineReducers(counterReducer, viewsReducer, scenariosReducer, userDeviceInformationsReducer),
	state: nil
);
