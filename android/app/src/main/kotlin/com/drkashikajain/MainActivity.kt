package com.dr.kashika

import android.app.AlertDialog
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import android.util.Log
import android.view.WindowManager.LayoutParams
import android.os.Build
class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (isEmulator()) {
            Log.e("MainActivity", "Emulator detected. Closing the app.")
            showEmulatorNotSupportedDialog()
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        window.addFlags(LayoutParams.FLAG_SECURE)
        super.configureFlutterEngine(flutterEngine)
    }

    private fun isEmulator(): Boolean {
        return (Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic")
                || Build.FINGERPRINT.startsWith("generic")
                || Build.FINGERPRINT.startsWith("unknown")
                || Build.HARDWARE.contains("goldfish")
                || Build.HARDWARE.contains("ranchu")
                || Build.MODEL.contains("google_sdk")
                || Build.MODEL.contains("Emulator")
                || Build.MODEL.contains("Android SDK built for x86")
                || Build.MANUFACTURER.contains("Genymotion")
                || Build.PRODUCT.contains("sdk_google")
                || Build.PRODUCT.contains("google_sdk")
                || Build.PRODUCT.contains("sdk")
                || Build.PRODUCT.contains("sdk_x86")
                || Build.PRODUCT.contains("vbox86p")
                || Build.PRODUCT.contains("emulator")
                || Build.PRODUCT.contains("simulator")
                || runningOnAndroidStudioEmulator()
                || Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic")
                || System.getProperties().getProperty("ro.kernel.qemu") == "1")
    }

    private fun runningOnAndroidStudioEmulator(): Boolean {
        return Build.FINGERPRINT.startsWith("google/sdk_gphone")
                && Build.FINGERPRINT.endsWith(":user/release-keys")
                && Build.MANUFACTURER == "Google" && Build.PRODUCT.startsWith("sdk_gphone") && Build.BRAND == "google"
                && Build.MODEL.startsWith("sdk_gphone")
    }

    private fun showEmulatorNotSupportedDialog() {
        AlertDialog.Builder(this)
                .setTitle("Unsupported Device")
                .setMessage("This app cannot be run on emulators or virtual devices.")
                .setCancelable(false)
                .setPositiveButton("Exit") { _, _ ->
                    finishAffinity() // Close all activities
                    System.exit(0) // Terminate the app
                }
                .show()
    }
}
