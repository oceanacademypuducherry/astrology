import 'package:astrology_app/screens/loginscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:astrology_app/screens/registerscreen.dart';

void main() {
  runApp(
      const GetMaterialApp(
        debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.pink,
      resizeToAvoidBottomInset : false,
      // extendBodyBehindAppBar: true,
      body: Register(),
    ),
  ));
}







