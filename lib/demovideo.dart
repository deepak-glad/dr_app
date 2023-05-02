import 'dart:convert';
import 'package:drkashikajain/VideoPlayer.dart';
import 'package:drkashikajain/utils/constants.dart';
import 'package:drkashikajain/utils/method.dart';
import 'package:drkashikajain/youtubePlayer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'app_colors.dart';
import 'custom_view/utils.dart';
import 'model/demovideos.dart';

class DemoVideosScreen extends StatefulWidget {
  String service_id;
  String lang;
  String type;
  String sub_category_name;
  String sub_category_id;

  DemoVideosScreen(this.service_id, this.lang, this.type,
      this.sub_category_name, this.sub_category_id);

  @override
  _DemoVideosScreenState createState() => _DemoVideosScreenState(
      service_id, lang, type, sub_category_name, sub_category_id);
}

class _DemoVideosScreenState extends State<DemoVideosScreen> {
  String service_id;
  String lang;
  String type;
  String sub_category_name;
  String sub_category_id;

  _DemoVideosScreenState(this.service_id, this.lang, this.type,
      this.sub_category_name, this.sub_category_id);

  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _followingTextEditingController =
      TextEditingController();
  bool isUserSearching = false;
  bool internet = true;
  bool _isLoaded = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<DemoVideos> demovideos;

  @override
  void initState() {
    super.initState();
    demovideos = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/back.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: _homeWidgets(),
      ),
    );
  }

  _homeWidgets() {
    return ListView(
      children: [
        FutureBuilder<DemoVideos>(
            future: demovideos,
            builder: (context, snapshot) {
              if (!_isLoaded) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.data.length,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (snapshot.data.data[index].content_type
                                  .compareTo("youtube") !=
                              0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChewieDemo(
                                        snapshot.data.data[index].video)));
                          } else {
                            // print(Method.getYoutubeVideoIdByURL(
                            //     snapshot.data.data[index].video));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlayVideoFromYoutube(
                                        Method.getYoutubeVideoIdByURL(
                                            snapshot.data.data[index].video))));
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          margin: EdgeInsets.all(10),
                          child: Container(
                              /* decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),*/
                              child: ListTile(
                            leading: Container(
                              height: 40.0,
                              child: FadeInImage.assetNetwork(
                                  placeholder: 'images/youtube.png',
                                  image: snapshot.data.data[index].thumnail),
                            ),
                            title: Text(
                              snapshot.data.data[index].title,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary_color),
                            ),
                            trailing: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            ),
                          )),
                        ),
                      );
                    },
                  );
                } else {
                  return Method.nodata(context);
                }
              } else {
                return Method.nodata(context);
              }
            })
      ],
    );
  }

  Future<DemoVideos> getData() async {
    internet = await Method.check();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoaded = true;
    });
    print("authorization_key" +
        ">>>>>>>>>>>>" +
        prefs.getString(KPrefs.TOKEN).toString());
    print("service_id" + ">>>>>>>>>>>>" + service_id);
    print("language" + ">>>>>>>>>>>>" + lang);
    print("video_type" + ">>>>>>>>>>>>" + type);
    print("sub_category_id" + ">>>>>>>>>>>>" + sub_category_id);

    Map<String, String> body = {
      'access_token': prefs.getString(KPrefs.TOKEN).toString(),
      'service_id': service_id,
      'language': lang,
      'video_type': type,
      'sub_category_id': sub_category_id,
    };
    final response = await http.post(
        Uri.parse(KApiBase.SERVICE_BASE_URL + KApiEndPoints.video_list),
        body: body);
    print("mapres" + response.toString());
    Map mapRes = json.decode(response.body);
    print("response body1" + mapRes.toString());

    if (mapRes['code'] == "200") {
      setState(() {
        _isLoaded = false;
      });
      print("test");
      final extractedData = json.decode(response.body);
      List loadedCars = extractedData['video_list'];
      if (loadedCars.length != 0) {
        setState(() {
          _isLoaded = false;
        });
        return DemoVideos.fromJson(json.decode(response.body));
      } else {
        setState(() {
          _isLoaded = true;
        });
        Utils.showErrorMessage(context, "No Data Found");
      }
    }
  }
}
