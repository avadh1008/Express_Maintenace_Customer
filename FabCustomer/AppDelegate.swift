//
//  AppDelegate.swift
//  AzemArtistProject
//
//  Created by AmitSharma on 11/07/19.
//  Copyright © 2019 AmitSharma. All rights reserved.
//

import UIKit


import CoreLocation


import GoogleMaps
import GooglePlaces
import GooglePlacePicker


import Firebase
//import FirebaseInstanceID
//import FirebaseMessaging


import UserNotifications

var app_delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tap_collectionVC : ArtistPrViewController?
    
    var infoScroll : UIScrollView?
    var viewHeight : CGFloat = 0.0
    
    var serviceCollection   :  UICollectionView?
    var workreviCollection  :  UICollectionView?
    
    var navi_obj : UINavigationController?
    var story_obj : UIStoryboard?
    
    
   // var locationManager : CLLocationManager!
   // var currentLocation : CLLocation!
    
    
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        LocationManager.shared.requestLocationAtOnce()
        Messaging.messaging().delegate = self
        FirebaseApp.configure()
        
        Messaging.messaging().subscribe(toTopic: "Customer") { error in
          print("Subscribed to weather topic")
        }
        
        GMSPlacesClient.provideAPIKey("AIzaSyBduueULAV0yaYrCjOFbyHzl1t4gDKyLz4")
        GMSServices.provideAPIKey("AIzaSyBduueULAV0yaYrCjOFbyHzl1t4gDKyLz4")
        
        
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            print(uuid)
            GlobalVariables.sharedManager.strDeviceID  =  uuid
            
        }
        
        if #available(iOS 13.0, *) {
                   self.window?.overrideUserInterfaceStyle = .light
                      } else {
                          // Fallback on earlier versions
                      }
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        
        
        application.registerForRemoteNotifications()
        
        
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            }
            else if let result = result
            {
                print("Remote instance ID token: \(result.token)")
                /// self.instanceID TokenMessage.text  = "Remote InstanceID token: \(result.token)"
                GlobalVariables.sharedManager.strFBDeviceToken = result.token as String
                //UserDefaults.standard.set(result.token as String, forKey: "device_token")
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}




extension AppDelegate : MessagingDelegate , UNUserNotificationCenterDelegate
{
    
    //Mark:- Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print("APNs token retrieved: \(deviceToken)")
        
        var token: String = ""
        for i in 0..<deviceToken.count {
            token += String(format: "%02.2hhx", deviceToken[i] as CVarArg)
        }
        print(token)
        Messaging.messaging().apnsToken = deviceToken
        GlobalVariables.sharedManager.strDeviceToken = token as String
        
        
        
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
        
    }
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        print("Firebase registration token: \(fcmToken)")
        GlobalVariables.sharedManager.strFBDeviceToken = fcmToken as String
        
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    // [END ios_10_data_message]
    
    //MARK: - UIApplicationDelegate Methods
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        if let type = userInfo["gcm.notification.type"] as? String {
            print("room_id ID: \(type)")
            
            if type == "10004"
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sobStart10003"), object: nil, userInfo: userInfo)
            }
            
            
            if type == "10003"
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sobStart10003"), object: nil, userInfo: userInfo)
            }
            if type == "10013"
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateBooking"), object: nil, userInfo: userInfo)
            }
            
            if type == "10012"
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewRequestFound10012"), object: nil, userInfo: userInfo)
            }
            
            if  let aps: NSDictionary = (userInfo["aps"] as? NSDictionary)
            {
                
                if let alert : NSDictionary = aps.value(forKey: "alert") as? NSDictionary
                {
                    
                    if alert["title"] as! String == "Chat"
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateChat"), object: nil, userInfo: userInfo)
                    }
                    
                    
                }
                
            }
        }
        
        /*if self.window?.rootViewController?.topViewController is Chating_ViewCont {
         completionHandler([])
         } else {
         */
        completionHandler([.alert, .sound])
        //}
        
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        // strChat = "didReceiveRemoteNotification1"
        if let type = userInfo["gcm.notification.type"] as? String {
            
            if type == "10012"
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewRequestFound10012"), object: nil, userInfo: userInfo)
            }
            
            if type == "10003"
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sobStart10003"), object: nil, userInfo: userInfo)
            }
            if type == "10004"
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sobStart10003"), object: nil, userInfo: userInfo)
            }
            
        }
        print("Push notification received: \(userInfo)")
        if  let aps: NSDictionary = (userInfo["aps"] as? NSDictionary)
        {
            
            if let alert : NSDictionary = aps.value(forKey: "alert") as? NSDictionary
            {
                
                if alert["title"] as! String == "Chat"
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateChat"), object: nil, userInfo: userInfo)
                }
                
                
            }
            
        }
        completionHandler(.newData)
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        //  strChat = "didReceiveRemoteNotification2"
        
        print("Push notification received: \(userInfo)")
       
        if let type = userInfo["gcm.notification.type"] as? String {
            
            if type == "10012"
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewRequestFound10012"), object: nil, userInfo: userInfo)
            }
            if type == "10003"
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sobStart10003"), object: nil, userInfo: userInfo)
            }
            
            if type == "10004"
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sobStart10003"), object: nil, userInfo: userInfo)
            }
        }
        
        
        if let aps: NSDictionary = (userInfo["aps"] as? NSDictionary)
        {
            
            if let messageID = userInfo["gcm.message_id"] {
                print("Message ID: \(messageID)")
            }
            if let room = userInfo["room_id"] {
                print("room_id ID: \(room)")
            }
            if let alert: NSDictionary = aps.value(forKey: "alert") as? NSDictionary
            {
                print("Push notification received: \(userInfo)")
                if alert["title"] as! String == "Chat"
                {
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateChat"), object: nil, userInfo: userInfo)
                }
                else
                {
                    //Move To Notification Screen
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateReuqest"), object: nil, userInfo: userInfo)
                    
                }
            }
            /*if  let alert: NSDictionary = (userInfo["data"] as? NSDictionary)
            {
                
            }*/
        }
    }
    // Handle notification messages after display notification is tapped by the user.
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        print(userInfo)
        if  let _: NSDictionary = (userInfo["aps"] as? NSDictionary)
        {
            
            if let messageID = userInfo["gcm.message_id"] {
                print("Message ID: \(messageID)")
            }
            if let type = userInfo["gcm.notification.type"] as? String {
                
                
                if type == "10004"
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sobStart10003"), object: nil, userInfo: userInfo)
                }
                print("room_id ID: \(type)")
                
                if type == "10003"
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sobStart10003"), object: nil, userInfo: userInfo)
                }
                if type == "10013"
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateBooking"), object: nil, userInfo: userInfo)
                }
                
                if type == "10012"
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewRequestFound10012"), object: nil, userInfo: userInfo)
                }
                
                
                
            }
            
            
            
            
        }
        
        
        
        // completionHandler()
    }
    
    
    
    
}

/*extension UIViewController {
    var topViewController: UIViewController? {
        return self.topViewController(currentViewController: self)
    }
    
    private func topViewController(currentViewController: UIViewController) -> UIViewController {
        if let tabBarController = currentViewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return self.topViewController(currentViewController: selectedViewController)
        } else if let navigationController = currentViewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return self.topViewController(currentViewController: visibleViewController)
        } else if let presentedViewController = currentViewController.presentedViewController {
            return self.topViewController(currentViewController: presentedViewController)
        } else {
            return currentViewController
        }
    }
}
*/
