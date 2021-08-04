import 'dart:async';
import 'package:astrology_app/controller/otp_controller.dart';
import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:astrology_app/screens/otpscreen.dart';
import 'package:astrology_app/screens/registerscreen.dart';
import 'package:astrology_app/widgets/auth_service.dart';
import 'package:astrology_app/widgets/countrycode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _LoginState extends State<Login> {
  final otp_controller = Get.find<OtpController>();
  AuthClass authClass = AuthClass();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  int start = 60;
  bool wait = false;
  String buttonName = "Send";
  String verificationIdFinal = "";
  String smsCode = "";

  String countryCode = '+91';
  bool isClick = false;
  List countries = codes;

  String? fullname;
  String? email;
  String? query;
  bool validation = false;
  String? number;
  var userSession;
  String? getId;

  void user_id(String user) async {
    print("---------------------------");
    await for (var snapshot in _firestore
        .collection('newusers')
        .where("PhoneNumber", isEqualTo: user)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        getId = message.id;
        print('${getId} testingggggggggggggggggggggggggggggggggggg');
      }
    }

    print("---------------------------");
  }

  Widget _buildphonenumber() {
    return TextFormField(
      controller: phoneNumberController,
      style: TextStyle(
        color: Colors.black.withOpacity(0.6),
        fontSize: 13,
        height: 1.3,
        fontWeight: FontWeight.normal,
        fontFamily: "Ubuntu",
        letterSpacing: 0.6,
      ),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Enter your Number",
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.6),
          fontSize: 13,
          height: 1.3,
          fontWeight: FontWeight.normal,
          fontFamily: "Ubuntu",
          letterSpacing: 0.6,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
        suffixIcon: InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Text(
              wait ? 'RESEND' : 'SEND',
              style: TextStyle(
                color: wait ? Colors.pinkAccent : Colors.black,
                fontSize: 14,
                height: 1.3,
                fontWeight: FontWeight.w400,
                fontFamily: "Ubuntu",
                letterSpacing: 0.6,
              ),
            ),
          ),
          onTap: wait
              ? () async {
                  setState(() {
                    number =
                        '${countryCode.toString()} ${phoneNumberController.text}';
                  });

                  user_id(number!);
                  await authClass.verifyPhoneNumber("${number}", setData);
                }
              : () async {
                  // startTimer();
                  setState(() {
                    start = 60;
                    wait = true;
                    buttonName = "Resend";
                  });
                  number =
                      '${countryCode.toString()} ${phoneNumberController.text}';
                  // userNumberToAUth(number!);
                  user_id(number!);
                  print(getId);
                  await authClass.verifyPhoneNumber("${number}", setData);

                  isClick = true;
                },
        ),
      ),
    );
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width,
      fieldWidth: 35,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Colors.white,
        borderColor: Colors.white,
      ),
      style: TextStyle(
        color: Colors.black.withOpacity(0.7),
        fontSize: 14,
        height: 1,
        fontWeight: FontWeight.w600,
        fontFamily: "Ubuntu",
        letterSpacing: 0.6,
      ),
      textFieldAlignment: MainAxisAlignment.spaceEvenly,
      fieldStyle: FieldStyle.box,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  Widget? BottomSheet(String verificationId) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        width: double.infinity,
        height: 170,
        color: Colors.white,
        child: Column(
          children: [
            otpField(),
            RichText(
                text: TextSpan(
              children: [
                TextSpan(
                  text: "Send OTP again in ",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                TextSpan(
                  text: '00:$start',
                  style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
                ),
                TextSpan(
                  text: " sec ",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            )),
            ElevatedButton(
              onPressed: () {
                print(
                    '$number nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
                signInwithPhoneNumber(
                  verificationIdFinal,
                  smsCode,
                );

                print('=============================================');
                print('${verificationIdFinal}sowthri');
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
              child: Text('Next'),
            ),
          ],
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.7),
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        side: BorderSide(
          width: 0.1,
          color: Colors.black,
        ),
      ),
      enableDrag: true,
    );
  }

  Future<void> signInwithPhoneNumber(
    String verificationId,
    String smsCode,
  ) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      // storeTokenAndData(userCredential);
      print('${verificationId}aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      userSession = await _firestore.collection('newusers').doc(getId).get();
      print(userCredential.credential);
      print('$getId kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
      print(userSession.data());
      if (userSession.data() != null) {
        session();
        Get.to(() => HomeScreen(),
            transition: Transition.rightToLeft,
            curve: Curves.easeInToLinear,
            duration: Duration(milliseconds: 600));
      } else {
        session();
        print(
            '$number aaaaaaaaaaaaaaaaaaattttttttttttttttttttttttssssssssssseeeeeeeee');
        Get.to(
            () => Register(
                  userNumber: number,
                ),
            transition: Transition.rightToLeft,
            curve: Curves.easeInToLinear,
            duration: Duration(milliseconds: 600));
      }
    } catch (e) {
      print('error ${e.toString()}');
    }
  }

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
      print(verificationID);
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

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }

  List getCountryCode() {
    List<String> getCountryCode = [];
    for (var country in countries) {
      getCountryCode.add(country['code']);
    }
    return getCountryCode;
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          print('cancel');
          timer.cancel();
          wait = false;
          buttonName = 'Send';
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', number!);
    // await prefs.setBool('isSession', true);

    print("${number!} ssssssssssssss");
    print('Otp Submited');
  }

  Future<void> userNumberToAUth(String number) async {
    print('geting user number...........................');
    otp_controller.setUserNumber(number);
    print(number);
  }

  @override
  Widget build(BuildContext context) {
    var m = MediaQuery.of(context).size.height / 3;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xff045de9),
          ),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            reverse: true,
            child: Column(
              children: [
                Container(
                  // color: Colors.black26,
                  height: MediaQuery.of(context).size.height / 3,
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
                                  size: 30,
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: const Text(
                              'Mobile Number',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Ubuntu',
                                fontSize: 16,
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
                ), //content1
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  height: MediaQuery.of(context).size.height - m,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 20,
                              ),
                              // padding: const EdgeInsets.only(left: 10, top: 5),
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
                              width: MediaQuery.of(context).size.width - 50,
                              height: 55,
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
                                dialogSize:
                                    Size(double.infinity, double.infinity),
                                onInit: (code) {
                                  // countryCode = code.toString();

                                  print(
                                      '${countryCode.toString()} countryCode.toString()');
                                },

                                dialogTextStyle: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal,
                                ),
                                enabled: true,
                                boxDecoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.only(left: 15),
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
                              width: MediaQuery.of(context).size.width - 50,
                              height: 55,
                              child: _buildphonenumber(),
                            ),
                          ],
                        ),
                      ),
                      otpField(),
                      RichText(
                          text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Send OTP again in ",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14,
                              height: 1.3,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Ubuntu",
                              letterSpacing: 0.6,
                            ),
                          ),
                          TextSpan(
                            text: '00:$start',
                            style: TextStyle(
                              color: Colors.pinkAccent.withOpacity(0.7),
                              fontSize: 14,
                              height: 1.3,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Ubuntu",
                              letterSpacing: 0.6,
                            ),
                          ),
                          TextSpan(
                            text: " sec ",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14,
                              height: 1.3,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Ubuntu",
                              letterSpacing: 0.6,
                            ),
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
                          onPressed: isClick
                              ? () {
                                  signInwithPhoneNumber(
                                    verificationIdFinal,
                                    smsCode,
                                  );

                                  print(
                                      '=============================================');
                                  print('${verificationIdFinal}sowthri');
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            elevation: 2,
                            primary: Colors.blue,
                            onPrimary: Colors.white,
                            textStyle: const TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text('SEND OTP'),
                        ),
                      ),
                    ],
                  ),
                ), //content2
              ],
            ),
          ),
        ),
      ),
    );
  }
}
