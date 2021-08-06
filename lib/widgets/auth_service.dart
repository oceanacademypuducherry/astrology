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
      print('verificatin completed');
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      // showSnackBar(context, exception.toString());
      print(exception.toString());
    };
    PhoneCodeSent codeSent =
        (String verificationID, [int? forceResnedingtoken]) {
      // showSnackBar(context, "Verification Code sent on the phone number");

      print(forceResnedingtoken);
      print("Verification Code sent on the phone number");
      setData(verificationID);
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      // showSnackBar(context, "Time out");
      print('time out');
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
      // showSnackBar(context, e.toString());
      print(e.toString());
    }
  }
  // Future<void> signInwithPhoneNumber(
  //   String verificationId,
  //   String smsCode,
  // ) async {
  //   try {
  //     AuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId, smsCode: smsCode);
  //
  //     UserCredential userCredential =
  //         await _auth.signInWithCredential(credential);
  //     // storeTokenAndData(userCredential);
  //     print('${verificationId}aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
  //     Get.to(() => HomeScreen(),
  //         transition: Transition.rightToLeft,
  //         curve: Curves.easeInToLinear,
  //         duration: Duration(milliseconds: 600));
  //   } catch (e) {
  //     print('error ${e.toString()}');
  //   }
  // }
}
