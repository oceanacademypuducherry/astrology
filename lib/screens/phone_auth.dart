import 'dart:async';

import 'package:astrology_app/controller/otp_controller.dart';
import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:astrology_app/screens/registerscreen.dart';
import 'package:astrology_app/widgets/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/style.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otp_text_field/otp_text_field.dart';

class PhoneAuth extends StatefulWidget {
  String? verificationId;
  String? userNumber;

  PhoneAuth({this.verificationId, this.userNumber});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _PhoneAuthState extends State<PhoneAuth> {
  final otp_controller = Get.find<OtpController>();
  int start = 120;
  bool wait = false;
  String buttonName = "Send";
  String verificationIdFinal = "";
  String smsCode = "";
  TextEditingController phoneController = TextEditingController();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  var userSession;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // startTimer();
    countdown();
    print('++++++++++++++++++++++++++++++');
    print('${widget.verificationId}jjjjjjjjjjjjjjjjjjjjjjjjjjj');
  }

  Future<void> countdown() async {
    int totalTime = 160;
    while (totalTime >= 0) {
      await Future.delayed(Duration(milliseconds: 1000));
      otp_controller.setTiming(totalTime);

      if (totalTime == 0) {
        break;
      }
      --totalTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthClass authClass = AuthClass();
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
              Text('${widget.userNumber}'),
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
              otpField(),
              Obx(
                () => RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Send OTP again in ",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    TextSpan(
                      text: otp_controller.timing.value.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
                    ),
                    TextSpan(
                      text: " sec ",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                )),
              ),
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
                    // otp_controller.timing.value == 0
                    //     ? () async {
                    //         print('Resend');
                    //         await authClass.verifyPhoneNumber(
                    //             "${widget.userNumber}", setData);
                    //       }
                    //     : () {
                    //         print('Next');
                    //         authClass.signInwithPhoneNumber(
                    //           smsCode,
                    //           verificationIdFinal,
                    //         );
                    // print(validate);
                    // print(validate.runtimeType);
                    // print(
                    //     "++++++++++++++++++++++++++++++++++++++++++++++++++++");

                    // print("===========================");
                    print(widget.verificationId);
                    try {
                      await _auth
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: '${widget.verificationId}',
                              smsCode: smsCode))
                          .then((value) async {
                        print("inner if");
                        userSession = await _firestore
                            .collection('newusers')
                            .doc('${widget.userNumber}')
                            .get();
                        print(userSession);
                        print('session');
                        if ((value.user != null)) {
                          print(value.user);
                          Get.to(() => HomeScreen(),
                              transition: Transition.rightToLeft,
                              curve: Curves.easeInToLinear,
                              duration: Duration(milliseconds: 600));
                          print("+++++++ddddddddddddddd+++++++++");
                        }

                        try {
                          await _auth
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId:
                                          '${widget.verificationId}',
                                      smsCode: smsCode))
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
                            }
                            // else {
                            //   Get.to(
                            //           () => Register(
                            //         userNumber: widget.userNumber,
                            //       ),
                            //       transition: Transition.rightToLeft,
                            //       curve: Curves.easeInToLinear,
                            //       duration: Duration(milliseconds: 600));
                            //   print("+++++++ddddddddddddddd+++++++++");
                            // }
                          });
                        } catch (e) {
                          print("$e invalid");
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
                  child: Obx(() => Text(
                      otp_controller.timing.value == 0 ? 'Resend' : 'Next')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width,
      fieldWidth: 30,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Color(0xff1d1d1d),
        borderColor: Colors.white,
      ),
      style: TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    // startTimer();
  }
}
