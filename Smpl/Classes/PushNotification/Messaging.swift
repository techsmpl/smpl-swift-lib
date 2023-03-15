//
//  Messaging.swift
//  Alamofire
//
//  Created by CanGokceaslan on 2.03.2023.
//

import Foundation;
import UIKit;
import FirebaseCore;
import FirebaseMessaging;
import UserNotifications;


@MainActor open class SmplMessaging: UIResponder, UIApplicationDelegate{
	public var token: String? = nil;
	public var onTokenReceived: ((_ token:String)->Void)? = nil;
	
	public func enableMessaging(){
		mainStore.dispatch(EnableMessaging())
	}
	
	public func configure(){
		FirebaseConfiguration.shared.setLoggerLevel(.error)
		FirebaseApp.configure();
		//FirebaseApp.configure()
		Messaging.messaging().delegate = self;
		UNUserNotificationCenter.current().delegate = self
		let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
		UNUserNotificationCenter.current().requestAuthorization(
			options: authOptions,
			completionHandler: { _, _ in }
		)
	}
	
	public func registerForRemoteNotifications(application: UIApplication){
		application.registerForRemoteNotifications();
	}
	
	public func getToken(onTokenReceived: @escaping (_ token:String)->Void){
		self.onTokenReceived = onTokenReceived;
		if(self.token != nil){
			onTokenReceived(token!);
			//return self.token
		}
		//return nil;
	}
}


extension SmplMessaging: UNUserNotificationCenterDelegate {
	
	public func application(
		_ application: UIApplication,
		didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
	) {
		Messaging.messaging().apnsToken = deviceToken
	}
	
	public func userNotificationCenter(
		_ center: UNUserNotificationCenter,
		willPresent notification: UNNotification,
		withCompletionHandler completionHandler:
		@escaping (UNNotificationPresentationOptions) -> Void
	) {
		if #available(iOS 14, *) {
			completionHandler([[.banner, .sound]])
		}else{
			completionHandler([[ .sound]])
		}
	}
	
	public func userNotificationCenter(
		_ center: UNUserNotificationCenter,
		didReceive response: UNNotificationResponse,
		withCompletionHandler completionHandler: @escaping () -> Void
	) {
		completionHandler()
	}
}

extension SmplMessaging: MessagingDelegate {
	public func messaging(
		_ messaging: Messaging,
		didReceiveRegistrationToken fcmToken: String?
	) {
		print("SMPL Info:: FCM Token is being generated...");
		Messaging.messaging().token{ token, error in
			if let error = error {
				//print("Error fetching FCM registration token: \(error)")
				print("SMPL Error:: Token Generation is not working. Possible problems: Notification Permission Not Enabled, Problem in configuration of Smpl. (Token generation will not work in programatic iOS devices (Simulator))");
				print("SMPL Error::", error.localizedDescription);
			} else if let token = token {
				print("SMPL Info:: FCM Token is generated:: \(token)")
				mainStore.dispatch(SetMessagingToken(payload: token))
				self.token = token;
				if(self.onTokenReceived != nil){
					if(self.token != nil){
						self.onTokenReceived!(self.token!)
					}
				}
				//self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
			}
		}
		let tokenDict = ["token": fcmToken ?? ""]
		NotificationCenter.default.post(
			name: Notification.Name("FCMToken"),
			object: nil,
			userInfo: tokenDict
		)
	}
}
