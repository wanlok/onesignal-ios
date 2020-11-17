//
//  AppDelegate.swift
//  dummy
//
//  Created by robert.t.wan on 10/11/2020.
//

import UIKit
import OneSignal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var pushNotificationReceived: ((String, String, [String: Any])->())? = nil
    
    func dummy(dict: [AnyHashable: Any]) -> [String: String] {
        var dummy: [String: String] = [:]
        for (key, value) in dict {
            dummy["\(key)"] = "\(value)"
        }
        return dummy
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Remove this method to stop OneSignal Debugging
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)

        //START OneSignal initialization code
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false, kOSSettingsKeyInAppLaunchURL: false]

        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
            guard let payload = result?.notification.payload, let title = payload.title, let body = payload.body, let data = payload.additionalData else {
                return
            }
            self.pushNotificationReceived?(title, body, self.dummy(dict: data))
        }

        // Replace 'YOUR_ONESIGNAL_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions,
        appId: "7ac16e59-8599-4825-a343-6a5ba4d9704c",
        handleNotificationAction: notificationOpenedBlock,
        settings: onesignalInitSettings)

        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;

        // promptForPushNotifications will show the native iOS notification permission prompt.
        // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })

        //END OneSignal initializataion code
        
        return true
    }
}

