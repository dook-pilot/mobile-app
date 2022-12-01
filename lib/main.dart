import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vng_pilot/configs/colors.dart';
import 'package:vng_pilot/screens/home.dart';
import 'package:vng_pilot/screens/launcher.dart';
import 'package:vng_pilot/screens/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VNG Pilot',
      theme: ThemeData(
          primarySwatch: MaterialColor(int.parse("0xFF$colorHexCode"), materialColorSet),
          splashColor: Color(int.parse("0x44$colorHexCode")),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          })),
      onGenerateRoute: (settings) {
        var routes = <String, WidgetBuilder>{
          '/': (context) => LauncherActivity(),
          '/login': (context) => const LoginActivity(),
          '/home': (context) => const HomeActivity(),
        };
        WidgetBuilder builder = routes[settings.name] as WidgetBuilder;
        return MaterialPageRoute(
          builder: (context) => builder(context),
          settings: RouteSettings(name: settings.name),
        );
      },
    );
  }
}
