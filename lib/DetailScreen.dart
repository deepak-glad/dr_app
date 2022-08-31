import 'package:flutter/material.dart';

import 'ForgetPasswordScreen.dart';
import 'RaisedGradientButton.dart';
import 'RegistrationScreen.dart';

class DetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailScreenState();
  }
}

class DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
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
          child: _detailsWidgets(),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueAccent,
          title: Text("Home"),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    "images/Profile.png",
                    color: Colors.white,
                    height: 20.0,
                    width: 20.0,
                  )),
            ),
          ],
        ));
  }

  _detailsWidgets() {}

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: Colors.white),
    );
  }
}
