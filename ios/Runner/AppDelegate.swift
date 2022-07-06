import UIKit
import Flutter
import Firebase
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()

    GeneratedPluginRegistrant.register(with: self)
   if #available(iOS 10.0, *) {
     UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
   }
        application.registerForRemoteNotifications()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    override func application(_ application:UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken:Data ){
        
        Messaging.messaging().apnsToken = deviceToken
        print("token: $deviceToken")
        super.application(application,didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
}
