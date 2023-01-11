//
//  Logger.swift
//  Smpl
//
//  Created by CanGokceaslan on 27.12.2022.
//

import Foundation

func logger(_ items: String...){
	if(mainStore.state.debugMode == true){
		var str = "Log:";
		items.forEach{item in
			str = str + " " + item
		};
		print(str);
	}
}
