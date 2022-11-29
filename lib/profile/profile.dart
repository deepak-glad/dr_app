import 'dart:convert';

import 'package:drkashikajain/login/LoginScreen.dart';
import 'package:drkashikajain/custom_view/route_animations.dart';
import 'package:drkashikajain/custom_view/utils.dart';
import 'package:drkashikajain/primary_button.dart';
import 'package:drkashikajain/utils/constants.dart';
import 'package:drkashikajain/utils/method.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_colors.dart';
import '../mysubscriptionscreen.dart';
import '../styles.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  bool internet = true;
  bool _isLoaded = false;
  bool paidvisible = false;
  bool isEdit = false;
  var fb;
  var twitter;
  var insta;
  var youtube;

  var name;
  var mobile;
  var email;
  var city;
  var country;

  var _textName = TextEditingController();
  var _textEmail = TextEditingController();
  var _textMobile = TextEditingController();
  var _textCity = TextEditingController();
  var _textCountry = TextEditingController();

  @override
  void initState() {
    super.initState();
    getProfile();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/back.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            child: ListView(
              shrinkWrap: false,
              physics: const AlwaysScrollableScrollPhysics(),
              children: <Widget>[_loginWidgeta()],
            ),
          ),
        ),
      ),
    );
  }

  _loginWidgeta() {
    return new Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: GestureDetector(
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
              ),
            ),
            GestureDetector(
              onTap: () {
                _showLogoutDialog();
              },
              child: Container(
                margin: EdgeInsets.only(top: 20, right: 20, left: 15),
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.power_settings_new_outlined,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
        new Container(
          margin: EdgeInsets.only(top: 40),
          height: 80.0,
          width: 80.0,
          child: Image.asset("images/logo.png"),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: TextFormField(
            enabled: isEdit,
            controller: _textName,
            style: TextStyle(color: Colors.white),
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              labelText: 'Name',
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Enter Name',
            ),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: TextFormField(
            enabled: isEdit,
            controller: _textMobile,
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              labelText: 'Mobile Number',
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Enter Mobile Number',
            ),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: TextFormField(
            enabled: isEdit,
            controller: _textEmail,
            // enabled: isEdit,
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.emailAddress,
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              labelText: 'Email Address',
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Enter Email Address',
            ),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: TextFormField(
            enabled: isEdit,
            controller: _textCountry,
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.visiblePassword,
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0)),
              labelText: 'Country',
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Enter Country',
            ),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: TextFormField(
            enabled: isEdit,
            controller: _textCity,
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.visiblePassword,
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              labelText: 'City',
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Enter City',
            ),
          ),
        ),
        !isEdit ? editButton() : updateButton(),
        Visibility(
          visible: false,
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
        Visibility(visible: paidvisible, child: continueButton())
        /*Positioned(
          bottom: 0,
          child: Container(child: continueButton()),
        )*/
      ],
    );
  }

  Widget editButton() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 30, left: 30, right: 30),
        child: PrimaryButton(
            buttonText: 'EDIT',
            onButtonPressed: () {
              setState(() {
                isEdit = true;
              });
            }),
      ),
    );
  }

  Widget updateButton() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 30, left: 30, right: 30),
        child: PrimaryButton(
            buttonText: 'UPDATE', onButtonPressed: () => _loginButtonTapped()),
      ),
    );
  }

  Widget continueButton() {
    return Padding(
      padding: EdgeInsets.only(top: 70, left: 70, right: 70),
      child: PrimaryButton(
          buttonText: 'My Membership',
          onButtonPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MySubscriptionScreen()));
          }),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: Colors.white),
    );
  }

  _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout', style: tsBoldTextDarkGrey22),
          content: Text('Are you sure you want to logout?',
              style: tsMediumTextGrey40Primary16),
          contentTextStyle: tsMediumTextGrey40Primary16,
          actions: <Widget>[
            TextButton(
                child: Text('Yes', style: tsMediumTextDarkGrey16),
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.clear();
                  //await preferences.commit();
                  navigateToPage();
                }),
            TextButton(
              child: Text('No', style: tsMediumTextDarkGrey16),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToPage() {
    Navigator.pushAndRemoveUntil(
        context,
        RouteAnimationSlideFromRight(widget: LoginScreen()),
        (Route<dynamic> route) => false);
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> getData() async {
    internet = await Method.check();
    setState(() {
      _isLoaded = true;
    });

    if (internet != null && internet) {
      try {
        final response = await http.get(Uri.parse(
            KApiBase.SERVICE_BASE_URL + KApiEndPoints.app_dynamic_setting));
        Map mapRes = json.decode(response.body.toString());
        print("responseBody>>>>>>>>>>>" + mapRes.toString());

        if (response.statusCode == 200) {
          if (mapRes['code'] == "200") {
            setState(() {
              _isLoaded = false;
            });

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

  Future<void> getProfile() async {
    internet = await Method.check();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(KPrefs.USER_ID).toString() == "425") {
      setState(() {
        paidvisible = false;
      });
    } else {
      paidvisible = true;
    }
    setState(() {
      _isLoaded = true;
    });

    if (internet != null && internet) {
      try {
        Map<String, String> body = {
          'access_token': prefs.getString(KPrefs.TOKEN).toString(),
        };
        final response = await http.post(
            Uri.parse(KApiBase.BASE_URL + KApiEndPoints.get_profile),
            body: body);
        Map mapRes = json.decode(response.body.toString());
        print("responseBody>>>>>>>>>>>" + mapRes.toString());

        if (response.statusCode == 200) {
          //  if (mapRes['code'] == "200") {
          setState(() {
            _isLoaded = false;
          });

          name = mapRes['user_details']['username'];
          mobile = mapRes['user_details']['user_phone'];
          email = mapRes['user_details']['user_email'];
          city = mapRes['user_details']['city_id'];
          country = mapRes['user_details']['country_id'];
          _textName.text = name;
          _textMobile.text = mobile;
          _textEmail.text = email;
          _textCity.text = city;
          _textCountry.text = country;
          /* } else {
            setState(() {
              _isLoaded = false;
            });
            Utils.showErrorMessage(context, mapRes['message']);
          }*/
        } else {
          throw Exception('Unable to fetch products from the REST API');
        }
      } catch (e) {
        print("Exception rest api: " + e);
      }
    }
  }

  Future<void> updateProfile() async {
    internet = await Method.check();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _isLoaded = true;
    });

    if (internet != null && internet) {
      try {
        Map<String, String> body = {
          'access_token': prefs.getString(KPrefs.TOKEN).toString(),
          'first_name': _textName.text.toString(),
          'user_phone': _textMobile.text.toString(),
          'city_id': _textCity.text.toString(),
          'country_name': _textCountry.text.toString(),
        };
        final response = await http.post(
            Uri.parse(KApiBase.BASE_URL + KApiEndPoints.user_update_profile),
            body: body);
        Map mapRes = json.decode(response.body.toString());
        print("responseBody>>>>>>>>>>>" + mapRes.toString());

        if (response.statusCode == 200) {
          //  if (mapRes['code'] == "200") {
          setState(() {
            _isLoaded = false;
          });
          Utils.showErrorMessage(context, mapRes['message']);
        } else {
          throw Exception('Unable to fetch products from the REST API');
        }
      } catch (e) {
        print("Exception rest api: " + e);
      }
    }
  }

  _loginButtonTapped() {
    updateProfile();
  }
}
