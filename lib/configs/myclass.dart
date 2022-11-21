import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vng_pilot/configs/colors.dart';
import 'package:vng_pilot/widgets/dialogs.dart';

void showToast(String msg, {Toast length = Toast.LENGTH_SHORT, ToastGravity gravity = ToastGravity.BOTTOM}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: length,
      gravity: gravity,
      timeInSecForIosWeb: 2,
      backgroundColor: textDarkColor,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

bool isBlank(String? value) {
  return (value == null || value.trim().isEmpty);
}