import 'dart:convert';

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
import 'courselist.dart';
import 'coursetypeScreen.dart';
import 'model/subservices.dart';

class ClassesScreen extends StatefulWidget {
  String lang;
  String service_id;
  String type;

  ClassesScreen(this.service_id, this.lang, this.type);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClassesScreenState(service_id, lang, type);
  }
}

class ClassesScreenState extends State<ClassesScreen> {
  String lang;
  bool internet = true;
  bool _isLoaded = false;
  Future<SubService> service;
  String service_id;
  String type;
  ClassesScreenState(this.service_id, this.lang, this.type);

  @override
  void initState() {
    super.initState();
    service = getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary_color,
        // title: Text("CLASSES"),
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
        FutureBuilder<SubService>(
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
                                    BorderRadius.all(Radius.circular(10))),
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
                                snapshot.data.data[index].sub_category_name,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.blue,
                              ),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CourseListScreen(
                                        service_id,
                                        lang,
                                        widget.type,
                                        snapshot
                                            .data.data[index].sub_category_name,
                                        snapshot
                                            .data.data[index].sub_category_id)),
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

  Future<SubService> getData() async {
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
      'service_id': service_id,
    };
    final response = await http.post(
        KApiBase.SERVICE_BASE_URL + KApiEndPoints.Get_sub_services,
        body: body);
    print("mapres" + response.toString());
    Map mapRes = json.decode(response.body);
    print("response body" + mapRes.toString());

    if (response.statusCode == 200) {
      setState(() {
        _isLoaded = false;
      });

      return SubService.fromJson(json.decode(response.body));
    }
  }
}
