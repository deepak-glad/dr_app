import 'dart:convert';
import 'dart:ffi';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:drkashikajain/HomeScreen.dart';
import 'package:drkashikajain/primary_button.dart';
import 'package:drkashikajain/utils/constants.dart';
import 'package:drkashikajain/utils/method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'RaisedGradientButton.dart';
import 'RegistrationScreen.dart';
import 'app_colors.dart';
import 'custom_view/utils.dart';

class SelectLanguageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SelectLanguageScreenState();
  }
}

class SelectLanguageScreenState extends State<SelectLanguageScreen> {
  bool internet = true;
  bool _isLoaded = false;
  var hindiMobile;
  var englishmobile;
  var fb;
  var twitter;
  var insta;
  var youtube;

  @override
  void initState() {
    super.initState();
    getData();
    disableCapture();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Allow Notifications'),
                  content: Text('Our app would like to send notifications'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Don\'t allow',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        )),
                    TextButton(
                        onPressed: () => AwesomeNotifications()
                            .requestPermissionToSendNotifications()
                            .then((_) => Navigator.of(context).pop()),
                        child: Text('Allow',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.teal)))
                  ],
                ));
      }
    });
  }

  Future disableCapture() async {
    //disable screenshots and record screen in current screen
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
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
        child: _loginWidgeta(),
      ),

/*        child: ListView(
          shrinkWrap: false,
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[_loginWidgeta()],
        )*/
    );
  }

  _loginWidgeta() {
    return ListView(
      children: <Widget>[
        /* GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(top: 20, right: 20, left: 15),
            alignment: Alignment.topLeft,
            child: Icon(
              Icons.arrow_back,
              color: AppColors.white,
            ),
          ),
        ),*/
        Container(
          margin: EdgeInsets.only(top: 50),
          height: 100.0,
          width: 100.0,
          child: Image.asset("images/logo.png"),
        ),
        Container(
          margin: EdgeInsets.only(top: 50.0),
          child: Center(
              child: Text('SELECT VIDEO LANGUAGE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white))),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreen("hindi")));
          },
          child: Container(
              width: double.infinity,
              height: 40,
              margin: EdgeInsets.only(top: 40, left: 70, right: 70),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.white, width: 2)),
              child: Center(
                child: Text(
                  "HINDI",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreen("english")));
          },
          child: Container(
              width: double.infinity,
              height: 40,
              margin: EdgeInsets.only(top: 30, left: 70, right: 70),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.white, width: 2)),
              child: Center(
                child: Text(
                  "ENGLISH",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              )),
        ),
        SizedBox(
          height: 20,
        ),
        Visibility(
          visible: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: fb.toString().isEmpty ? false : true,
                child: GestureDetector(
                  onTap: () {
                    launchURL(fb);
                  },
                  child: new Container(
                    margin: EdgeInsets.only(top: 50, left: 0),
                    height: 30.0,
                    width: 30.0,
                    child: Image.asset("images/fb.png"),
                  ),
                ),
              ),
              Visibility(
                visible: twitter.toString().isEmpty ? false : true,
                child: GestureDetector(
                  onTap: () {
                    launchURL(twitter);
                  },
                  child: new Container(
                    margin: EdgeInsets.only(top: 50, left: 30),
                    height: 30.0,
                    width: 30.0,
                    child: Image.asset("images/twitter.png"),
                  ),
                ),
              ),
              Visibility(
                visible: insta.toString().isEmpty ? false : true,
                child: GestureDetector(
                  onTap: () {
                    launchURL(insta);
                  },
                  child: new Container(
                    margin: EdgeInsets.only(top: 50, left: 30),
                    height: 30.0,
                    width: 30.0,
                    child: Image.asset("images/instagram.png"),
                  ),
                ),
              ),
              Visibility(
                visible: youtube.toString().isEmpty ? false : true,
                child: GestureDetector(
                  onTap: () {
                    launchURL(youtube);
                  },
                  child: new Container(
                    margin: EdgeInsets.only(top: 50, left: 30),
                    height: 30.0,
                    width: 30.0,
                    child: Image.asset("images/youtube.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Center(
          child: Text(
            "CONTACT US",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 19, color: Colors.white),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            "( Call/Whatsapp )",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
          ),
        ),
        SizedBox(height: 15),
        Center(
          child: continueButton(hindiMobile, 'HINDI'),
        ),
        SizedBox(height: 15),

        Center(
          child: continueButton(englishmobile, 'ENGLISH'),
        )

        // Positioned(
        //   bottom: 0,
        //   child: Container(child: continueButton()),
        // )
      ],
    );
  }

  Widget continueButton(String mobile, String lan) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: PrimaryButton(
          buttonText: '$lan  +91 $mobile',
          onButtonPressed: () {
            _makePhoneCall('tel:$mobile');
          }),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: Colors.white),
    );
  }

  Future<void> getData() async {
    internet = await Method.check();
    setState(() {
      _isLoaded = true;
    });

    if (internet != null && internet) {
      try {
        final response = await http
            .get(KApiBase.SERVICE_BASE_URL + KApiEndPoints.app_dynamic_setting);
        Map mapRes = json.decode(response.body.toString());
        print("responseBody>>>>>>>>>>>" + mapRes.toString());

        if (response.statusCode == 200) {
          if (mapRes['code'] == "200") {
            setState(() {
              _isLoaded = false;
            });
            hindiMobile = mapRes['app_dynamic_setting']['hindiuser_mobile'];
            englishmobile = mapRes['app_dynamic_setting']['englishuser_mobile'];
            fb = mapRes['app_dynamic_setting']['fb'];
            twitter = mapRes['app_dynamic_setting']['twitter'];
            insta = mapRes['app_dynamic_setting']['insta'];
            youtube = mapRes['app_dynamic_setting']['youtube'];
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

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _loginButtonTapped() {}

  _forgetButtonTapped() {}
}
