import 'dart:async';

import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTP extends StatefulWidget {
  String? phoneNumber;
  OTP({this.phoneNumber});

  @override
  State<OTP> createState() => _OTPState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

class _OTPState extends State<OTP> {
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String? fullname;
  String? email;
  String? query;
  bool validation = false;
  String countryCode = 'India (+91)';
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  String verificationIdFinal = "";
  String smsCode = "";
  // var getCountryCodes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('==================${widget.phoneNumber}');
    verifyPhoneNumber("${widget.phoneNumber}");
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.phoneNumber);
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            // image:  DecorationImage(
            //     image:  AssetImage("images/background_image.png"),
            //     fit: BoxFit.cover,
            //     alignment: Alignment.center
            // ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                // color: Colors.black26,
                height: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: CircleAvatar(
                              backgroundColor: Colors.black12,
                              radius: 40,
                              child: Icon(
                                Icons.lock_open_outlined,
                                color: Colors.white,
                                size: 25,
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            'OTP',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Ubuntu',
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          child: const Text(
                            'Please enter the OTP sent to your mobile number',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Ubuntu',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '${widget.phoneNumber}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Ubuntu',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: PinPut(
                    fieldsCount: 6,
                    withCursor: true,
                    textStyle:
                        const TextStyle(fontSize: 25.0, color: Colors.white),
                    eachFieldWidth: 40.0,
                    eachFieldHeight: 55.0,
                    // onSubmit: (String pin) => _showSnackBar(pin),
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: pinPutDecoration,
                    selectedFieldDecoration: pinPutDecoration,
                    followingFieldDecoration: pinPutDecoration,
                    pinAnimationType: PinAnimationType.fade,
                    onSubmit: (pin) async {
                      try {
                        await _auth
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: verificationIdFinal,
                                smsCode: smsCode))
                            .then((value) async {
                          if (value.user != null) {
                            Get.to(() => HomeScreen(),
                                transition: Transition.rightToLeft,
                                curve: Curves.easeInToLinear,
                                duration: Duration(milliseconds: 600));
                          }
                        });
                      } catch (e) {
                        /// todosnakbar
                        print("Invalid Creadentials");
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      print("Verification Completed");
      _auth.signInWithCredential(phoneAuthCredential).then((value) async {
        if (value.user != null) {
          print("user lOgged in");
        }
      });
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      // showSnackBar(context, exception.toString());
      print("Verification error ${exception.toString()}");
    };
    PhoneCodeSent codeSent = (String verificationId, [int? resendToken]) {
      verificationIdFinal = verificationId;
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      print("Verification Code send to an phone");
      verificationIdFinal = verificationID;
      // showSnackBar(context, "Time out");
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
      print("error ${e.toString()}");
    }
  }
}
