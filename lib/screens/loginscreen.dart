import 'dart:async';

import 'package:astrology_app/widgets/countrycode.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:astrology_app/screens/otpscreen.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationIdFinal = "";
  int start = 120;

  String countryCode = '+91';
  List countries = codes;

  String? fullname;
  String? email;
  String? query;
  String? phoneNumber;
  bool validation = false;
  String? number;

  Widget _buildphonenumber() {
    return TextFormField(
      // ignore: deprecated_member_use
      autovalidate: validation,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp(r"^\d+\.?\d{0,2}"),
        ),
        LengthLimitingTextInputFormatter(10),
      ],
      validator: (value) {
        if (value!.isEmpty) {
          return 'phone_number is required';
        } else if (value.length < 10) {
          return 'invalid phone_number';
        }
        return null;
      },
      decoration: const InputDecoration(
          // prefixIcon: Icon(Icons.phone_android_outlined),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
          border: InputBorder.none,
          hintText: 'Enter Your Number',
          hintStyle: TextStyle(fontSize: 12)
          // labelText: 'Number',
          ),
      controller: phoneNumberController,
      onChanged: (value) {
        phoneNumber = value;
      },
    );
  }

  List getCountryCode() {
    List<String> getCountryCode = [];
    for (var country in countries) {
      getCountryCode.add(country['code']);
    }
    return getCountryCode;
  }

  bool wait = false;
  void startTimer() {
    const onsec = Duration(minutes: 2);
    Timer _timer = Timer.periodic(onsec, (_timer) {
      if (start == 0) {
        setState(() {
          _timer.cancel();
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
                              radius: 50,
                              child: Icon(
                                Icons.phonelink_lock,
                                color: Colors.white,
                                size: 40,
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            'Mobile Number',
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
                            'We need to send OTP to authenticate your number',
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
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        // topRight: Radius.circular(30),
                      ),
                    ),
                    // width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                  offset: Offset(
                                    2.0,
                                    2.0,
                                  ),
                                ),
                              ]),
                          width: double.infinity,
                          height: 60,
                          child: CountryCodePicker(
                            favorite: ['+91', '+54', 'US'],
                            textStyle: TextStyle(
                              fontFamily: 'Ubuntu',
                              color: Colors.black54,
                              fontWeight: FontWeight.normal,
                            ),
                            backgroundColor: Colors.transparent,
                            onChanged: (object) {
                              print('object $object');
                              countryCode = object.toString();
                            },
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: getCountryCode()[
                                getCountryCode().indexOf('IN')],
                            // countryFilter: getCountryCode(),
                            showFlagDialog: true,
                            showDropDownButton: true,
                            dialogBackgroundColor: Colors.white,

                            hideSearch: false,
                            dialogSize: Size(double.infinity, double.infinity),
                            onInit: (code) {
                              // countryCode = code.toString();

                              print(
                                  '${countryCode.toString()} countryCode.toString()');
                            },

                            dialogTextStyle: TextStyle(color: Colors.white),
                            enabled: true,
                            boxDecoration: BoxDecoration(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                  offset: Offset(
                                    2.0,
                                    2.0,
                                  ),
                                ),
                              ]),
                          width: double.infinity,
                          height: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50,
                                // color: Colors.pinkAccent,
                                child: _buildphonenumber(),
                              ),
                            ],
                          ),
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
                              await _getOtp();
                              startTimer();
                              number =
                                  '${countryCode.toString()} ${phoneNumberController.text}';
                              print(verificationIdFinal);
                              Get.to(
                                  () => OTP(
                                        verificationId: verificationIdFinal,
                                      ),
                                  arguments: verificationIdFinal,
                                  transition: Transition.rightToLeft,
                                  curve: Curves.easeInToLinear,
                                  duration: Duration(milliseconds: 600));
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 2,
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              textStyle: const TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 15,
                              ),
                            ),
                            child: const Text('Next'),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getOtp() async {
    PhoneCodeSent codeSent = (String verificationId, [int? resendToken]) {
      verificationIdFinal = verificationId;
    };
    await _auth.verifyPhoneNumber(
        phoneNumber: '${number}',
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
}
