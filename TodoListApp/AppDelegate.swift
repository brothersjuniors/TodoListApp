//
//  AppDelegate.swift
//  TodoListApp
//
//  Created by 近江伸一 on 2022/10/31.
//

import UIKit
import RealmSwift
import UserNotifications
import GoogleMobileAds
@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
  
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AdMobHelper.shared.initSDK()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        _ = try! Realm(configuration: config)
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.sound,.badge]){
            (granted,error) in
           
        }
        
        return true
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner,.sound])
    }
    
    // MARK: UISceneSession Lifecycle#imageLiteral(resourceName: "simulator_screenshot_1F6DF24A-4DA7-4B23-B01D-CE38FC804EB4.png")
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
