import 'package:flutter/material.dart';

import '../app_colors.dart';
import 'widget_animations.dart';

OverlayEntry createOverlayEntry(
    BuildContext context, String message, Color bgColor) {
  final double _screenWidth = MediaQuery.of(context).size.width;

  return OverlayEntry(
    builder: (context) => Positioned(
        top: 50.0,
        width: _screenWidth - 20,
        left: 10,
        child: Material(
          elevation: 10.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(10)),
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                softWrap: true,
                text: TextSpan(
                    text: message,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.white,
                    )),
              ),
            ),
          ),
        )),
  );
}
