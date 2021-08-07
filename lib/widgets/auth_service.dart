import 'package:astrology_app/controller/otp_controller.dart';
import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AuthClass {
  final otp_controller = Get.find<OtpController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(String phoneNumber, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      Get.snackbar('CodeSend', "Verification Completed",
          backgroundColor: Colors.black, colorText: Colors.white);
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      Get.snackbar('error', exception.toString(),
          backgroundColor: Colors.black, colorText: Colors.white);
    };
    PhoneCodeSent codeSent =
        (String verificationID, [int? forceResnedingtoken]) {
      print(forceResnedingtoken);
      print("Verification Code sent on the phone number");
      Get.snackbar('CodeSend', "Verification Code sent on the phone number",
          backgroundColor: Colors.black, colorText: Colors.white);
      setData(verificationID);
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      Get.snackbar('CodeSend', "TimeOut",
          backgroundColor: Colors.black, colorText: Colors.white);
    };
    try {
      await _auth.verifyPhoneNumber(
          timeout: Duration(seconds: 60),
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      Get.snackbar('error while verify phone number', "${e.toString()}",
          backgroundColor: Colors.black, colorText: Colors.white);
      print(e.toString());
    }
  }
}
