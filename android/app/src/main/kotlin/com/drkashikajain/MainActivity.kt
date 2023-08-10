// package com.dr.kashika

// import android.app.Activity
// import android.content.Context
// import android.content.Intent
// import android.hardware.display.DisplayManager
// import android.media.AudioManager
// import android.media.projection.MediaProjectionManager
// import android.os.Build
// import android.preference.PreferenceManager
// import android.util.Log
// import android.view.WindowManager.LayoutParams
// import io.flutter.embedding.android.FlutterActivity
// import io.flutter.embedding.engine.FlutterEngine
// import io.flutter.plugin.common.MethodChannel



// class MainActivity: FlutterActivity()  {
//     // private val CHANNEL = "flutter.native/helper"
//     // var chanel: MethodChannel? =null

//     // var valueData:String?="1"


//     override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//         window.addFlags(LayoutParams.FLAG_SECURE)
//         // PreferenceManager.getDefaultSharedPreferences(context).edit().putString("fromNative", "myStringToSave").apply();

//         // val displayManager = getSystemService(Context.DISPLAY_SERVICE) as? DisplayManager
//         // displayManager?.registerDisplayListener(listener, null)

//         //   chanel= MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL);
//         // chanel?.setMethodCallHandler {
//         //         call, result ->
//         //     if(call.method=="getData"){
//         //         result.success("${valueData}")
//         //     }

//         // }
//         check(!isEmulator())

//         super.configureFlutterEngine(flutterEngine)

//     }

//     private fun isEmulator(): Boolean {
//         return (Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic")
//                 || Build.FINGERPRINT.startsWith("generic")
//                 || Build.FINGERPRINT.startsWith("unknown")
//                 || Build.HARDWARE.contains("goldfish")
//                 || Build.HARDWARE.contains("ranchu")
//                 || Build.MODEL.contains("google_sdk")
//                 || Build.MODEL.contains("Emulator")
//                 || Build.MODEL.contains("Android SDK built for x86")
//                 || Build.MANUFACTURER.contains("Genymotion")
//                 || Build.PRODUCT.contains("sdk_google")
//                 || Build.PRODUCT.contains("google_sdk")
//                 || Build.PRODUCT.contains("sdk")
//                 || Build.PRODUCT.contains("sdk_x86")
//                 || Build.PRODUCT.contains("vbox86p")
//                 || Build.PRODUCT.contains("emulator")
//                 || Build.PRODUCT.contains("simulator")
//                 || runningOnAndroidStudioEmulator()
//                 || Build.FINGERPRINT.startsWith("generic")
//                 || Build.FINGERPRINT.startsWith("unknown")
//                 || Build.MODEL.contains("google_sdk")
//                 || Build.MODEL.contains("Emulator")
//                 || Build.MODEL.contains("Android SDK built for x86")
//                 || Build.MODEL.contains("VirtualBox")
//                 //bluestacks
//                 || "QC_Reference_Phone" == Build.BOARD && !"Xiaomi".equals(Build.MANUFACTURER, ignoreCase = true) //bluestacks
//                 || Build.MANUFACTURER.contains("Genymotion")
//                 || Build.HOST == "Build2" //MSI App Player
//                 || Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic")
//                 || Build.PRODUCT == "google_sdk"
//                 // another Android SDK emulator check
//                 || System.getProperties().getProperty("ro.kernel.qemu") == "1")
//     }

//     private fun runningOnAndroidStudioEmulator(): Boolean {
//         return Build.FINGERPRINT.startsWith("google/sdk_gphone")
//                 && Build.FINGERPRINT.endsWith(":user/release-keys")
//                 && Build.MANUFACTURER == "Google" && Build.PRODUCT.startsWith("sdk_gphone") && Build.BRAND == "google"
//                 && Build.MODEL.startsWith("sdk_gphone")
//     }


// //     val listener = object : DisplayManager.DisplayListener {




// //         override fun onDisplayChanged(displayId: Int) {
// // //            Log.d("jdfbcsdb__","1")
// // //            valueData="1"
// // //            chanel?.setMethodCallHandler {
// // //                    call, result ->
// // //                if(call.method=="getData"){
// // //                    result.success("${valueData}")
// // //                }
// // //
// // //            }


// //         }

// //         override fun onDisplayAdded(displayId: Int) {
// //             Log.d("jdfbcsdb__","2")
// //             valueData="2"

// //             try {
// //                 chanel?.invokeMethod("getData"){
// //                     Log.d("getDataLog","2")
// //                 }

// //             }catch (e:java.lang.Exception){
// //                 Log.d("getDataLogException",e.message.toString())
// //             }

// // //            chanel?.setMethodCallHandler {
// // //                    call, result ->
// // //                if(call.method=="getData"){
// // //                    result.success("hello world${valueData}")
// // //                }

// // //            }

// //         }

// //         override fun onDisplayRemoved(displayId: Int) {
// //             Log.d("jdfbcsdb__","3")
// // //            valueData="3"

// //             try {
// //                 chanel?.invokeMethod("getData"){
// //                     Log.d("getDataLog","2")
// //                 }

// //             }catch (e:java.lang.Exception){
// //                 Log.d("getDataLogException",e.message.toString())
// //             }

// //         }
// //     }

// }
package com.dr.kashika

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}
