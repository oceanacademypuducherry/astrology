import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/atentication/login.dart';
import 'package:astrology_app/atentication/otp_page.dart';
import 'package:astrology_app/screens/registerscreen.dart';
import 'package:astrology_app/widgets/BottomNavigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class OTPController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  final verifyId = ''.obs;
  final userPhoneNumber = ''.obs;
  final otpCount = 60.obs;
  final resend = false.obs;
  final getCountryCode = '+91'.obs;
  final isSubmited = false.obs;

  final isLoading = true.obs;

  setBreake(stopTimer, BuildContext context) {
    isSubmited(stopTimer);
    VxToast.show(context, msg: 'timerBreaked');
  }

  setUserPhoneNumber(PhoneNumber) {
    userPhoneNumber(PhoneNumber);
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context) async {
    dynamic close = context.showLoading(msg: "Loading");

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      VxToast.show(context, msg: 'verification completed');
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      Future.delayed(0.100.seconds, close);
      VxDialog.showAlert(
        context,
        title: "Request Failed",
        content: exception.message.toString(),
      );
      print(exception.message);
    };
    PhoneCodeSent codeSent =
        (String verificationID, [int? forceResendingToken]) {
      Future.delayed(0.100.seconds, close);
      VxToast.show(context, msg: 'verification code sent on the phone number');

      verifyId.value = verificationID;
      countdown(context);
      Get.to(OTP());
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      Future.delayed(0.100.seconds, close);
      print(
          '..........................................timeOut .......................................');
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent != null ? codeSent : codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message.toString());
      print(e);
    }
  }

  Future<void> signWithPhoneNumber(String smsCode, context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verifyId.value, smsCode: smsCode);
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      bool ourUser = false;

      final getUserData = await _firestore.collection('newusers').get();

      for (var userData in getUserData.docs) {
        if (userPhoneNumber.value.toString() == userData['phoneNumber']) {
          ourUser = true;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('user', userPhoneNumber.value.toString());
          String userNumber = prefs.getString('user').toString();
          print(userData.data());
          _forumContreller.setUserSession(userPhoneNumber.value.toString());
          _forumContreller.setUserInfo(userData.data());
          _forumContreller.setUserDocumentId(userData.id);
        }
      }

      if (ourUser) {
        setBreake(true, context);
        Get.offAll(() => BottomNavigation(),
            transition: Transition.rightToLeft,
            curve: Curves.easeInToLinear,
            duration: Duration(milliseconds: 600));
      } else {
        print('else working ');
        setBreake(true, context);
        Get.offAll(
            () => Register(
                  userNumber: userPhoneNumber.value,
                ),
            transition: Transition.rightToLeft,
            curve: Curves.easeInToLinear,
            duration: Duration(milliseconds: 600));
      }
      print('${_forumContreller.userSession} uuuuuuuuuuuuuuuuuuuuuuuuu');

      // VxToast.show(context, msg: 'loged in');
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      VxDialog.showAlert(context,
          title: 'Login Faild', content: e.message.toString());
      VxToast.show(context, msg: e.toString());
    }
  }

  countdown(BuildContext context) async {
    otpCount.value = 60;
    resend.value = false;
    while (otpCount.value > 0) {
      await Future.delayed(Duration(seconds: 1));
      otpCount(otpCount.value - 1);
      if (isSubmited.value) {
        break;
      }
      if (otpCount.value == 0) {
        VxDialog.showAlert(context,
            title: "Login Failed",
            content: "Request Timeout Try Again", onPressed: () {
          Get.off(Login());
        });
        resend.value = true;
      }
    }
    print('timer breaked kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
  }
}
