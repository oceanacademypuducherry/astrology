import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AuthClass {
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

  Future<void> signInwithPhoneNumber(
    String verificationId,
    String smsCode,
  ) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      await _auth.signInWithCredential(credential).then((value) async {
        if (value.user != null) {
          Get.to(() => HomeScreen(),
              transition: Transition.rightToLeft,
              curve: Curves.easeInToLinear,
              duration: Duration(milliseconds: 600));
        }
      });

      // Get.to(() => HomeScreen(),
      //     transition: Transition.rightToLeft,
      //     curve: Curves.easeInToLinear,
      //     duration: Duration(milliseconds: 600));
      // storeTokenAndData(userCredential);
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (builder) => HomePage()),
      //         (route) => false);

      // showSnackBar(context, "logged In");
    } catch (e) {
      print('error ${e.toString()}');
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
