import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:drkashikajain/primary_button.dart';
import 'package:drkashikajain/selectlanguageScreen.dart';
import 'package:drkashikajain/utils/constants.dart';
import 'package:drkashikajain/utils/method.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ForgetPasswordScreen.dart';
import '../RegistrationScreen.dart';
import '../custom_view/route_animations.dart';
import '../custom_view/utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  bool _isLoaded = false;
  var _emailTextController;
  var _passwordTextController;
  bool _showPassword = false;
  var deviceToken;
  @override
  void initState() {
    // FirebaseMessaging messaging;
    // messaging = FirebaseMessaging.instance;
    // messaging.getToken().then((value) {
    //   deviceToken = value;
    // });
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/back.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Form(
          child: ListView(
            shrinkWrap: false,
            physics: const AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              !_isLoaded
                  ? _loginWidgeta()
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
      ),
    ));
  }

  _loginWidgeta() {
    return new Column(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(top: 20),
          height: 100.0,
          width: 100.0,
          child: Image.asset("images/logo.png"),
        ),
        new Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Center(
              child: Text('USER LOGIN',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.blue))),
        ),
        new Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Center(
              child: Text('For New User',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: Colors.blue))),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegistrationScreen()));
          },
          child: new Container(
            margin: EdgeInsets.only(top: 15.0),
            padding: const EdgeInsets.only(
                top: 6.0, bottom: 10, left: 25, right: 25),
            decoration: myBoxDecoration(),
            child: Text('CREATE AN ACCOUNT',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white)),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 30.0),
          child: Center(
              child: Text('For Existing User',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: Colors.blue))),
        ),
        new Container(
          margin: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
          child: TextFormField(
            controller: _emailTextController,
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.emailAddress,
            decoration: new InputDecoration(
              prefixIcon: Icon(Icons.email, color: Colors.white),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              hintStyle: TextStyle(color: Colors.white),
              hintText: 'Email Id',
            ),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: TextFormField(
            controller: _passwordTextController,
            style: TextStyle(color: Colors.white),
            obscureText: !this._showPassword,
            keyboardType: TextInputType.visiblePassword,
            decoration: new InputDecoration(
              prefixIcon: Icon(Icons.lock_open, color: Colors.white),
              suffixIcon: IconButton(
                  icon: Icon(Icons.remove_red_eye,
                      color: this._showPassword ? Colors.blue : Colors.white),
                  onPressed: () {
                    setState(() => this._showPassword = !this._showPassword);
                  }),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              hintStyle: TextStyle(color: Colors.white),
              hintText: 'Password',
            ),
          ),
        ),
        new Container(
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(right: 10.0),
          child: TextButton(
              onPressed: () => _forgetButtonTapped(),
              child: new Text(
                'Forget Password?',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              )),
        ),
        continueButton(),
      ],
    );
  }

  Widget continueButton() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(bottom: 50, left: 30, right: 30),
        child: PrimaryButton(
            buttonText: 'Submit', onButtonPressed: () => _loginButtonTapped()),
      ),
    );
  }

  Future<void> loginAPI() async {
  try {
    var deviceType;
    String? deviceName;
    String? identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var deviceToken = prefs.getString('device_token');
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceType = 'android';
        deviceName = build.model;
        identifier = build.id; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceType = 'ios';
        deviceName = data.name;
        identifier = data.identifierForVendor; //UUID for iOS
      }
     

    setState(() {
      _isLoaded = true;
    });
    print('devicename' + deviceName!);
    print('devicetype' + deviceType);
    print('identifier' + identifier!);
    print("email_or_phone>>>>>>>>>>>" + _emailTextController.text.toString());
    print("password>>>>>>>>>>>" + _passwordTextController.text.toString());

    Map<String, String?> body = {
      "user_email": _emailTextController.text.toString(),
      "password": _passwordTextController.text.toString(),
      "device_token": deviceToken.toString()??"",
      "device_type": deviceType,
      "device_name": deviceName,
      "device_id": identifier,
    };
    // if (internet != null && internet) {


      final response = await http.post(
          Uri.parse(KApiBase.BASE_URL + KApiEndPoints.API_LOGIN),
          body: body);
      Map? mapRes = json.decode(response.body.toString());
      print("responseBody>>>>>>>>>>>" + mapRes.toString());

      if (response.statusCode == 200) {
        if (mapRes!['code'] == "200") {
          setState(() {
            _isLoaded = false;
          });

          Utils.showErrorMessage(context, mapRes['message']);

          prefs.setString(
              KPrefs.USER_ID, mapRes['user_details'][0]['user_id'].toString());
          prefs.setString(
              KPrefs.TOKEN, mapRes['user_details'][0]["access_token"]);
          prefs.setString(
              KPrefs.USER_NAME, mapRes['user_details'][0]["username"]);
          prefs.setString(
              KPrefs.USER_EMAIL, mapRes['user_details'][0]["user_email"]);
          prefs.setString(
              KPrefs.MOBILE, mapRes['user_details'][0]["user_phone"]);
          await prefs.setString("type", "login");
          Navigator.pushAndRemoveUntil(
              context,
              RouteAnimationSlideFromRight(
                  widget: SelectLanguageScreen(), routeName: ""),
              (Route<dynamic> route) => false);
        } else {
          setState(() {
            _isLoaded = false;
          });
          Utils.showErrorMessage(context, mapRes['message']);
        }
      } else {
         setState(() {
            _isLoaded = false;
          });
        throw Exception('Unable to fetch products from the REST API');
      }
      } catch (e) {
         setState(() {
            _isLoaded = false;
          });
        print("Exception rest api: " + e.toString());
      }
    
  }

  Future<void> skipAPI() async {
    setState(() {
      _isLoaded = true;
    });
    print("email_or_phone>>>>>>>>>>>" + _emailTextController.text.toString());
    print("password>>>>>>>>>>>" + _passwordTextController.text.toString());

    Map<String, String> body = {
      'user_email': "akash123456@gmail.com",
      'password': "123456",
      'device_token': "63765167yu",
      'device_type': "android",
      'device_name': "PPP",
      'device_id': "android_id",
    };
/*
      try {
*/
      final response = await http.post(
          Uri.parse(KApiBase.BASE_URL + KApiEndPoints.API_LOGIN),
          body: body);
      Map? mapRes = json.decode(response.body.toString());
      print("responseBody>>>>>>>>>>>" + mapRes.toString());

      if (response.statusCode == 200) {
        if (mapRes!['code'] == "200") {
          setState(() {
            _isLoaded = false;
          });

          //  Utils.showErrorMessage(context, mapRes['message']);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(
              KPrefs.USER_ID, mapRes['user_details'][0]['user_id'].toString());
          prefs.setString(
              KPrefs.TOKEN, mapRes['user_details'][0]["access_token"]);
          prefs.setString(
              KPrefs.USER_NAME, mapRes['user_details'][0]["username"]);
          prefs.setString(
              KPrefs.USER_EMAIL, mapRes['user_details'][0]["user_email"]);
          prefs.setString(
              KPrefs.MOBILE, mapRes['user_details'][0]["user_phone"]);
          await prefs.setString("type", "login");
          Navigator.pushAndRemoveUntil(
              context,
              RouteAnimationSlideFromRight(
                  widget: SelectLanguageScreen(), routeName: ""),
              (Route<dynamic> route) => false);
        } else {
          setState(() {
            _isLoaded = false;
          });
          // Utils.showErrorMessage(context, mapRes['message']);
        }
      } else {
         setState(() {
            _isLoaded = false;
          });
        throw Exception('Unable to fetch products from the REST API');
      
      /*} catch (e) {
        print("Exception rest api: " + e);
      }*/
    }
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: Colors.white),
    );
  }

  _loginButtonTapped() {
    if (_emailTextController.text.isEmpty) {
      Utils.showErrorMessage(context, "Please Enter Email Address");
    } else if (_passwordTextController.text.isEmpty) {
      Utils.showErrorMessage(context, "Please Enter Password");
    } else {
      loginAPI();
    }
  }

  _forgetButtonTapped() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
  }
}
