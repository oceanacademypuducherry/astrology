// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:forum/Forum/forum.dart';
// import 'package:get/get.dart';
// import 'package:velocity_x/velocity_x.dart';

// FirebaseAuth _auth = FirebaseAuth.instance;

// Future<void> verifyPhoneNumber(
//     String phoneNumber, BuildContext context, String verifyId) async {
//   PhoneVerificationCompleted verificationCompleted =
//       (PhoneAuthCredential phoneAuthCredential) async {
//     VxToast.show(context, msg: 'verification completed');
//   };
//   PhoneVerificationFailed verificationFailed =
//       (FirebaseAuthException exception) {
//     VxToast.show(context, msg: exception.toString());
//     print(exception);
//   };
//   PhoneCodeSent codeSent = (String verificationID, [int? forceResendingToken]) {
//     VxToast.show(context, msg: 'verification code sent on the phone number');
//     verifyId = verificationID;
//   };
//   PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//       (String verificationID) {
//     VxToast.show(context, msg: 'time out');
//   };
//   try {
//     await _auth.verifyPhoneNumber(
//         timeout: Duration(seconds: 30),
//         phoneNumber: phoneNumber,
//         verificationCompleted: verificationCompleted,
//         verificationFailed: verificationFailed,
//         codeSent: codeSent,
//         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
//   } catch (e) {
//     VxToast.show(context, msg: e.toString());
//   }
// }

// Future<void> signWithPhoneNumber(
//     String verificationId, String smsCode, BuildContext context) async {
//   try {
//     AuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId, smsCode: smsCode);
//     UserCredential userCredential =
//         await _auth.signInWithCredential(credential);
//     Get.to(Forum());
//     VxToast.show(context, msg: 'loged in');
//   } catch (e) {
//     print(e.toString());
//     VxToast.show(context, msg: e.toString());
//   }
// }
