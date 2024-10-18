import 'dart:async';
import 'dart:convert';

import 'package:drkashikajain/primary_button.dart';
import 'package:drkashikajain/utils/constants.dart';
import 'package:drkashikajain/utils/method.dart';
import 'package:drkashikajain/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_colors.dart';
import 'model/plans.dart';
import 'terms_condition.dart';

// ignore: must_be_immutable
class ChoosePlanScreen extends StatefulWidget {
  String? service_id;
  String? lang;
  String type;

  ChoosePlanScreen(this.service_id, this.lang, this.type);

  @override
  _ChoosePlanScreenState createState() =>
      _ChoosePlanScreenState(service_id, lang, type);
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen> {
  String? service_id;
  String? lang;
  String type;
  String? plan_id = "";
  String? valid;
  String? title;
  double amount = 0.0;
  double discount = 0.0;
  var _promocodeTextFormField;
  late double promo_amount;
  var transectionId;
  bool isTermsSelected = false;

  _ChoosePlanScreenState(this.service_id, this.lang, this.type);

  String? userId;
  String? addressId;
  int? value;

  // AddressBloc addressBloc;
  int listIndex = 0;
  bool checkedValue = false;
  bool _isLoaded = false;
  late Future<PlanModel?> planlist;
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _promocodeTextFormField = TextEditingController();
    planlist = getPlanData();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    print(value);
    print(_isEmpty);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: _isEmpty
            ? ListView(
                shrinkWrap: false,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 20, left: 15),
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 15, right: 20),
                            child: Center(
                              child: Text(
                                "Advance Video",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Method.novideodatafound(context)
                  ])
            : Form(
                child: ListView(
                  shrinkWrap: false,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: <Widget>[
                    addressList(),
                    Visibility(
                      visible: value != null ? true : false,
                      child: Container(
                        margin: EdgeInsets.only(right: 20, top: 5),
                        alignment: Alignment.topRight,
                        child: Text(
                          "Total Price : $amount",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                      child: Text(
                        'Apply Promocode  (if any)',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: new Container(
                        margin:
                            EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                        child: TextFormField(
                          controller: _promocodeTextFormField,
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.black),
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: 'Enter Promo Code  (Optional)',
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: discount > 0 ? true : false,
                      child: Container(
                        margin: EdgeInsets.only(right: 20, top: 5),
                        alignment: Alignment.topRight,
                        child: Text(
                          "Discount : $discount",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                        ),
                      ),
                    ),
                    continueButton(),
                    termsConditionWidget(),
                    Visibility(
                      visible: value != null ? true : false,
                      child: Container(
                        margin: EdgeInsets.only(right: 20, top: 15),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Total Price : $amount",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.colorLightYellow),
                        ),
                      ),
                    ),
                    PayButton()
                  ],
                ),
              ),
      ),
    );
  }

  Widget continueButton() {
    return Container(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
          top: 25,
          left: MediaQuery.of(context).size.width - 200,
        ),
        child: PrimaryButton(
            buttonText: 'Apply Promo Code',
            onButtonPressed: () => _continueButtonTap()),
      ),
    );
  }

  Widget termsConditionWidget() {
    return Padding(
        padding: EdgeInsets.only(top: 25.0),
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              Checkbox(
                  checkColor: Color(0xFFF394A8B),
                  activeColor: Color(0xFFFFFFFF),
                  focusColor: Color(0xFFF394A8B),
                  hoverColor: Color(0xFFF394A8B),
                  value: isTermsSelected,
                  onChanged: (newValue) async {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      isTermsSelected = !isTermsSelected;
                    });
                  }),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TermsAndConditionScreen()));
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'I agree to the ',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.black),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Terms of Service, ',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: 'Privacy Policy ',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(text: '&'),
                          TextSpan(
                              text: ' Refund Policy. ',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ));
  }

  Widget PayButton() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 30, right: 30),
        child: PrimaryButton(
            buttonText: 'Pay Now', onButtonPressed: () => _payButtonTap()),
      ),
    );
  }

  addressList() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 15),
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.black,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 15, right: 20),
                  child: Center(
                    child: Text(
                      "Choose your plan",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: FutureBuilder<PlanModel?>(
                  future: planlist,
                  builder: (context, snapshot) {
                    // print(widget.service_id);

                    if (!_isLoaded) {
                      if (snapshot.hasData) {
                        // print(snapshot.data.data);
                        return RefreshIndicator(
                            onRefresh: getPlanData,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.data!.length,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      margin: EdgeInsets.all(5),
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Row(children: [
                                            Expanded(
                                              child: RadioListTile(
                                                  value: index,
                                                  title: Text(snapshot
                                                      .data!.data![index].title!),
                                                  groupValue: value,
                                                  onChanged: (dynamic ind) {
                                                    setState(() {
                                                      value = ind;
                                                      plan_id = snapshot
                                                          .data!.data![index].id;
                                                      valid = snapshot
                                                          .data!
                                                          .data![index]
                                                          .valid_from;
                                                      title = snapshot.data!
                                                          .data![index].title;
                                                      amount = double.parse(
                                                          snapshot
                                                              .data!
                                                              .data![index]
                                                              .amount!);
                                                      print(valid);

                                                      /*    address_id = snapshot
                                              .data
                                              .data[index]
                                              .id;
                                        print(snapshot.data
                                              .data[index].id);*/
                                                    });
                                                    // setState(() => ,)
                                                  }),
                                            ),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 15),
                                                child: Text(
                                                  "Rs. " +
                                                      snapshot.data!.data![index]
                                                          .amount!,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: AppColors
                                                          .primary_color,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                          ])));
                                }));
                      } else {
                        return Method.loadingView(context);
                      }
                    } else {
                      return Method.loadingView(context);
                    }
                  })),
        ],
      ),
    );
  }

  void refreshData() {
    //addressBloc.addressListRequest(userId);
  }

  void popPupMenuClick(String addressId, TapDownDetails details) {
    //_showPopupMenu(details.globalPosition, addressId);

    addressPopup(context, addressId);
  }

  void deliverAddressClick(String addId) {
    addressId = addId;
    // print("addId " + addId + " " + widget.grandTotals.finalAmounts);
    //  addressBloc.shippingCheckRequest(addId, widget.grandTotals.finalAmounts);
  }

  FutureOr onGoBack(dynamic value) {
    print("value " + value);
    refreshData();
    setState(() {});
  }

  deleteAddress(String id) {
    // addressBloc.addressRemoveRequest(id);
  }

  addressPopup(BuildContext context, String addressId) {
    return showDialog(
      context: context,
      //barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Are you sure to delete this Address",
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "No",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Yes",
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // deleteAddress(addressId);
              },
            )
          ],
        );
      },
    );
  }

  bool _isEmpty = false;

  Future<PlanModel?> getPlanData() async {
    print(lang);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoaded = true;
    });
    print("authorization_key" +
        ">>>>>>>>>>>>" +
        prefs.getString(KPrefs.TOKEN).toString());

    Map<String, String?> body = {
      'access_token': prefs.getString(KPrefs.TOKEN).toString(),
      'service_id': service_id,
      'language': lang
    };
    final response = await http.post(
        Uri.parse(KApiBase.SERVICE_BASE_URL + KApiEndPoints.Get_Plan_Package),
        body: body);
    print("mapres" + response.toString());
    Map mapRes = json.decode(response.body);
    print("response body" + mapRes.toString());
    if (mapRes["PackageList"].length == 0) {
      setState(() {
        _isEmpty = true;
        _isLoaded = false;
      });
      return PlanModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 200) {
      setState(() {
        _isLoaded = false;
      });

      return PlanModel.fromJson(json.decode(response.body));
    }
  }

  // bool _isPromoCodeApplied = false;
  String? codeName = '';

  Future<void> applyPromoCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoaded = true;
    });
    print("authorization_key" +
        ">>>>>>>>>>>>" +
        prefs.getString(KPrefs.TOKEN).toString());
    print(_promocodeTextFormField.text);

    Map<String, String?> body = {
      'access_token': prefs.getString(KPrefs.TOKEN).toString(),
      'service_id': service_id,
      'promo_code': _promocodeTextFormField.text,
    };
    final response = await http.post(
        Uri.parse(KApiBase.SERVICE_BASE_URL + KApiEndPoints.CheckPromoCode),
        body: body);
    print("mapres" + response.toString());
    Map? mapRes = json.decode(response.body);
    print("response body" + mapRes.toString());

    if (response.statusCode == 200) {
      // if (codeName == _promocodeTextFormField.text) {
      //   setState(() {
      //     _isPromoCodeApplied = true;
      //   });
      // }
      if (mapRes!['code'] == '200') {
        setState(() {
          _isLoaded = false;

          promo_amount = double.parse(mapRes['amount']);
          discount = double.parse(mapRes['amount']);

          if (amount < promo_amount) {
            amount = 0;
          } else {
            codeName = _promocodeTextFormField.text;
            amount = amount - promo_amount;
            print('amount_d' + amount.toString());
          }
        });
      } else {
        setState(() {
          _isLoaded = false;
        });
        Utils.showErrorMessage(context, mapRes['message']);
      }
    } else {
      Utils.showErrorMessage(context, mapRes!['message']);
    }
  }

  void openCheckout(amount, name, description, contact, email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var key = prefs.get('key');
    var options = {
      'key': key,
      'amount': amount,
      'name': '$name',
      'description': '$description',
      'prefill': {'contact': '$contact', 'email': '$email'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    transectionId = response.paymentId;
    Fluttertoast.showToast(
        msg: "Payment Successful",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    confirmPayment();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  void _handlePaymentError(PaymentFailureResponse response) {
    print('On Error ::  $response');
    Fluttertoast.showToast(
        msg: "Payment Failed!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> confirmPayment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoaded = true;
    });
    print("authorization_key" +
        ">>>>>>>>>>>>" +
        prefs.getString(KPrefs.TOKEN).toString());
    print("service_id" + ">>" + service_id!);
    print("plan_id" + ">>" + plan_id!);
    print("title" + ">>" + title!);
    print("amount" + ">>" + amount.toString());
    print("valid_from" + ">>" + valid!);
    print("transection_id" + ">>" + transectionId.toString());

    Map<String, String?> body = {
      'access_token': prefs.getString(KPrefs.TOKEN).toString(),
      'service_id': service_id,
      'plan_id': plan_id,
      'title': title,
      'amount': amount.toString(),
      'valid_from': valid,
      'transection_id': amount == 0 ? 'full_promocode_applied' : transectionId,
    };

    final response = await http.post(
        Uri.parse(
            KApiBase.SERVICE_BASE_URL + KApiEndPoints.PurchasePackagePlan),
        body: body);
    print("mapres" + response.toString());
    Map? mapRes = json.decode(response.body);
    print("response body" + mapRes.toString());

    if (response.statusCode == 200) {
      if (mapRes!['code'] == "200") {
        Utils.showErrorMessage(context, mapRes['message']);
        Navigator.pop(context);
        setState(() {
          _isLoaded = false;
        });
      } else {
        setState(() {
          _isLoaded = false;
        });
        Utils.showErrorMessage(context, mapRes['message']);
      }
    }
  }

  _continueButtonTap() {
    if (plan_id!.isEmpty) {
      Utils.showErrorMessage(context, "Please Select Offer");
    } else if (_promocodeTextFormField.text.isEmpty) {
      Utils.showErrorMessage(context, "Please Enter Promo code");
    } else if (codeName == _promocodeTextFormField.text) {
      Utils.showErrorMessage(context, "Promo Code is already applied");
    } else {
      applyPromoCode();
    }
  }

  _payButtonTap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (plan_id!.isEmpty) {
      Utils.showErrorMessage(context, "Please Select Offer");
    } else if (!isTermsSelected) {
      Utils.showErrorMessage(context,
          "Terms of Service, Privacy Policy & Refund Policy field should be checked before payment");
    } else if (amount == 0) {
      confirmPayment();
    } else {
      openCheckout(
          amount * 100,
          prefs.getString(KPrefs.USER_NAME).toString(),
          title,
          "91" + prefs.getString(KPrefs.MOBILE).toString(),
          prefs.getString(KPrefs.USER_EMAIL).toString());
    }
  }
}
