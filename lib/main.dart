import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:drkashikajain/app_colors.dart';
import 'package:drkashikajain/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //setting device_token for pushNotification
  FirebaseMessaging messaging;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  messaging = FirebaseMessaging.instance;
  messaging.getToken().then((value) {
    print(value);
    prefs.setString('device_token', value);
  });
  messaging.setForegroundNotificationPresentationOptions();
  AwesomeNotifications().initialize('resource://drawable/launcher_icon', [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        defaultColor: AppColors.colorTransparent,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        playSound: true,
        ledColor: Colors.white)
  ]);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("message recieved");
    // var id = new DateTime.now().millisecondsSinceEpoch.remainder(1);
    int id = Random().nextInt(pow(2, 31) - 1);
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            displayOnForeground: true,
            id: id,
            channelKey: 'basic_channel',
            title: message.data['title'],
            body: message.data['body']));
  });

  // FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //   print('Message clicked!');
  // });
  // AwesomeNotifications().createdStream.listen((message) {
  //   AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //           id: message.id,
  //           channelKey: message.channelKey,
  //           title: message.title,
  //           body: message.body));
  // });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  print(message.data);
  int id = Random().nextInt(pow(2, 31) - 1);
  //firebase push notification
  // AwesomeNotifications().createNotificationFromJsonData(message.data);
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: 'basic_channel',
          title: message.data['title'],
          body: message.data['body']));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashPage());
  }
}
