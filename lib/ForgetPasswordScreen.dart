import 'dart:convert';

import 'package:drkashikajain/primary_button.dart';
import 'package:drkashikajain/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'custom_view/utils.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ForgetPasswordScreenState();
  }
}

class ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool _isLoaded = false;

  var _EmailTextController;

  @override
  void initState() {
    super.initState();
    _EmailTextController = TextEditingController();
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
            children: <Widget>[
              !_isLoaded
                  ? _loginWidgeta()
                  : Center(
                      child: Center(child: CircularProgressIndicator()),
                    ),
            ],
          ),
        ),
      ),
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text(
      //     'Forgot Password',
      //     style: TextStyle(
      //       fontSize: 16.0,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: true,

      // )
    );
  }

  _loginWidgeta() {
    return new Column(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(top: 30),
          height: 100.0,
          width: 100.0,
          child: Image.asset("images/logo.png"),
        ),
        new Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Center(
              child: Text('FORGOT PASSWORD',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white))),
        ),
        SizedBox(height: 100),
        new Container(
          margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: TextFormField(
            controller: _EmailTextController,
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.emailAddress,
            decoration: new InputDecoration(
              prefixIcon: Icon(Icons.email, color: Colors.white),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              fillColor: Colors.white,
              // filled: true,
              hintStyle: TextStyle(color: Colors.white),
              hintText: 'Email Id',
            ),
          ),
        ),
        continueButton()
      ],
    );
  }

  Widget continueButton() {
    return Padding(
      padding: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: PrimaryButton(buttonText: 'Send', onButtonPressed: _onClick),
    );
  }

  Future<void> forgotAPI() async {
    setState(() {
      _isLoaded = true;
    });
    print("email_or_phone>>>>>>>>>>>" + _EmailTextController.text.toString());

    Map<String, String> body = {
      'user_email': _EmailTextController.text.toString(),
    };
    // if (internet != null && internet) {
      try {
        final response = await http.post(
            Uri.parse(KApiBase.BASE_URL + KApiEndPoints.API_FORGOT),
            body: body);
        Map? mapRes = json.decode(response.body.toString());
        print("responseBody>>>>>>>>>>>" + mapRes.toString());

        if (response.statusCode == 200) {
          if (mapRes!['code'] == "200") {
            setState(() {
              _isLoaded = false;
            });
            Navigator.pop(context);
            Utils.showErrorMessage(context, mapRes['message']);
          } else {
            setState(() {
              _isLoaded = false;
            });
            Utils.showErrorMessage(context, mapRes['message']);
          }
        } else {
           setState(() {
              _isLoaded = false;
            });
          throw Exception('Unable to fetch products from the REST API');
        }
      } catch (e) {
         setState(() {
              _isLoaded = false;
            });
        print("Exception rest api: " + e.toString());
      }
    // }
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: Colors.white),
    );
  }

  _onClick() {
    if (_EmailTextController.text.toString().isEmpty) {
      Utils.showErrorMessage(context, "Please Enter Email ID");
    } else {
      forgotAPI();
    }
  }

  _forgetButtonTapped() {}
}
