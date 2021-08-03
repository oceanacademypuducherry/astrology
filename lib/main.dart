import 'package:astrology_app/controller/otp_controller.dart';
import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:astrology_app/screens/loginscreen.dart';
import 'package:astrology_app/screens/registerscreen.dart';
import 'package:astrology_app/widgets/BottomNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(OtpController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigation(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static String? session;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget route = Login();

  sessionCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyApp.session = prefs.getString('user') ?? null;

    route = MyApp.session != null ? HomeScreen() : Login();
    print("routeChecking in mainpage${route}");
    print("routeChecking in mainpage session${MyApp.session}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.blue,
        resizeToAvoidBottomInset: false,
        body: route,
      ),
    );
  }
}
