import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
  
     // 1
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        // 2
        let deviceChannel = FlutterMethodChannel(name: "flutter.methodChannel/iOS",
                                                 binaryMessenger: controller.binaryMessenger)
        
        // 3
        prepareMethodHandler(deviceChannel: deviceChannel)

    // FirebaseApp.configure()
    self.window.makeSecure() 
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    var newValue:String = ""
    override func applicationWillResignActive(
      _ application: UIApplication
    ) {
        newValue="2"
        
//       self.window.isHidden = true;
    }
    override func applicationDidBecomeActive(
      _ application: UIApplication
    ) {
        newValue="3"
//       self.window.isHidden = false;
    }
     private func prepareMethodHandler(deviceChannel: FlutterMethodChannel) {
        
        // 4
        deviceChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            // 5
            if call.method == "getDataIOs" {
                
                // 6
//                self.receiveDeviceModel(result: result)
                result(self.newValue)
           
            }
            else {
                // 9
                result(FlutterMethodNotImplemented)
                return
            }
            
        })
    }
    

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
        
          func prepareMethodHandler(deviceChannel: FlutterMethodChannel) {
            
            // 4
            deviceChannel.setMethodCallHandler({
                (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                
                // 5
                if call.method == "getDataIOs" {
                    var value="2";
                    // 6
                    //                self.receiveDeviceModel(result: result)
                    result(value)
                    
                }
                else {
                    // 9
                    result(FlutterMethodNotImplemented)
                    return
                }
                
            })
        }
    }}

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
