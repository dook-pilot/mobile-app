import 'package:flutter/material.dart';
import 'package:vng_pilot/configs/colors.dart';
import 'package:vng_pilot/configs/configs.dart';
import 'package:vng_pilot/configs/myclass.dart';

class LoginActivity extends StatefulWidget {
  const LoginActivity({Key? key}) : super(key: key);

  @override
  State<LoginActivity> createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _username;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)],
              borderRadius: BorderRadius.circular(CONTAINER_RADIUS),
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAlias,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/app_logo.png', height: 60),
                    SizedBox(height: 15),
                    Text(
                      'Login your account',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      // controller: _firstNameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        labelText: 'Username',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 0.5, color: textLightColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(WIDGET_RADIUS)),
                          borderSide: BorderSide(color: textLightColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(WIDGET_RADIUS)),
                          borderSide: BorderSide(color: textLightColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(WIDGET_RADIUS)),
                          borderSide: BorderSide(color: errorColor),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(WIDGET_RADIUS)),
                          borderSide: BorderSide(color: errorColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(WIDGET_RADIUS)),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: const TextStyle(fontSize: 16, color: textDarkColor),
                      textCapitalization: TextCapitalization.characters,
                      validator: (value) {
                        if ((value ?? "").trim().isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value ?? "";
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      // controller: _firstNameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        labelText: 'Password',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 0.5, color: textLightColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(WIDGET_RADIUS)),
                          borderSide: BorderSide(color: textLightColor),
                        ),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(WIDGET_RADIUS)), borderSide: BorderSide(color: textLightColor)),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(WIDGET_RADIUS)),
                          borderSide: BorderSide(color: errorColor),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(WIDGET_RADIUS)),
                          borderSide: BorderSide(color: errorColor),
                        ),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(WIDGET_RADIUS)), borderSide: BorderSide(color: primaryColor)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: const TextStyle(fontSize: 16, color: textDarkColor),
                      textCapitalization: TextCapitalization.words,
                      obscureText: true,
                      validator: (value) {
                        if ((value ?? "").trim().isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value ?? "";
                      },
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(WIDGET_RADIUS),
                          )),
                          elevation: MaterialStateProperty.all(3),
                          backgroundColor: MaterialStateProperty.all(primaryColor),
                          textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white))),
                      onPressed: () {
                        _formKey.currentState!.save();
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        if (_username == "demo" && _password == "2345") {
                          Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                        }
                        else {
                          showToast("Invalid username & password");
                        }

                      },
                      child: Text('Login', style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
