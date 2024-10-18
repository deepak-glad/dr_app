import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
     self.window.makeSecure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // <Add>
  override func applicationWillResignActive(
    _ application: UIApplication
  ) {
    window?.rootViewController?.view.endEditing(true)
    self.window.isHidden = true;
  }
  override func applicationDidBecomeActive(
    _ application: UIApplication
  ) {
    self.window.isHidden = false;
  }
}

  //And this extension
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


// import UIKit
// import Flutter


// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
//     override func application(_
// application: UIApplication,
// didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey: Any]?) -> Bool {
   
//     self.window.makeSecure() //Add this line
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }

// }
// //And this extension
// extension UIWindow {
// func makeSecure() {
//     let field = UITextField()
//     field.isSecureTextEntry = true
//     self.addSubview(field)
//     field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//     field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//     self.layer.superlayer?.addSublayer(field.layer)
//     field.layer.sublayers?.first?.addSublayer(self.layer)
//   }
// }


// import UIKit
// import Flutter
//
// @UIApplicationMain
//@objc class AppDelegate: FlutterAppDelegate {
//    override func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//    ) -> Bool {
//        GeneratedPluginRegistrant.register(with: self)
//        self.window.makeSecure()
//        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//    }
//
//}
//
//     extension UIWindow {
//         func makeSecure() {
//             DispatchQueue.main.async {
//                 let field = UITextField()
//                 field.isSecureTextEntry = true
//                 self.addSubview(field)
//                 field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//                 field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//                 self.layer.superlayer?.addSublayer(field.layer)
//                 field.layer.sublayers?.first?.addSublayer(self.layer)
//             }
//         }
//     }
//
//
//

//import UIKit
//import Flutter
//
//@UIApplicationMain
//@objc class AppDelegate: FlutterAppDelegate {
//    weak var screen : UIView? = nil
//
//    override func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//    ) -> Bool {
//
//        NotificationCenter.default.addObserver(self, selector: #selector(preventScreenRecording), name: UIScreen.capturedDidChangeNotification, object: nil)
//
//        self.window.makeSecure()
//        GeneratedPluginRegistrant.register(with: self)
//        //    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//        return true
//    }
//
//
//
//
//    @objc func preventScreenRecording() {
//        let isCaptured = UIScreen.main.isCaptured
//        print("isCaptured: \(isCaptured)")
//        if isCaptured {
//            blurScreen()
//        }
//        else {
//            removeBlurScreen()
//        }
//    }
//
//    func blurScreen(style: UIBlurEffect.Style = UIBlurEffect.Style.regular) {
//        screen = UIScreen.main.snapshotView(afterScreenUpdates: false)
//        let blurEffect = UIBlurEffect(style: style)
//        let blurBackground = UIVisualEffectView(effect: blurEffect)
//        screen?.addSubview(blurBackground)
//        blurBackground.frame = (screen?.frame)!
//        window?.addSubview(screen!)
//    }
//
//    func removeBlurScreen() {
//        screen?.removeFromSuperview()
//    }}
//
//
//extension UIWindow {
//    func makeSecure() {
//        let field = UITextField()
//        field.isSecureTextEntry = true
//        self.addSubview(field)
//        field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        self.layer.superlayer?.addSublayer(field.layer)
//        field.layer.sublayers?.first?.addSublayer(self.layer)
//
//    }}

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
