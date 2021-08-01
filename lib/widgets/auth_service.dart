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
  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );
  //
  // final storage = new FlutterSecureStorage();
  // Future<void> googleSignIn(BuildContext context) async {
  //   try {
  //     GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  //     GoogleSignInAuthentication googleSignInAuthentication =
  //     await googleSignInAccount.authentication;
  //     AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     if (googleSignInAccount != null) {
  //       UserCredential userCredential =
  //       await _auth.signInWithCredential(credential);
  //       storeTokenAndData(userCredential);
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (builder) => HomePage()),
  //               (route) => false);
  //
  //       final snackBar =
  //       SnackBar(content: Text(userCredential.user.displayName));
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     }
  //   } catch (e) {
  //     print("here---->");
  //     final snackBar = SnackBar(content: Text(e.toString()));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }
  //
  // Future<void> signOut({BuildContext context}) async {
  //   try {
  //     await _googleSignIn.signOut();
  //     await _auth.signOut();
  //     await storage.delete(key: "token");
  //   } catch (e) {
  //     final snackBar = SnackBar(content: Text(e.toString()));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }
  //
  // void storeTokenAndData(UserCredential userCredential) async {
  //   print("storing token and data");
  //   await storage.write(
  //       key: "token", value: userCredential.credential.token.toString());
  //   await storage.write(
  //       key: "usercredential", value: userCredential.toString());
  // }
  //
  // Future<String> getToken() async {
  //   return await storage.read(key: "token");
  // }

  // Future<void> updatePhone(String phoneNumber, Function setData) async {
  //   PhoneVerificationFailed verificationFailed =
  //       (FirebaseAuthException exception) {
  //     // showSnackBar(context, exception.toString());
  //     print(exception.toString());
  //   };
  //   PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
  //       (String verificationID) {
  //     // showSnackBar(context, "Time out");
  //     print('time out');
  //   };
  //   try {
  //     _auth
  //       ..verifyPhoneNumber(
  //           phoneNumber: phoneNumber,
  //           timeout: const Duration(minutes: 2),
  //           verificationCompleted: (credential) async {
  //             await (await _auth.currentUser!).updatePhoneNumber(credential);
  //             // either this occurs or the user needs to manually enter the SMS code
  //           },
  //           verificationFailed: verificationFailed,
  //           codeSent: (verificationId, [forceResendingToken]) async {
  //             String smsCode;
  //             // get the SMS code from the user somehow (probably using a text field)
  //             final AuthCredential credential = PhoneAuthProvider.credential(
  //                 verificationId: verificationId, smsCode: '11111');
  //             await (await _auth.currentUser!).updatePhoneNumber(credential);
  //           },
  //           codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

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
    PhoneCodeSent codeSent = (String verificationID, int? forceResendingtoken) {
      // showSnackBar(context, "Verification Code sent on the phone number");

      print(forceResendingtoken);
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

  // void storeTokenAndData(UserCredential userCredential) async {
  //   print("storing token and data");
  //   await storage.write(
  //       key: "token", value: userCredential.credential.token.toString());
  //   await storage.write(
  //       key: "usercredential", value: userCredential.toString());
  // }

  Future<void> signInwithPhoneNumber(
    String verificationId,
    String smsCode,
  ) async {
    // try {
    //   AuthCredential credential = PhoneAuthProvider.credential(
    //       verificationId: verificationId, smsCode: smsCode);
    //
    //   await _auth.signInWithCredential(credential).then((value) async {
    //     if (value.user != null) {
    //       Get.to(() => HomeScreen(),
    //           transition: Transition.rightToLeft,
    //           curve: Curves.easeInToLinear,
    //           duration: Duration(milliseconds: 600));
    //     }
    //   });
    // }
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      // storeTokenAndData(userCredential);
      print('${verificationId}aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      Get.to(() => HomeScreen(),
          transition: Transition.rightToLeft,
          curve: Curves.easeInToLinear,
          duration: Duration(milliseconds: 600));
    } catch (e) {
      print('error ${e.toString()}');
    }
  }
}
