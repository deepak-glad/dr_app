import 'package:drkashikajain/strings.dart';
import 'package:drkashikajain/styles.dart';
import 'package:drkashikajain/transparent_inkwell.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {required this.buttonText, required this.onButtonPressed});

  final String buttonText;
  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: () {
        onButtonPressed();
      },
      child: Container(
          margin: EdgeInsets.only(right: 20, left: 20),
          width: MediaQuery.of(context).size.width / 2,
          height: 40,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(buttonText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.primary_color,
                    fontSize: 14,
                    fontWeight: FontWeight.w700)),
          )),
    );
  }
}

class SmallPrimaryButton extends StatelessWidget {
  const SmallPrimaryButton(
      {required this.buttonText, required this.onButtonPressed});

  final String buttonText;
  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    double screenWidth;
    screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        onButtonPressed();
      },
      child: Container(
          width: isIOS ? screenWidth * .496 : screenWidth * .517,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.pinkColor,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Center(
            child: Text(buttonText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontFamily: font_gilroy,
                    fontWeight: FontWeight.w500)),
          )),
    );
  }
}

class AddNewButton extends StatelessWidget {
  const AddNewButton(
      {this.buttonText = '+ Add New', required this.onButtonPressed});

  final String buttonText;
  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return TransparentInkWell(
      onTap: () {
        onButtonPressed();
      },
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: AppColors.primary_color,
                style: BorderStyle.solid),
            color: AppColors.pale_grey_two,
            borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: buttonText,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.primary_color)),
          ),
        ),
      ),
    );
  }
}
