import 'dart:convert';

import 'package:drkashikajain/model/subscription.dart';
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

class MySubscriptionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MySubscriptionScreenState();
  }
}

class MySubscriptionScreenState extends State<MySubscriptionScreen> {
  bool internet = true;
  bool _isLoaded = false;
  Future<Subscriptions> service;

  @override
  void initState() {
    super.initState();
    service = getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary_color,
        title: Text(
          'My Membership',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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

  _homeWidgets() {
    return new ListView(
      children: <Widget>[
        FutureBuilder<Subscriptions>(
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
                          key: UniqueKey(),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.white,
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 120,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: new BorderRadius.only(
                                          bottomLeft:
                                              const Radius.circular(150.0),
                                          topLeft: const Radius.circular(20),
                                          topRight:
                                              const Radius.circular(100.0))),
                                  child: Text(
                                    snapshot.data.data[index].plan_status,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: AppColors.primary_color),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.blueAccent,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 15),
                                              child: Container(
                                                child: Text(
                                                  "Offer Name : " +
                                                      snapshot.data.data[index]
                                                          .plan_name,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: AppColors.white),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: 0,
                                                    left: 15,
                                                    right: 15),
                                                child: Text(
                                                  "Service Name : " +
                                                      snapshot.data.data[index]
                                                          .service_name,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: AppColors.white),
                                                )),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: 0,
                                                    left: 15,
                                                    right: 15),
                                                child: Text(
                                                  "Rs. " +
                                                      snapshot.data.data[index]
                                                          .amount,
                                                  style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: 12),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  maxLines: 3,
                                                )),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: 0,
                                                    left: 15,
                                                    right: 15,
                                                    bottom: 10),
                                                child: Text(
                                                  "Expire on : " +
                                                      snapshot.data.data[index]
                                                          .subscribe_end_date,
                                                  style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: 12),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  maxLines: 3,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
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

  Future<Subscriptions> getData() async {
    internet = await Method.check();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoaded = true;
    });
    print("USER_ID" +
        ">>>>>>>>>>>>" +
        prefs.getString(KPrefs.USER_ID).toString());

    Map<String, String> body = {
      'user_id': prefs.getString(KPrefs.USER_ID).toString(),
    };
    final response = await http.post(
        Uri.parse(KApiBase.BASE_URL + KApiEndPoints.MySubscriptionPlan),
        body: body);
    print("mapres" + response.toString());
    Map mapRes = json.decode(response.body);
    print("response body" + mapRes.toString());

    if (response.statusCode == 200) {
      setState(() {
        _isLoaded = false;
      });

      return Subscriptions.fromJson(json.decode(response.body));
    }
  }
}
