import 'package:astrology_app/Forum/forumController.dart';
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
  final countryCode = '+91'.obs;

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      VxToast.show(context, msg: 'verification completed');
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      VxToast.show(context, msg: exception.toString());
      print(exception);
    };
    PhoneCodeSent codeSent =
        (String verificationID, [int? forceResendingToken]) {
      VxToast.show(context, msg: 'verification code sent on the phone number');
      verifyId.value = verificationID;
      countdown();
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      VxToast.show(context, msg: 'time out');
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
      VxToast.show(context, msg: e.toString());
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
        if (_forumContreller.userSession == userData['phoneNumber']) {
          ourUser = true;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('user', userPhoneNumber.value);
          String userNumber = prefs.getString('user').toString();
          print(userData.data());
          _forumContreller.setUserSession(
              '${countryCode.value.toString()} ${userPhoneNumber.value.toString()}');
          _forumContreller.setUserInfo(userData.data());
          _forumContreller.setUserDocumentId(userData.id);
          break;
        }
      }

      if (ourUser) {
        Get.to(() => BottomNavigation(),
            transition: Transition.rightToLeft,
            curve: Curves.easeInToLinear,
            duration: Duration(milliseconds: 600));
        Get.snackbar('success', "You are loggesd in",
            backgroundColor: Colors.black, colorText: Colors.white);
      } else {
        print('else working ');
        Get.to(
            () => Register(
                  userNumber: _forumContreller.userSession.value.toString(),
                ),
            transition: Transition.rightToLeft,
            curve: Curves.easeInToLinear,
            duration: Duration(milliseconds: 600));
      }
      print('${_forumContreller.userSession} uuuuuuuuuuuuuuuuuuuuuuuuu');

      VxToast.show(context, msg: 'loged in');
    } catch (e) {
      print(e.toString());
      VxToast.show(context, msg: e.toString());
      VxDialog.showConfirmation(context,
          title: userPhoneNumber.value.toString(),
          content: "You want Change your Number",
          cancel: 'No',
          confirm: 'Yes', onConfirmPress: () {
        Get.back();
      });
    }
  }

  countdown() async {
    while (otpCount.value > 0) {
      await Future.delayed(Duration(seconds: 1));
      otpCount(otpCount.value - 1);
      if (otpCount.value == 0) {
        resend.value = true;
      }
    }
  }
}
