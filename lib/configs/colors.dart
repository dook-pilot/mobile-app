import 'package:flutter/material.dart';

const String colorHexCode = "00a9f3";

const Map<int, Color> materialColorSet = {
  50:Color. fromRGBO(0, 169, 243, .1),
  100:Color.fromRGBO(0, 169, 243, .2),
  200:Color.fromRGBO(0, 169, 243, .3),
  300:Color.fromRGBO(0, 169, 243, .4),
  400:Color.fromRGBO(0, 169, 243, .5),
  500:Color.fromRGBO(0, 169, 243, .6),
  600:Color.fromRGBO(0, 169, 243, .7),
  700:Color.fromRGBO(0, 169, 243, .8),
  800:Color.fromRGBO(0, 169, 243, .9),
  900:Color.fromRGBO(0, 169, 243, 1),
};

const Color backgroundColor = Color(0xFFFAFAFA);
Color primaryColor = Color(int.parse("0xFF$colorHexCode"));
Color rippleColor = Color(int.parse("0x22$colorHexCode"));
const Color lineColor = Color(0xFFC0C0C0);
const Color lineLightColor = Color(0xFFE9E9E9);
const Color textLightColor = Color(0xFF999999);
const Color textMidColor = Color(0xFF666666);
const Color textDarkColor = Color(0xFF393953);
const Color errorColor = Color(0xFFF44336);
const Color successColor = Color(0xff049f36);
const Color linkColor = Color(0xFF2196F3);

const Color shimmerBaseColor = lineColor;
const Color shimmerHighlightColor = Color(0xffbeebff);