import 'package:drkashikajain/demovideo.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'notes.dart';

class CourseListScreen extends StatefulWidget {
  final String? service_id;
  final String? lang;
  final String type;
  final String? sub_category_name;
  final String? sub_category_id;

  CourseListScreen(this.service_id, this.lang, this.type,
      this.sub_category_name, this.sub_category_id);

  @override
  State<StatefulWidget> createState() {
    return CourseListScreenState(
        service_id, lang, type, sub_category_name, sub_category_id);
  }
}

class CourseListScreenState extends State<CourseListScreen> {
  String? service_id;
  String? lang;
  String type;
  String? sub_category_name;
  String? sub_category_id;

  String? header;

  CourseListScreenState(this.service_id, this.lang, this.type,
      this.sub_category_name, this.sub_category_id);

  bool _isLoaded = false;
  String? id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (type == "paid") {
      type = "video";
      header = "VIDEOS";
    } else {
      header = "VIDEOS";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
        ),
        body: _isLoaded
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: new Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Container(
                          child: Expanded(
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: <Widget>[
                              Visibility(
                                visible: true,
                                child: Container(
                                  color: AppColors.primary_color,
                                  constraints:
                                      BoxConstraints.expand(height: 50),
                                  child: TabBar(

                                      // indicatorColor: Colors.white,
                                      labelStyle: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                      //For Selected tab
                                      unselectedLabelStyle:
                                          TextStyle(fontSize: 16.0),
                                      tabs: [
                                        Visibility(child: Tab(text: "Videos")),
                                        Tab(text: "Notes"),
                                      ]),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: TabBarView(children: [
                                    DemoVideosScreen(service_id, lang, type,
                                        sub_category_name, sub_category_id),
                                    NotesScreen(service_id, lang, type,
                                        sub_category_name, sub_category_id)
                                  ]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ));
  }
}
