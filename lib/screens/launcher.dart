import 'dart:async';
import 'package:flutter/material.dart';

class LauncherActivity extends StatefulWidget {
  @override
  _LauncherActivityState createState() => _LauncherActivityState();
}

class _LauncherActivityState extends State<LauncherActivity> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Hero(
          tag: 'app_logo',
          child: Image.asset('assets/images/app_logo.png', height: 100),
        ),
      ),
    );
  }
}
