import 'package:flutter/material.dart';

class CommonColors {
  static Color lightColor = Colors.white;
  static Color darkColor = getColor(0xff2c2c2c);
  static Color grayColor = getColor(0xff959595);
  static Color darkGrayColor = getColor(0xff676767);
  static Color borerColor = disabledColor;
  static Color cardBorderColor = getColor(0xffe0e0e0);
  static Color cardColor = getColor(0xfffafafa);
  static Color disabledColor = getColor(0xffededed);
  static Color disabledTextColor = getColor(0xffc7c7c7);
  static Color dividerColor = getColor(0xfff1f1f1);
  static Color scaffoldColor = Colors.white;

  static Color valueIndicatorColor = getColor(0xff355ADE);


}


Map<int, Color> _color =
{
  50:Color.fromRGBO(136,14,79, .1),
  100:Color.fromRGBO(136,14,79, .2),
  200:Color.fromRGBO(136,14,79, .3),
  300:Color.fromRGBO(136,14,79, .4),
  400:Color.fromRGBO(136,14,79, .5),
  500:Color.fromRGBO(136,14,79, .6),
  600:Color.fromRGBO(136,14,79, .7),
  700:Color.fromRGBO(136,14,79, .8),
  800:Color.fromRGBO(136,14,79, .9),
  900:Color.fromRGBO(136,14,79, 1),
};

MaterialColor getColor(int primary) {
  return MaterialColor(primary, _color);
}