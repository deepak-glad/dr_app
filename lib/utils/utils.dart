import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drkashikajain/custom_view/custom_overlays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_colors.dart';
import 'constants.dart';

// ignore: avoid_classes_with_only_static_members
class Utils {
  static BuildContext _loaderContext;
  static BuildContext _loadingDialoContext;
  static bool _isLoaderShowing = false;
  static bool _isLoadingDialogShowing = false;
  static Timer toastTimer;
  static OverlayEntry _overlayEntry;

//  Checks
  static bool isNotEmpty(String s) {
    return s != null && s.trim().isNotEmpty;
  }

  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static bool isEmpty(String s) {
    return !isNotEmpty(s);
  }

  static bool isListNotEmpty(List<dynamic> list) {
    return list != null && list.isNotEmpty;
  }

  //  Views
  static void showToast(BuildContext context, String message) {
    showCustomToast(context, message);
  }

  static void showSuccessMessage(BuildContext context, String message) {
    showCustomToast(context, message, bgColor: AppColors.snackBarGreen);
  }

  static void showNeutralMessage(BuildContext context, String message) {
    showCustomToast(context, message, bgColor: AppColors.snackBarColor);
  }

  static void showErrorMessage(BuildContext context, String message) {
    showCustomToast(context, message);
  }

  static void showValidationMessage(BuildContext context, String message) {
    //Log.info('Toast message : ' + message);
    showCustomToast(context, message);
  }

  static void showCustomToast(BuildContext context, String message,
      {Color bgColor = AppColors.primaryColor}) {
    if (toastTimer == null || !toastTimer.isActive) {
      _overlayEntry = createOverlayEntry(context, message, bgColor);
      Overlay.of(context).insert(_overlayEntry);
      toastTimer = Timer(const Duration(seconds: 5), () {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
        }
      });
    }
  }

  static void hideLoader() {
    if (_isLoaderShowing && _loaderContext != null) {
      Navigator.pop(_loaderContext);
      _loaderContext = null;
    }
  }

  static void hideLoadingDialog() {
    if (_isLoadingDialogShowing && _loadingDialoContext != null) {
      Navigator.pop(_loadingDialoContext);
      _loadingDialoContext = null;
    }
  }

  static void hideKeyBoard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static DateTime convertDateFromString(String strDate) {
    DateTime date = DateTime.parse(strDate);
    // var formatter = new DateFormat('yyyy-MM-dd');
    return date;
  }

  static Future<bool> onWillPop(BuildContext context) {
    final DateTime now = DateTime.now();
    DateTime currentBackPressTime;
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Utils.showToast(context, 'Press again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<String> sessionCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getString(SharedPrefsKeys.USER_ID);
    // print("userIdNewProducts " + userId);
    return prefs.getString(SharedPrefsKeys.USER_ID);
  }

  Future<String> sessionAccessKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getString(SharedPrefsKeys.USER_ACCESS_KEY);
    // print("userIdNewProducts " + userId);
    return prefs.getString(SharedPrefsKeys.USER_ACCESS_KEY);
  }

  Future<int> sessionCartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getInt(SharedPrefsKeys.CART_ITEM_COUNT);
    // print("userIdNewProducts " + userId);
    return prefs.getInt(SharedPrefsKeys.CART_ITEM_COUNT);
  }

  Widget noItemInCartList() {
    return Container(
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'No Data found',
            ),
          ),
        ],
      ),
    );
  }

  openSnackBar(
      BuildContext context, String message, ScaffoldState currentState) {
    currentState.showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(
        message,
        style: TextStyle(color: AppColors.white),
      ),
      backgroundColor: AppColors.greenColor,
      action: SnackBarAction(
        label: 'Go to Cart',
        textColor: AppColors.white,
        onPressed: () {
          // Navigator.of(context)
          //     .push(RouteAnimationSlideFromRight(widget: CartScreen()));
          // Some code to undo the change.
        },
      ),
    ));
  }

/*
  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load(path);

    return File('${(await getTemporaryDirectory()).path}/$path');
    // final file = await tempFile.writeAsBytes(
    //   byteData.buffer
    //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    // );
    // await file.writeAsBytes(byteData.buffer
    //     .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    // return tempFile;
  }
*/

  static fleshare(File value, Uri shortUrl) {}
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
