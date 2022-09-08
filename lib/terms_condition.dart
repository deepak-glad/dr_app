import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TermsAndConditionScreen extends StatefulWidget {
  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  int load = 0;

  @override
  Widget build(BuildContext context) {
    print(load);
    return Scaffold(
        appBar: AppBar(title: Text('Legal')),
        body: Stack(children: [
          WebViewPlus(
            onProgress: (value) {
              print(value);
              setState(() {
                load = value;
              });
            },
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              controller.loadUrl('images/index.html');
            },
          ),
          if (load < 99) Center(child: CircularProgressIndicator())
        ]));
  }
}
