import 'dart:async';

import 'package:drkashikajain/login/LoginScreen.dart';
import 'package:drkashikajain/selectlanguageScreen.dart';
import 'package:drkashikajain/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_view/route_animations.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var splashDuration = 2000;
  double screenHeight;
  double screenWidth;

  @override
  Future<void> initState() {
    super.initState();
    startCountdownTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/back.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: splashCenterWidget()));
  }

  Widget splashCenterWidget() {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // SvgPicture.asset('assets/images/Fixfella.svg', width: 250,
            //   fit: BoxFit.cover,),
            Image.asset(
              'images/logo.png',
              fit: BoxFit.cover,
              height: 150,
            ),
            const SizedBox(height: 10),
            // const Text('CRM Services', style: tsSemiBoldTextDarkGrey18, textAlign: TextAlign
            //   .center),
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
            ),
          ],
        ),
      ),
    );
  }

  Future<Timer> startCountdownTimer() async {
    final _duration = Duration(milliseconds: splashDuration);
    return Timer(_duration, navigateToPage);
    //navigateToPage();
  }

  Future<void> navigateToPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // print("userid>>>>>>>"+prefs.getString(KPrefs.USER_ID));
    if (prefs.getString(KPrefs.USER_ID) != null) {
      Navigator.pushAndRemoveUntil(
          context,
          RouteAnimationSlideFromRight(
              widget: SelectLanguageScreen(), routeName: ""),
          (Route<dynamic> route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          RouteAnimationSlideFromRight(widget: LoginScreen(), routeName: ""),
          (Route<dynamic> route) => false);
    }
  }
}
