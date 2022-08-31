import 'dart:convert';

import 'package:drkashikajain/login/LoginScreen.dart';
import 'package:drkashikajain/model/key_model.dart';
import 'package:drkashikajain/profile/profile.dart';
import 'package:drkashikajain/utils/constants.dart';
import 'package:drkashikajain/utils/method.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'DetailScreen.dart';
import 'ForgetPasswordScreen.dart';
import 'RaisedGradientButton.dart';
import 'RegistrationScreen.dart';
import 'app_colors.dart';
import 'coursetypeScreen.dart';
import 'model/services.dart';

class HomeScreen extends StatefulWidget {
  String lang;

  HomeScreen(String lang) {
    this.lang = lang;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState(lang);
  }
}

class HomeScreenState extends State<HomeScreen> {
  String lang;
  bool internet = true;
  bool _isLoaded = false;
  Future<Services> service;

  SharedPreferences prefs;

  HomeScreenState(String lang) {
    this.lang = lang;
  }

  @override
  void initState() {
    super.initState();
    service = getData();
    getRazorPayKey();
    prefdata();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              print("toekn" + prefs.getString(KPrefs.USER_ID).toString());
              if (prefs.getString(KPrefs.USER_ID) != null) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
            },
            child: Container(
              margin: EdgeInsets.only(top: 20, right: 20),
              alignment: Alignment.topRight,
              child: Icon(
                Icons.account_circle,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: _homeWidgets(),
      ),
    );
  }

  Future<void> prefdata() async {
    prefs = await SharedPreferences.getInstance();
  }

  _homeWidgets() {
    return new ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          child: Center(
            child: Text("Welcome to Dr Kashika Jain's World",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Center(
            child: Text(
                "We hold your hand & take you from darkness towards light!",
                style: TextStyle(fontSize: 13, color: Colors.white)),
          ),
        ),
        FutureBuilder<Services>(
            future: service,
            builder: (context, snapshot) {
              if (!_isLoaded) {
                if (snapshot.hasData) {
                  return RefreshIndicator(
                    onRefresh: getData,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.data.length,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                gradient: LinearGradient(colors: [
                                  Colors.purpleAccent,
                                  Colors.blueAccent,
                                  Colors.blue
                                ])),
                            margin:
                                EdgeInsets.only(top: 10.0, right: 15, left: 15),
                            child: ListTile(
                              leading: Container(
                                height: 40.0,
                                child: FadeInImage.assetNetwork(
                                    placeholder: 'images/logo.png',
                                    image: snapshot.data.data[index].image),
                                /* child: Image.network(snapshot.data.data[index].image,
                                width: 20,
                                height: 20,
                                ),*/
                              ),
                              title: Text(
                                snapshot.data.data[index].title,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                              ),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CourseTypeScreen(
                                        lang, snapshot.data.data[index].id)),
                              ),
                            ));
                      },
                    ),
                  );
                } else {
                  return Method.loadingView(context);
                }
              } else {
                return Method.loadingView(context);
              }
            })
      ],
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: Colors.white),
    );
  }

  Future<Services> getData() async {
    internet = await Method.check();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoaded = true;
    });
    print("authorization_key" +
        ">>>>>>>>>>>>" +
        prefs.getString(KPrefs.TOKEN).toString());

    Map<String, String> body = {
      'access_token': prefs.getString(KPrefs.TOKEN).toString(),
      'language': lang
    };
    final response = await http.post(
        Uri.parse(KApiBase.SERVICE_BASE_URL + KApiEndPoints.Get_services),
        body: body);
    print("mapres" + response.toString());
    Map mapRes = json.decode(response.body);
    print("response body" + mapRes.toString());

    if (response.statusCode == 200) {
      setState(() {
        _isLoaded = false;
      });

      return Services.fromJson(json.decode(response.body));
    }
  }

  Future<KeyModel> getRazorPayKey() async {
    internet = await Method.check();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse(KApiBase.SERVICE_BASE_URL + KApiBase.razorPayApiKey),
    );

    if (response.statusCode == 200) {
      var data = KeyModel.fromJson(json.decode(response.body));
      var key = 'key';
      var keyId = data.gatewayList.first.key;
      prefs.setString(key, keyId);
      print("deepak" + ">>>>>>>>>>>>" + prefs.get('key'));

      return KeyModel.fromJson(json.decode(response.body));
    }
  }
}
