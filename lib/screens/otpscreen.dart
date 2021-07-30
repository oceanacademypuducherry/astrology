import 'dart:async';

import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
// import 'package:countdown_flutter/countdown_flutter.dart';

class OTP extends StatefulWidget {
  String? phoneNumber;
  OTP({this.phoneNumber});

  @override
  State<OTP> createState() => _OTPState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

class _OTPState extends State<OTP> {
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.white,
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
  int start = 120;
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
    // _verifyPhone();
  }

  void startTimer() {
    const onsec = Duration(minutes: 2);
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
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: PinPut(
                  fieldsCount: 6,
                  withCursor: true,
                  textStyle:
                      const TextStyle(fontSize: 25.0, color: Colors.black),
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
                    print(pin);
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: verificationIdFinal,
                              smsCode: pin))
                          .then((value) async {
                        if (value.user != null) {
                          Get.to(() => HomeScreen(),
                              transition: Transition.rightToLeft,
                              curve: Curves.easeInToLinear,
                              duration: Duration(milliseconds: 600));
                        }
                      });
                    } catch (e) {
                      print("invalid");
                    }
                  },
                ),
              ),
              RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                    text: "Send OTP again in ",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  TextSpan(
                    text: "00:$start",
                    style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
                  ),
                  TextSpan(
                    text: " sec ",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              )),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(
                  top: 25,
                  left: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  onPressed: wait
                      ? null
                      : () async {
                          setState(() {
                            start = 60;
                            wait = true;
                            buttonName = "Resend";
                          });
                          await _verifyPhone();
                          Get.to(() => HomeScreen(),
                              transition: Transition.rightToLeft,
                              curve: Curves.easeInToLinear,
                              duration: Duration(milliseconds: 600));
                        },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 2,
                    primary: Colors.white,
                    onPrimary: Colors.blue,
                    textStyle: const TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 15,
                    ),
                  ),
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _verifyPhone() async {
    PhoneCodeSent codeSent = (String verificationId, [int? resendToken]) {
      verificationIdFinal = verificationId;
    };
    await _auth.verifyPhoneNumber(
        phoneNumber: '${widget.phoneNumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("Verification  Before Completed");
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              print("user lOgged in");
            }
          });
          print("Verification After  Completed");
        },
        verificationFailed: (FirebaseAuthException e) {
          print('${e.message}Verification error');
        },
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            verificationIdFinal = verificationID;
          });
          print("Verification Code send to an phone");
        },
        timeout: Duration(seconds: 120));
  }

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }
}
