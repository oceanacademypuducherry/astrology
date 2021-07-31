import 'dart:async';

import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:astrology_app/screens/registerscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OTP extends StatefulWidget {
  String? verificationId;
  String? userNumber;
  OTP({this.verificationId, this.userNumber});

  @override
  State<OTP> createState() => _OTPState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _OTPState extends State<OTP> {
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  TextEditingController _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();

  String? fullname;
  String? email;
  String? query;
  bool validation = false;
  String countryCode = 'India (+91)';
  int start = 120;
  bool wait = false;
  String buttonName = "Send";

  String smsCode = "";
  var validate;
  // var getCountryCodes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('==================${widget.verificationId}');
    // startTimer();

    // _verifyPhone();
  }

  late Timer _timer;
  int _start = 120;

  // void startTimer() {
  //   print("++++++++++++++++++++++");
  //   const oneSec = const Duration(seconds: 1);
  //   _timer = new Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       if (_start == 0) {
  //         setState(() {
  //           timer.cancel();
  //         });
  //       } else {
  //         setState(() {
  //           _start--;
  //         });
  //       }
  //     },
  //   );
  // }

  var userSession;

  @override
  Widget build(BuildContext context) {
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
                    print(pin.runtimeType);
                    validate = pin;
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
                    text: "00:$_start",
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
                  onPressed: () async {
                    print(validate);
                    print(validate.runtimeType);
                    print(
                        "++++++++++++++++++++++++++++++++++++++++++++++++++++");
                    print(widget.verificationId);
                    print("===========================");
                    try {
                      await _auth
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: '${widget.verificationId}',
                              smsCode: validate.toString().trim()))
                          .then((value) async {
                        print("inner if");
                        // userSession = await _firestore
                        //     .collection('newusers')
                        //     .doc('${widget.userNumber}')
                        //     .get();
                        // print(userSession);
                        print('session');
                        if ((value.user != null) &&
                            (userSession.data() != null)) {
                          print(value.user);
                          Get.to(() => HomeScreen(),
                              transition: Transition.rightToLeft,
                              curve: Curves.easeInToLinear,
                              duration: Duration(milliseconds: 600));
                          print("+++++++ddddddddddddddd+++++++++");
                        } else {
                          Get.to(
                              () => Register(
                                    userNumber: widget.userNumber,
                                  ),
                              transition: Transition.rightToLeft,
                              curve: Curves.easeInToLinear,
                              duration: Duration(milliseconds: 600));
                          print("+++++++ddddddddddddddd+++++++++");
                        }
                      });
                    } catch (e) {
                      print("$e invalid");
                    }
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

  // _verifyPhone() async {
  //   PhoneCodeSent codeSent = (String verificationId, [int? resendToken]) {
  //     verificationIdFinal = verificationId;
  //   };
  //   await _auth.verifyPhoneNumber(
  //       phoneNumber: '${widget.phoneNumber}',
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         print("Verification  Before Completed");
  //         await FirebaseAuth.instance
  //             .signInWithCredential(credential)
  //             .then((value) async {
  //           if (value.user != null) {
  //             print("user lOgged in");
  //           }
  //         });
  //         print("Verification After  Completed");
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print('${e.message}Verification error');
  //       },
  //       codeSent: codeSent,
  //       codeAutoRetrievalTimeout: (String verificationID) {
  //         setState(() {
  //           verificationIdFinal = verificationID;
  //         });
  //         print("Verification Code send to an phone");
  //       },
  //       timeout: Duration(seconds: 120));
  // }
}
