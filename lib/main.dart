import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:drkashikajain/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white)
  ]);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  print(message.data);
  //firebase push notification
  AwesomeNotifications().createNotificationFromJsonData(message.data);
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: message.ttl,
          channelKey: 'basic_channel',
          title: message.data['title'],
          body: message.data['body'])
      // bigPicture: 'assets://images/protocoderlogo.png')
      );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashPage());
  }
}
