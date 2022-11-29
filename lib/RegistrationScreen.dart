import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:drkashikajain/primary_button.dart';
import 'package:drkashikajain/selectlanguageScreen.dart';
import 'package:drkashikajain/utils/constants.dart';
import 'package:drkashikajain/utils/method.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_view/route_animations.dart';
import 'custom_view/utils.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegistrationScreenState();
  }
}

class RegistrationScreenState extends State<RegistrationScreen> {
  bool internet = true;
  bool _isLoaded = false;
  var _nameTextController;
  var _emailTextController;
  var _cityTextController;
  var _countryTextController;
  var _passwordTextController;
  var _mobileTextController;
  static final RegExp _emailRegex =
      RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  static final RegExp _number = RegExp("[0-9]");
  var deviceToken;
  @override
  void initState() {
    super.initState();
    FirebaseMessaging messaging;
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      deviceToken = value;
    });
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _cityTextController = TextEditingController();
    _countryTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _mobileTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    print(internet);
    return new Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/back.png"), fit: BoxFit.cover)),
          child: Center(
            child: Form(
              child: ListView(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: <Widget>[
                  !_isLoaded
                      ? _loginWidgeta()
                      : Center(
                          child: Center(child: CircularProgressIndicator()),
                        ),
                ],
              ),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          // backgroundColor: AppColors.primary_color,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Registration Form',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ));
  }

  _loginWidgeta() {
    return new Column(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(top: 30),
          height: 100.0,
          width: 100.0,
          child: Image.asset("images/logo.png"),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: TextFormField(
            controller: _nameTextController,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
              NoLeadingSpaceFormatter(),
            ],
            style: TextStyle(color: Colors.black),
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              fillColor: Colors.white,
              filled: true,
              hintStyle: TextStyle(color: Colors.black),
              hintText: 'Name',
            ),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: TextFormField(
            controller: _mobileTextController,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            ],
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              fillColor: Colors.white,
              filled: true,
              hintStyle: TextStyle(color: Colors.black),
              hintText: 'Mobile Number',
            ),
          ),
        ),
        SizedBox(height: 15),
        new Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
            ],
            controller: _countryTextController,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              fillColor: Colors.white,
              filled: true,
              hintStyle: TextStyle(color: Colors.black),
              hintText: 'Country Name',
            ),
          ),
        ),
        SizedBox(height: 15),
        new Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
            ],
            controller: _cityTextController,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              fillColor: Colors.white,
              filled: true,
              hintStyle: TextStyle(color: Colors.black),
              hintText: 'City Name',
            ),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: TextFormField(
            controller: _emailTextController,
            keyboardType: TextInputType.emailAddress,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              fillColor: Colors.white,
              filled: true,
              hintStyle: TextStyle(color: Colors.black),
              hintText: 'Email Id',
            ),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: TextFormField(
            controller: _passwordTextController,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              fillColor: Colors.white,
              filled: true,
              hintStyle: TextStyle(color: Colors.black),
              hintText: 'Create Password',
            ),
          ),
        ),
        continueButton()
      ],
    );
  }

  Widget continueButton() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(bottom: 50, left: 30, right: 30, top: 30),
        child: PrimaryButton(
            buttonText: 'Submit', onButtonPressed: () => _loginButtonTapped()),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: Colors.white),
    );
  }

  _loginButtonTapped() {
    if (_nameTextController.text.toString().isEmpty) {
      Utils.showErrorMessage(context, 'Enter your name');
      return;
    } else if (_nameTextController.text.toString().contains(_number)) {
      Utils.showErrorMessage(context, 'Enter only characters');
      return;
    } else if (_mobileTextController.text.isEmpty) {
      Utils.showErrorMessage(context, 'Enter  mobile number');
      return;
    } else if (_countryTextController.text.toString().isEmpty) {
      Utils.showErrorMessage(context, 'Enter country');
      return;
    } else if (_cityTextController.text.toString().isEmpty) {
      Utils.showErrorMessage(context, 'Enter City');
      return;
    } else if (!isValidEmail(_emailTextController.text.toString())) {
      Utils.showErrorMessage(context, 'Enter valid email Id');
      return;
    } else if (_passwordTextController.text.toString().isEmpty) {
      Utils.showErrorMessage(context, 'Enter Password');
      return;
    } else {
      apihit();
    }
  }

  static bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email);
  }

  Future<void> apihit() async {
    internet = await Method.check();

    var deviceType;
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceType = 'android';
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.id; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceType = 'ios';
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

    setState(() {
      _isLoaded = true;
    });

    print('deviceType>>>+' + deviceType);
    print("email_or_phone>>>>>>>>>>>" + _emailTextController.text.toString());
    print("password>>>>>>>>>>>" + _passwordTextController.text.toString());
    print("full_name>>>>>>>>>>>" + _nameTextController.text.toString());

    Map<String, String> body = {
      'first_name': _nameTextController.text.toString(),
      'last_name': "",
      'user_email': _emailTextController.text.toString(),
      'user_password': _passwordTextController.text.toString(),
      'user_phone': _mobileTextController.text.toString(),
      'city_id': _cityTextController.text.toString(),
      'country_name': _countryTextController.text.toString(),
      'device_token': deviceToken.toString(),
      'device_type': deviceType,
    };
    if (internet != null && internet) {
      try {
        final response = await http.post(
            Uri.parse(KApiBase.BASE_URL + KApiEndPoints.API_SIGN_UP),
            body: body);
        print(response.body);
        Map mapRes = json.decode(response.body);
        print("responseBody>>>>>>>>>>>" + mapRes.toString());

        if (response.statusCode == 200) {
          if (mapRes['code'] == "200") {
            setState(() {
              loginAPI();
            });
            // Utils.showErrorMessage(context, mapRes['message']);
          } else {
            setState(() {
              _isLoaded = false;
            });
            Utils.showErrorMessage(context, mapRes['message']);
          }
        } else {
          throw Exception('Unable to fetch products from the REST API');
        }
      } catch (e) {
        print("Exception rest api: " + e);
      }
    }
  }

  Future<void> loginAPI() async {
    internet = await Method.check();
    var deviceType;
    String deviceName;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
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
    } on PlatformException {
      print('Failed to get platform version');
    }
    setState(() {
      _isLoaded = true;
    });
    print("email_or_phone>>>>>>>>>>>" + _emailTextController.text.toString());
    print("password>>>>>>>>>>>" + _passwordTextController.text.toString());
    print("full_name>>>>>>>>>>>" + _nameTextController.text.toString());

    Map<String, String> body = {
      'user_email': _emailTextController.text.toString(),
      'password': _passwordTextController.text.toString(),
      'device_token': deviceToken.toString(),
      'device_type': deviceType,
      'device_name': deviceName,
      'device_id': identifier,
    };
    if (internet != null && internet) {
      try {
        final response = await http.post(
            Uri.parse(KApiBase.BASE_URL + KApiEndPoints.API_LOGIN),
            body: body);
        Map mapRes = json.decode(response.body.toString());
        print("responseBody>>>>>>>>>>>" + mapRes.toString());

        if (response.statusCode == 200) {
          if (mapRes['code'] == "200") {
            setState(() {
              _isLoaded = false;
            });

            Utils.showErrorMessage(context, mapRes['message']);
            prefs.setString(KPrefs.USER_ID,
                mapRes['user_details'][0]['user_id'].toString());
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
          throw Exception('Unable to fetch products from the REST API');
        }
      } catch (e) {
        print("Exception rest api: " + e);
      }
    }
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}
