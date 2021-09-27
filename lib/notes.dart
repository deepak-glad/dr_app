import 'dart:convert';
import 'package:drkashikajain/custom_view/utils.dart';
import 'package:drkashikajain/styles.dart';
import 'package:drkashikajain/transparent_inkwell.dart';
import 'package:drkashikajain/utils/constants.dart';
import 'package:drkashikajain/utils/method.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'app_colors.dart';
import 'model/demovideos.dart';
import 'model/pdf_file_model.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class NotesScreen extends StatefulWidget {
  String service_id;
  String lang;
  String type;
  String sub_category_name;
  String sub_category_id;

  NotesScreen(this.service_id, this.lang, this.type, this.sub_category_name,
      this.sub_category_id);
  @override
  _NotesScreenState createState() => _NotesScreenState(
      service_id, lang, type, sub_category_name, sub_category_id);
}

class _NotesScreenState extends State<NotesScreen> {
  String service_id;
  String lang;
  String type;
  String sub_category_name;
  String sub_category_id;
  Future<PdfModel> demovideos;

  _NotesScreenState(this.service_id, this.lang, this.type,
      this.sub_category_name, this.sub_category_id);
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _followingTextEditingController =
      TextEditingController();
  bool isUserSearching = false;
  bool internet = true;
  bool _isLoaded = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void _navigateToPage({String title, Widget child}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Center(child: child),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    demovideos = getData();
  }

  @override
  Widget build(BuildContext context) {
    print(service_id);
    return Scaffold(
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
    return ListView(
      children: [
        FutureBuilder<PdfModel>(
            future: demovideos,
            builder: (context, snapshot) {
              if (!_isLoaded) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.pdfList.length,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        margin: EdgeInsets.all(10),
                        child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: ListTile(
                              leading: Container(
                                height: 40.0,
                                child: FadeInImage.assetNetwork(
                                    placeholder: 'images/youtube.png',
                                    image:
                                        'https://w7.pngwing.com/pngs/466/409/png-transparent-pdf-computer-icons-adobe-acrobat-adobe-reader-others-miscellaneous-text-logo-thumbnail.png'),
                              ),
                              title: Text(
                                snapshot.data.pdfList[index].title,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary_color),
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                              ),
                              onTap: () {
                                _navigateToPage(
                                  title: snapshot.data.pdfList[index].title,
                                  child: PDF.network(
                                      snapshot.data.pdfList[index].pdf),
                                );
                              },
                            )),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              } else {
                return Method.nodata(context);
              }
            })
      ],
    );
  }

  Future<PdfModel> getData() async {
    internet = await Method.check();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoaded = true;
    });
    print("authorization_key" +
        ">>>>>>>>>>>>" +
        prefs.getString(KPrefs.TOKEN).toString());
    print('service_id' + service_id);
    print(lang);
    print(type);
    print('sub_c' + sub_category_id);
    // var body = {
    //   'topic_id': service_id,
    // };
    // final response = await http.post(
    //     'https://flawlessindia.co.in/drpanel/Course_api/Get_Course_PDF',
    //     body: body);
    Map<String, String> body = {
      // 'access_token': prefs.getString(KPrefs.TOKEN).toString(),
      'service_id': service_id,
      'language': lang,
      'type': type,
      'sub_category_id': sub_category_id,
    };
    final response = await http
        .post(KApiBase.SERVICE_BASE_URL + KApiEndPoints.PDF_list, body: body);
    print("mapres" + response.toString());
    Map mapRes = json.decode(response.body);
    print("response body" + mapRes.toString());

    if (mapRes['code'] == "200") {
      final extractedData = json.decode(response.body);
      List loadedCars = extractedData['PDF_list'];
      if (loadedCars.length != 0) {
        setState(() {
          _isLoaded = false;
        });
        return PdfModel.fromJson(json.decode(response.body));
      } else {
        setState(() {
          _isLoaded = true;
        });
        Utils.showErrorMessage(context, "No Data Found");
      }
    }
  }
}
