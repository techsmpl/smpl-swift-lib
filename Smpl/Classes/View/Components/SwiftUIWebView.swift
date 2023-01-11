//
//  WebView.swift
//  Alamofire
//
//  Created by CanGokceaslan on 15.12.2022.
//

import Foundation;
import WebKit;
import UIKit;
import SwiftUI;
import WKWebViewJavascriptBridge;

extension URL {
	
	mutating func appendQueryItem(name: String, value: String?) {
		
		guard var urlComponents = URLComponents(string: absoluteString) else { return }
		
		// Create array of existing query items
		var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
		
		// Create query item
		let queryItem = URLQueryItem(name: name, value: value)
		
		// Append the new query item in the existing query items array
		queryItems.append(queryItem)
		
		// Append updated query items array in the url component object
		urlComponents.queryItems = queryItems
		
		// Returns the url from new url components
		self = urlComponents.url!
	}
}


class BridgeScriptHandler: UIViewController, WKScriptMessageHandler{

	public var data: NSDictionary? = nil;
	
	func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
		if message.name == "themeAction" {
			if message.body as! String == "light" {
				_ = false
			}else {
				_ = true
			}
			//print("JavaScript is sending a message \(message.body)");
		}
		
		if message.name == "closeActions"{
			//print("JavaScript is sending a message \(message.body)");
			mainStore.dispatch(RemoveView(payload:mainStore.state.views[0]));
		}
	}
	
}

struct SwiftUIWebView: UIViewRepresentable {
	
	
	typealias UIViewType = WKWebView;
	
	var webView: WKWebView;
	
	init(data: NSDictionary) {
		//webView = WKWebView(frame: .zero)
		
		let contentController = WKUserContentController()
		let userScript = WKUserScript(
			source: "mobileHeader()",
			injectionTime: .atDocumentEnd,
			forMainFrameOnly: true
		)
		let messageHandler = BridgeScriptHandler();
		messageHandler.self.data = data;
		contentController.addUserScript(userScript)
		contentController.add(messageHandler.self , name: "themeAction")
		contentController.add(messageHandler.self, name: "closeActions")
		
		var url = URL(string: data["url"] as! String)!;
		
		url.appendQueryItem(name: "scenarioId", value: (data["scenarioId"] as? String));
		
		let webConfiguration = WKWebViewConfiguration()
		webConfiguration.userContentController = contentController
		webView = WKWebView(frame: .zero, configuration: webConfiguration)
		webView.load(URLRequest(url: url))
		webView.scrollView.delegate = nil

		
	}
	
	func makeUIView(context: Context) -> WKWebView {
		return webView;
	}
	func updateUIView(_ uiView: WKWebView, context: Context) {
	}
	
	
}
