import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class Method {
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static deviceType() {
    if (Platform.isAndroid) {
      return 'android';
    } else {
      return 'ios';
    }
  }

//   static Future getDeviceDetails() async {
//     String deviceName;
//     String deviceVersion;
//     String identifier;
//     final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
//     try {
//       if (Platform.isAndroid) {
//         var build = await deviceInfoPlugin.androidInfo;
//         deviceName = build.model;
//         deviceVersion = build.version.toString();
//         identifier = build.androidId; //UUID for Android
//       } else if (Platform.isIOS) {
//         var data = await deviceInfoPlugin.iosInfo;
//         deviceName = data.name;
//         deviceVersion = data.systemVersion;
//         identifier = data.identifierForVendor; //UUID for iOS
//       }
//     } on PlatformException {
//       print('Failed to get platform version');
//     }
//     print(deviceName);
//     print(deviceVersion);
//     print('idtifier' + identifier);
// //if (!mounted) return;
//     return identifier;
//   }

/*  static void showDialogANDROID(BuildContext _context, String title) {
    // flutter defined function
    showDialog(
      context: _context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text(MsgString.exit,
                  style: new TextStyle(color: blue10)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          elevation: 24,
        );
      },
    );
  }
  static void showDialogANDROID_daily(BuildContext _context, String title) {
    // flutter defined function
    showDialog(
      context: _context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text(MsgString.yes,
                  style: new TextStyle(color: blue10)),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool(SharedPref.daily,true);
                Navigator.of(context).pop();

              },
            ),
            new TextButton(
              child: new Text(MsgString.dismiss,
                  style: new TextStyle(color: errorRed)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          elevation: 24,
        );
      },
    );
  }

  static void showDialogIOS(
      BuildContext _context, String title, String content) {
    // flutter defined function
    showDialog(
      context: _context,
      barrierDismissible: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return CupertinoAlertDialog(
          title: new Text(title),
          content: content.trim().isNotEmpty ? new Text(content) : null,
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new CupertinoDialogAction(
              child: new Text(MsgString.dismiss,
                  style: new TextStyle(color: errorRed)),
              onPressed: () {
                Navigator.of(context).pop();
                //exit(0);
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogIOS_daily(
      BuildContext _context, String title, String content) {
    // flutter defined function
    showDialog(
      context: _context,
      barrierDismissible: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return CupertinoAlertDialog(
          title: new Text(title),
          content: content.trim().isNotEmpty ? new Text(content) : null,
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new CupertinoDialogAction(
              child: new Text(MsgString.yes,
                  style: new TextStyle(color: blue10)),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString(SharedPref.daily,"yes");
                Navigator.of(context).pop();
                //exit(0);
              },
            ),     new CupertinoDialogAction(
              child: new Text(MsgString.dismiss,
                  style: new TextStyle(color: errorRed)),
              onPressed: () {
                Navigator.of(context).pop();
                //exit(0);
              },
            ),
          ],
        );
      },
    );
  }

  */ /*static void showDialogIOSPopWidget(BuildContext _context,String title,String content) {
    // flutter defined function
    showDialog(
      context: _context,
      barrierDismissible: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return CupertinoAlertDialog(
          title: new Text(title),
          content: content.trim().isNotEmpty
              ? new Text(content)
              : null,
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new CupertinoDialogAction(
              child: new Text(MsgString.dismiss,style: new TextStyle(color: kShrineErrorRed)),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                //exit(0);
              },
            ),
          ],
        );
      },
    );
  }*/ /*
  // Progress indicator widget to show loading.


  // View to empty data message
  static Widget noDataView(
          String msg, ThemeData theme, BuildContext buildContext) =>
      new Container(
          color: backgroundWhite, //70.0,
          height: MediaQuery.of(buildContext).size.height - 80, //70.0,
          child: new Center(
            child: Text(
              msg,
              style: theme.textTheme.title,
            ),
          ));
  static bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }*/

  static Widget loadingView(BuildContext buildContext) => new Container(
      height: MediaQuery.of(buildContext).size.height - 80,
      child: new Center(child: new CircularProgressIndicator()));

  static Widget nodata(BuildContext buildContext) => new Container(
      height: MediaQuery.of(buildContext).size.height - 80,
      child: new Center(
          child: new Text(
        "No data found",
        style: TextStyle(fontSize: 25, color: Colors.white),
      )));

  static Widget nodatafound(BuildContext buildContext) => new Container(
      height: MediaQuery.of(buildContext).size.height - 80,
      child: new Center(
          child: Text(
        "No Data Found",
        style: TextStyle(color: Colors.black),
      )));
}
