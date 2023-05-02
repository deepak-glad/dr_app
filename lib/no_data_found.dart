import 'package:flutter/material.dart';

class RealDevice extends StatelessWidget {
  const RealDevice({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('App can only run in real devices'),
      ),
    );
  }
}
