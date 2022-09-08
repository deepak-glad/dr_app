import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    self.window.makeSecure() 
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    // override func applicationWillResignActive(
    //   _ application: UIApplication
    // ) {
    //   self.window.isHidden = true;
    // }
    // override func applicationDidBecomeActive(
    //   _ application: UIApplication
    // ) {
    //   self.window.isHidden = false;
    // }
}


extension UIWindow {
func makeSecure() {
    let field = UITextField()
    field.isSecureTextEntry = true
    self.addSubview(field)
    field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.layer.superlayer?.addSublayer(field.layer)
    field.layer.sublayers?.first?.addSublayer(self.layer)
  }
}

//@implementation AppDelegate
//
//- (BOOL)application:(UIApplication *)application
//    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//  [GeneratedPluginRegistrant registerWithRegistry:self];
//  // Override point for customization after application launch.
//  return [super application:application didFinishLaunchingWithOptions:launchOptions];
//}
//
//- (void)applicationWillResignActive:(UIApplication *)application{
//    self.window.hidden = YES;
//}
//
//- (void)applicationDidBecomeActive:(UIApplication *)application{
//    self.window.hidden = NO;
//}

//@end
