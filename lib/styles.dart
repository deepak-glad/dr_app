import 'dart:io';

import 'package:drkashikajain/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

final bool isIOS = Platform.isIOS;

bool get isWeb => kIsWeb;

bool get isMobile => !isWeb && (Platform.isIOS || Platform.isAndroid);

bool get isDesktop => !isWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

bool get isApple => !isWeb && (Platform.isIOS || Platform.isMacOS);

bool get isGoogle => !isWeb && (Platform.isAndroid || Platform.isFuchsia);

//Medium Styles
const tsMediumHeadingGrey1 =
    TextStyle(color: AppColors.textGrey1, fontSize: 22.0, fontWeight: FontWeight.w500);

final tsDarkGreyBlueBoldTs16 = TextStyle(
    color: AppColors.dark_grey_blue_40,
    fontSize: 16,
    height: 1.5,
    fontFamily: font_gilroy,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1);

final tsDarkGreyBlue60BoldTs16 = TextStyle(
    color: AppColors.textPrimaryColor60,
    fontSize: 16,
    height: 1.5,
    fontFamily: font_gilroy,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1);

final tsDarkGreyBlueBoldTs14 = TextStyle(
    color: AppColors.dark_grey_blue_40,
    fontSize: 14,
    fontFamily: font_gilroy,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.18);

final tsGreyBlueBoldTs14 = TextStyle(
  color: AppColors.dark_grey_blue,
  fontSize: 14,
  fontFamily: font_gilroy,
  height: 1.5,
  fontWeight: FontWeight.w500,
);

final tsDarkGreyBlue60BoldTs14 = TextStyle(
    color: AppColors.textPrimaryColor60,
    fontSize: 14,
    fontFamily: font_gilroy,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.18);

//Bold Styles

const tsDarkGreyBlueBoldTs26 = TextStyle(
    color: AppColors.dark_grey_blue,
    fontFamily: font_gilroy,
    fontSize: 26,
    fontWeight: FontWeight.w700);

const tsDarkGreyBlueBoldTs24 = TextStyle(
    color: AppColors.dark_grey_blue,
    fontSize: 24,
    height: 1.5,
    fontFamily: font_gilroy,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.09);

const tsDarkGreyBlueBoldTs22 = TextStyle(
  color: AppColors.dark_grey_blue,
  fontSize: 22,
  fontFamily: font_gilroy,
  fontWeight: GilroyBold,
);

const tsBoldButtonPrimary1 =
    TextStyle(color: AppColors.textGrey1, fontSize: 18.0, fontWeight: FontWeight.w700);

const tsMediumTextLightGrey16 =
    TextStyle(color: AppColors.textPrimaryColor40, fontSize: 16.0, fontWeight: FontWeight.w500);

const tsMediumTextLight60Grey16 =
    TextStyle(color: AppColors.textPrimaryColor60, fontSize: 16.0, fontWeight: FontWeight.w500);

const tsMediumTextGrey60Primary16 =
    TextStyle(color: AppColors.textPrimaryColor60, fontSize: 16.0, fontWeight: FontWeight.w500);

const tsMediumTextGrey50Primary12 =
    TextStyle(color: AppColors.textPrimaryColor50, fontSize: 12.0, fontWeight: FontWeight.w500);

const tsMediumTextGrey50Primary14 =
    TextStyle(color: AppColors.textPrimaryColor50, fontSize: 14.0, fontWeight: FontWeight.w500);

const tsMediumTextGreyPrimary12 =
    TextStyle(color: AppColors.textPrimaryColor, fontSize: 12.0, fontWeight: FontWeight.w500);

const tsMediumTextGrey40Primary16 =
    TextStyle(color: AppColors.textPrimaryColor40, fontSize: 16.0, fontWeight: FontWeight.w500);

const tsMediumTextDarkGrey16 =
    TextStyle(color: AppColors.textPrimaryColor, fontSize: 16.0, fontWeight: FontWeight.w500);

const tsSemiBoldTextDarkBlue15 =
    TextStyle(color: AppColors.textPrimaryColor, fontSize: 15.0, fontWeight: FontWeight.w600);

const tsSemiBoldTextGrey13 =
    TextStyle(color: AppColors.textGrey5, fontSize: 13.0, fontWeight: FontWeight.w600);

const tsBoldTextGrey13 =
    TextStyle(color: AppColors.textPrimaryColor, fontSize: 13.0, fontWeight: FontWeight.w700);

const tsMediumTextGrey13 =
    TextStyle(color: AppColors.textPrimaryColor60, fontSize: 13.0, fontWeight: FontWeight.w500);

const tsSemiBoldTextGreen13 =
    TextStyle(color: AppColors.greenColor, fontSize: 13.0, fontWeight: FontWeight.w600);

const tsSemiBoldTextDarkGrey18 =
    TextStyle(color: AppColors.black, fontSize: 18.0, fontWeight: FontWeight.w600);

const tsSemiBoldTextDarkGrey15 =
    TextStyle(color: AppColors.black, fontSize: 15.0, fontWeight: FontWeight.w600);

const tsBoldTextWhite14 =
    TextStyle(color: AppColors.white, fontSize: 14.0, fontWeight: FontWeight.w700);

const tsMediumTextWhite14 =
    TextStyle(color: AppColors.white, fontSize: 14.0, fontWeight: FontWeight.w500);

const tsMediumTextGrey80PrimaryText14 =
    TextStyle(color: AppColors.textPrimaryColor80, fontSize: 14.0, fontWeight: FontWeight.w500);

const tsMediumTextGreyPrimaryText14 =
    TextStyle(color: AppColors.textPrimaryColor, fontSize: 14.0, fontWeight: FontWeight.w500);

const tsBoldTextDarkGrey26 =
    TextStyle(color: AppColors.textPrimaryColor, fontSize: 26.0, fontWeight: FontWeight.w700);

const tsBoldTextDarkGrey22 =
    TextStyle(color: AppColors.textPrimaryColor, fontSize: 22.0, fontWeight: FontWeight.w700);

const tsBoldTextWhite22 =
    TextStyle(color: AppColors.white, fontSize: 22.0, fontWeight: FontWeight.w700);

const tsBoldTextWhite28 =
    TextStyle(color: AppColors.white, fontSize: 28.0, fontWeight: FontWeight.w700);

const tsBoldTextWhite68 =
    TextStyle(color: AppColors.white, fontSize: 68.0, fontWeight: FontWeight.w700);

const tsBoldTextDarkGrey18 =
    TextStyle(color: AppColors.textPrimaryColor, fontSize: 18.0, fontWeight: FontWeight.w700);

const tsBoldTextDarkGrey20 =
    TextStyle(color: AppColors.textPrimaryColor, fontSize: 20.0, fontWeight: FontWeight.w700);

const tsBoldTextWhite20 =
    TextStyle(color: AppColors.white, fontSize: 20.0, fontWeight: FontWeight.w700);

const tsBoldTextLightGrey16 =
    TextStyle(color: AppColors.textPrimaryColor30, fontSize: 16.0, fontWeight: FontWeight.w700);

const tsBoldTextLight40Grey16 =
    TextStyle(color: AppColors.textPrimaryColor40, fontSize: 16.0, fontWeight: FontWeight.w700);

const tsBoldTextLight40Grey14 =
    TextStyle(color: AppColors.textPrimaryColor40, fontSize: 14.0, fontWeight: FontWeight.w700);

const tsBoldTextDarkGrey16 =
    TextStyle(color: AppColors.textPrimaryColor, fontSize: 16.0, fontWeight: FontWeight.w700);

const tsSemiBoldTextDarkGrey16 =
    TextStyle(color: AppColors.textPrimaryColor, fontSize: 16.0, fontWeight: FontWeight.w600);

const tsBoldTextDarkGrey14 =
    TextStyle(color: AppColors.textPrimaryColor, fontSize: 14.0, fontWeight: FontWeight.w700);

const tsBoldTextDarkGrey12 =
    TextStyle(color: AppColors.textPrimaryColor, fontSize: 12.0, fontWeight: FontWeight.w700);

const tsBoldTextDarkGrey10 =
    TextStyle(color: AppColors.textPrimaryColor, fontSize: 10.0, fontWeight: FontWeight.w700);

const tsBoldTextPink16 =
    TextStyle(color: AppColors.pinkColor, fontSize: 16.0, fontWeight: FontWeight.w700);

const tsSemiBoldTextPink15 =
    TextStyle(color: AppColors.pinkColor, fontSize: 15.0, fontWeight: FontWeight.w600);

const tsBoldTextPink23 =
    TextStyle(color: AppColors.pinkColor, fontSize: 23.0, fontWeight: FontWeight.w700);

const tsMediumTextPink14 =
    TextStyle(color: AppColors.pinkColor, fontSize: 14.0, fontWeight: FontWeight.w500);

const tsSemiBoldTextPink14 =
    TextStyle(color: AppColors.pinkColor, fontSize: 14.0, fontWeight: FontWeight.w600);

const tsBoldTextGreen16 =
    TextStyle(color: AppColors.greenColor, fontSize: 16.0, fontWeight: FontWeight.w700);

const tsBoldTextWhite16 =
    TextStyle(color: AppColors.white, fontSize: 16.0, fontWeight: FontWeight.w700);

const tsBoldText30White16 =
    TextStyle(color: AppColors.white30, fontSize: 16.0, fontWeight: FontWeight.w700);

const tsSemiBoldTextGrey40Primary14 =
    TextStyle(color: AppColors.textPrimaryColor40, fontSize: 14.0, fontWeight: FontWeight.w600);

const tsSemiBoldTextGrey50Primary14 =
    TextStyle(color: AppColors.textPrimaryColor50, fontSize: 14.0, fontWeight: FontWeight.w600);

const tsSemiBoldTextGreyPrimary14 =
    TextStyle(color: AppColors.textPrimaryColor, fontSize: 14.0, fontWeight: FontWeight.w600);

const tsSemiBoldTextPink13 =
    TextStyle(color: AppColors.pinkColor, fontSize: 13.0, fontWeight: FontWeight.w600);

const tsSemiBoldTextBattleshipGrey16 = TextStyle(
    color: AppColors.battleship_grey, fontSize: 16, height: 1.1, fontWeight: GilroySemiBold);

const tsGreenBoldGreen23 =
    TextStyle(color: AppColors.greenColor, fontSize: 23, fontWeight: GilroyBold);
