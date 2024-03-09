import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    lazy var flutterEngine = FlutterEngine(name: "MyApp")
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }
      flutterEngine.run()
      GeneratedPluginRegistrant.register(with: self.flutterEngine)
      
   
      GMSServices.provideAPIKey("AIzaSyDYxVAdT5ZHoD60AXMjJil114wooszu-ps")
     
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
