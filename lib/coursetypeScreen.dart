import 'dart:convert';
import 'dart:ffi';

import 'package:drkashikajain/HomeScreen.dart';
import 'package:drkashikajain/classes.dart';
import 'package:drkashikajain/primary_button.dart';
import 'package:drkashikajain/utils/constants.dart';
import 'package:drkashikajain/utils/method.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'RaisedGradientButton.dart';
import 'RegistrationScreen.dart';
import 'app_colors.dart';
import 'chooseplan.dart';
import 'courselist.dart';
import 'custom_view/utils.dart';
import 'package:http/http.dart' as http;

class CourseTypeScreen extends StatefulWidget {
  String lang;
  String service_id;

  CourseTypeScreen(String lang, String service_id) {
    this.lang = lang;
    this.service_id = service_id;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CourseTypeScreenState(lang, service_id);
  }
}

class CourseTypeScreenState extends State<CourseTypeScreen> {
  String lang;
  String service_id;

  String active;

  CourseTypeScreenState(String lang, String service_id) {
    this.lang = lang;
    this.service_id = service_id;
  }

  bool internet = true;
  bool _isLoaded = false;
  bool paidvisible = false;
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
    getPlanStatus();
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
        child: Form(
          child: ListView(
            shrinkWrap: false,
            physics: const AlwaysScrollableScrollPhysics(),
            children: <Widget>[_loginWidgeta()],
          ),
        ),
      ),
    );
  }

  _loginWidgeta() {
    return new Column(
      children: <Widget>[
        GestureDetector(
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
        new Container(
          margin: EdgeInsets.only(top: 50),
          height: 100.0,
          width: 100.0,
          child: Image.asset("images/logo.png"),
        ),
        new Container(
          margin: EdgeInsets.only(top: 50.0),
          child: Center(
              child: Text('VIDEO CATEGORY',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white))),
        ),
        Card(
          margin: EdgeInsets.only(top: 30, left: 40, right: 40),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ClassesScreen(service_id, lang, "basic")));
                  },
                  child: Card(
                    margin: EdgeInsets.only(
                        top: 30, left: 70, right: 70, bottom: 30),
                    color: AppColors.primary_color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            color: AppColors.white,
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Center(
                                child: Text(
                                  "Basic Videos",
                                  style: TextStyle(
                                      fontSize: 14, color: AppColors.white),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    if (active == "yes")
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ClassesScreen(service_id, lang, "advance")))
                      }
                    else
                      {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChoosePlanScreen(
                                        service_id, lang, "advance")))
                            .then((value) => getPlanStatus())
                      }
                  },
                  child: Card(
                    margin: EdgeInsets.only(left: 70, right: 70, bottom: 30),
                    color: AppColors.primary_color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            color: AppColors.white,
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Center(
                                child: Text(
                                  "Advance Videos",
                                  style: TextStyle(
                                      fontSize: 14, color: AppColors.white),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),

                // Visibility(
                //   visible: paidvisible,
                //   child: GestureDetector(
                //     onTap: () => {
                //       if (active == "yes")
                //         {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => ClassesScreen(
                //                       service_id, lang, "advance")))
                //         }
                //       else
                //         {
                //           Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) => ChoosePlanScreen(
                //                           service_id, lang, "advance")))
                //               .then((value) => getPlanStatus())
                //         }
                //     },
                //     child: Card(
                //       margin: EdgeInsets.only(left: 60, right: 60, bottom: 30),
                //       color: AppColors.primary_color,
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(10))),
                //       child: Padding(
                //         padding: const EdgeInsets.all(10.0),
                //         child: Column(
                //           children: [
                //             Icon(
                //               Icons.play_circle_outline,
                //               color: AppColors.white,
                //             ),
                //             GestureDetector(
                //               onTap: () {
                //                 /*  Navigator.push(
                //                     context,
                //                     MaterialPageRoute(
                //                         builder: (context) => HomeScreen()));*/
                //               },
                //               child: Container(
                //                   margin: EdgeInsets.only(top: 8),
                //                   child: Center(
                //                     child: Text(
                //                       "Courses",
                //                       style: TextStyle(
                //                           fontSize: 14, color: AppColors.white),
                //                     ),
                //                   )),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // Visibility(
        //   visible: true,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Visibility(
        //         visible: fb.toString().isEmpty ? false : true,
        //         child: GestureDetector(
        //           onTap: () {
        //             launchURL(fb);
        //           },
        //           child: new Container(
        //             margin: EdgeInsets.only(top: 50, left: 0),
        //             height: 30.0,
        //             width: 30.0,
        //             child: Image.asset("images/fb.png"),
        //           ),
        //         ),
        //       ),
        //       Visibility(
        //         visible: twitter.toString().isEmpty ? false : true,
        //         child: GestureDetector(
        //           onTap: () {
        //             launchURL(twitter);
        //           },
        //           child: new Container(
        //             margin: EdgeInsets.only(top: 50, left: 30),
        //             height: 30.0,
        //             width: 30.0,
        //             child: Image.asset("images/twitter.png"),
        //           ),
        //         ),
        //       ),
        //       Visibility(
        //         visible: insta.toString().isEmpty ? false : true,
        //         child: GestureDetector(
        //           onTap: () {
        //             launchURL(insta);
        //           },
        //           child: new Container(
        //             margin: EdgeInsets.only(top: 50, left: 30),
        //             height: 30.0,
        //             width: 30.0,
        //             child: Image.asset("images/instagram.png"),
        //           ),
        //         ),
        //       ),
        //       Visibility(
        //         visible: youtube.toString().isEmpty ? false : true,
        //         child: GestureDetector(
        //           onTap: () {
        //             launchURL(youtube);
        //           },
        //           child: new Container(
        //             margin: EdgeInsets.only(top: 50, left: 30),
        //             height: 30.0,
        //             width: 30.0,
        //             child: Image.asset("images/youtube.png"),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // Container(
        //     width: double.infinity,
        //     height: 40,
        //     margin: EdgeInsets.only(top: 30, left: 70, right: 70),
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.all(Radius.circular(5)),
        //         border: Border.all(color: Colors.white, width: 2)),
        //     child: Center(
        //       child: Text(
        //         "Call/Whatsapp",
        //         style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 18,
        //             color: Colors.white),
        //       ),
        //     )),
        // SizedBox(height: 20),
        // Row(
        //   children: [
        //     Container(
        //       padding: const EdgeInsets.only(left: 20),
        //       width: 80,
        //       child: Text(
        //         'ENGLISH',
        //         style: TextStyle(color: AppColors.white),
        //       ),
        //     ),
        //     continueButton(hindiMobile),
        //   ],
        // ),
        // SizedBox(height: 15),
        // Row(
        //   children: [
        //     Container(
        //       padding: const EdgeInsets.only(left: 20),
        //       width: 80,
        //       child: Text(
        //         'HINDI',
        //         style: TextStyle(color: AppColors.white),
        //       ),
        //     ),
        //     continueButton(englishmobile),
        //   ],
        // )
        /*Positioned(
          bottom: 0,
          child: Container(child: continueButton()),
        )*/
      ],
    );
  }

  Widget continueButton(String mobile) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: PrimaryButton(
          buttonText: 'Call +91 $mobile',
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

  Future<void> getPlanStatus() async {
    internet = await Method.check();
    setState(() {
      _isLoaded = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(KPrefs.USER_ID).toString() == "425") {
      setState(() {
        paidvisible = false;
      });
    } else {
      paidvisible = false;
    }
    Map<String, String> body = {
      'access_token': prefs.getString(KPrefs.TOKEN).toString(),
      'service_id': service_id,
    };
    if (internet != null && internet) {
      try {
        final response = await http.post(
            KApiBase.SERVICE_BASE_URL + KApiEndPoints.Check_plan_expire,
            body: body);
        Map mapRes = json.decode(response.body.toString());
        print("responseBody>>>>>>>>>>>" + mapRes.toString());

        if (response.statusCode == 200) {
          if (mapRes['code'] == "200") {
            setState(() {
              _isLoaded = false;
            });
            if (mapRes['message'].toString().compareTo("Plan is active now") ==
                0) {
              active = "yes";
            } else {
              active = "no";
            }
          } else {
            setState(() {
              _isLoaded = false;
            });
            // Utils.showErrorMessage(context, mapRes['message']);
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
