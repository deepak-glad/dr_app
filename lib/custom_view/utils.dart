import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_colors.dart';
import 'custom_overlays.dart';

// ignore: avoid_classes_with_only_static_members
class Utils {
  static BuildContext? _loaderContext;
  static BuildContext? _loadingDialoContext;
  static bool _isLoaderShowing = false;
  static bool _isLoadingDialogShowing = false;
  static Timer? toastTimer;
  static OverlayEntry? _overlayEntry;

//  Checks
  static bool isNotEmpty(String? s) {
    return s != null && s.trim().isNotEmpty;
  }

  static bool isEmpty(String? s) {
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

  static void showErrorMessage(BuildContext context, String? message) {
    showCustomToast(context, message);
  }

  static void showCustomToast(BuildContext context, String? message,
      {Color bgColor = AppColors.snackBarRed}) {
    /* if (toastTimer == null || !toastTimer.isActive) {*/
    _overlayEntry = createOverlayEntry(context, message, bgColor);
    Overlay.of(context).insert(_overlayEntry!);
    toastTimer = Timer(const Duration(seconds: 2), () {
      if (_overlayEntry != null) {
        _overlayEntry!.remove();
      }
    });
  }

  /* static void showLoader(BuildContext context) {
    if (!_isLoaderShowing) {
      _isLoaderShowing = true;
      _loaderContext = context;
      showDialog(
          context: _loaderContext,
          barrierDismissible: false,
          builder: (context) {
            return SpinKitChasingDots(
              color: AppColors.pinkColor,
            );
          }).then((value) => {_isLoaderShowing = false, Log.info('Loader hidden!')});
    }
  }

  static void showLoadingDialog(BuildContext context) {
    if (!_isLoadingDialogShowing) {
      _isLoadingDialogShowing = true;
      _loadingDialoContext = context;
      showDialog(
          context: _loadingDialoContext,
          barrierDismissible: false,
          builder: (context) {
            return SpinKitChasingDots(
              color: AppColors.pinkColor,
            );
          }).then((value) => {_isLoadingDialogShowing = false, Log.info('LoadingDialog hidden!')});
    }
  }

  static Future<File> compressAndGetFile(File file) async {
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath =
        dir.absolute.path + "/" + DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
      rotate: 0,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }
*/
  static void hideLoader() {
    if (_isLoaderShowing && _loaderContext != null) {
      Navigator.pop(_loaderContext!);
      _loaderContext = null;
    }
  }

  static void hideLoadingDialog() {
    if (_isLoadingDialogShowing && _loadingDialoContext != null) {
      Navigator.pop(_loadingDialoContext!);
      _loadingDialoContext = null;
    }
  }

  static void hideKeyBoard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static ThemeData getAppThemeData() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      canvasColor: Colors.transparent,
      primarySwatch: AppColors.primary_color as MaterialColor?,
      brightness: Brightness.light,
    );
  }

  static DateTime convertDateFromString(String strDate) {
    DateTime date = DateTime.parse(strDate);
    // var formatter = new DateFormat('yyyy-MM-dd');
    return date;
  }

  static Future<bool> onWillPop(BuildContext context) {
    final DateTime now = DateTime.now();
    DateTime? currentBackPressTime;
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Utils.showToast(context, 'Press again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
