import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:astrology_app/screens/loginscreen.dart';
import 'package:astrology_app/widgets/BottomNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:astrology_app/screens/registerscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:astrology_app/screens/HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: false,
      // extendBodyBehindAppBar: true,
      body: BottomNavigation(),
    ),
  ));
}
