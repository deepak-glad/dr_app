import 'package:flutter/material.dart';

class AppColors extends MaterialColor {
  AppColors(int primary, Map<int, Color> swatch) : super(primary, swatch);

  static const int primaryColorValue = 0xff308ef1;

  static const primaryColor = Color(0xff308ef1);
  static const primaryColor10 = Color(0x1A1a416a);

  static const colorTransparent = Color(0x00000000);

  //Snackbar color
  static const snackBarColor = Color(0xff424242);
  static const snackBarRed = Color(0xffe53e3f);
  static const snackBarGreen = Color(0xff2dca73);

  //White shades
  static const white = Color(0xFFFFFFFF);
  static const white30 = Color(0x4DFFFFFF);
  static const white60 = Color(0x99FFFFFF);
  static final white90 = const Color(0x99FFFFFF).withOpacity(0.9);
  static const white10 = Color(0x1AFFFFFF);

  //Black shades
  static const black = Color(0xFF000000);
  static const black10 = Color(0x1A000000);
  static const blackShade2 = Color(0xFF101010);
  static const blackOpacity10 = Color(0x1A000000);
  static const blackOpacity15 = Color(0x26000000);
  static const blackOpacity5 = Color(0x0D000000);
  static const black80 = Color(0xCC000000);
  static const black2 = Color(0xff343434);
  static const black70 = Color(0xB3000000);
  static const black60 = Color(0x99000000);

  //Grey Shades
  static const textPrimaryColor = Color(0xFF2c3551);
  static const textPrimaryColor80 = Color(0xCC2c3551);
  static const textPrimaryColor40 = Color(0x662c3551);
  static const textPrimaryColor50 = Color(0x802c3551);
  static const textPrimaryColor60 = Color(0x992c3551);
  static const textPrimaryColor30 = Color(0x4D2c3551);
  static const textPrimaryColor8 = Color(0x142c3551);
  static const textGrey1 = Color(0xFF2a2e32);
  static const textGrey2 = Color(0xFFa8b6c7);
  static const textGrey3 = Color(0xFFecf0f5);
  static const textGrey4 = Color(0xFFd4d6dc);
  static const pale_grey_two = Color(0xFFe6eef2);
  static const textGrey5 = Color(0xFFc2c4c7);
  static const textGrey6 = Color(0xFFecf0f1);
  static const textGrey7 = Color(0x91ecf0f5);
  static const battleship_grey = Color(0xFF797a7c);
  static const textGrey8 = Color(0x19264974);
  static const textGrey9 = Color(0x3decf0f5);
  static const textDarkBlue = Color(0xFF264974);
  static const lightPurple = Color(0x4a8e79cf);
  static const purple = Color(0xff8e79cf);
  static const blue1 = Color(0xff5b4e86);
  static const greenColor = Color(0xff48b352);
  static const cyanColor = Color(0xffaae7ff);
  static const warm_grey = Color(0xff979797);
  static const dark_grey_blue_24 = Color(0x3e2c3551);

  static const pinkColor = Color(0xFFf4486d);
  static const colorLightYellow = Color(0xFFffd049);
  static const dark_grey_blue = Color(0xff2c3551);
  static const light_green = Color(0x0c48b352);
  // ignore: non_constant_identifier_names
  static final dark_grey_blue_40 = Color(0xff2c3551).withOpacity(0.4);
  // ignore: non_constant_identifier_names
  static final dark_grey_blue_20 = Color(0xff2c3551).withOpacity(0.2);
  // ignore: non_constant_identifier_names
  static final dark_grey_blue_08 = Color(0x142c3551);

  static const training_color_1 = Color(0xFFaa9cf7);
  static const training_color_2 = Color(0xff9cb7f7);
  static const training_color_3 = Color(0xfff7a89c);

  static const Color primary_color =
      MaterialColor(primaryColorValue, <int, Color>{
    50: Color(primaryColorValue),
    100: Color(primaryColorValue),
    200: Color(primaryColorValue),
    300: Color(primaryColorValue),
    400: Color(primaryColorValue),
    500: Color(primaryColorValue),
    600: Color(primaryColorValue),
    700: Color(primaryColorValue),
    800: Color(primaryColorValue),
    900: Color(primaryColorValue),
  });
}
