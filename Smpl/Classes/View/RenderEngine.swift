//
//  ViewMain.swift
//  Smpl
//
//  Created by CanGokceaslan on 23.11.2022.
//

import Foundation;
import SwiftUI;
import ExytePopupView;

public struct RenderEmptyView: View {
	public var body: some View {
		return EmptyView()
	}
}

public struct RenderEngine: View{
    //let popup:some View = PopupViewSmpl()
	@ObservedObject private var state = ObservableState(store: mainStore);
	@State private var showPopup: Bool = true;
	
	@ViewBuilder
	public var body: some View {
		if(mainStore.state.views.count > 0){
			switch mainStore.state.views[0]["type"] as? String {
				case "popup":
					SheetPopupWebView(isPresented: .constant(mainStore.state.popupAwake), data: .constant(mainStore.state.views[0] as NSDictionary))
					//SheetPopupView(isPresented: $showPopup, data: .constant(state.current.views[0] as NSDictionary))
				case "default-popup":
					EmptyView().popup(isPresented: $showPopup, type: .`default`, closeOnTap: true, backgroundColor: .black.opacity(0.4)) {
						PopupView(
							isPresented: $showPopup,
							data: .constant(state.current.views[0] as NSDictionary)
						)
					}
				default:
					EmptyView().popup(isPresented: .constant(false), type: .`default`, closeOnTap: false, backgroundColor: .black.opacity(0.4)) {
						PopupView(
							isPresented: .constant(false),
							data: .constant(state.current.views[0] as NSDictionary)
						)
					}
			}
			
		}
	}
	//let popup: some View = TestPopupViewSmpl();
}

struct RenderEngine_Previews: PreviewProvider {
	static var previews: some View {
		PopupView(
			isPresented: .constant(true),
			data: .constant(["type":""])
		)
	}
}

public func renderer() -> some View{
	return RenderEngine();
}
