import 'dart:async';
import 'package:astrology_app/controller/otp_controller.dart';
import 'package:astrology_app/screens/HomeScreen.dart';
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
  String? phoneNumber;
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
                            child: textField()),
                        SizedBox(
                          height: 20.0,
                        ),
                        otpField(),
                        RichText(
                            text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Send OTP again in ",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            TextSpan(
                              text: '00:$start',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.pinkAccent),
                            ),
                            TextSpan(
                              text: " sec ",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
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
                              ),
                            ),
                            child: Text('Next'),
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

  Widget textField() {
    return TextFormField(
      controller: phoneNumberController,
      style: TextStyle(color: Colors.black, fontSize: 17),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Enter your phone Number",
        hintStyle: TextStyle(color: Colors.black, fontSize: 17),
        contentPadding: const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
        suffixIcon: InkWell(
          onTap: wait
              ? () async {
                  number =
                      '${countryCode.toString()} ${phoneNumberController.text}';
                  user_id(number!);
                  await authClass.verifyPhoneNumber("${number}", setData);
                }
              : () async {
                  startTimer();
                  setState(() {
                    start = 60;
                    wait = true;
                    buttonName = "Resend";
                  });
                  number =
                      '${countryCode.toString()} ${phoneNumberController.text}';
                  // userNumberToAUth(number!);
                  user_id(number!);
                  await authClass.verifyPhoneNumber("${number}", setData);

                  isClick = true;
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Text(
              wait ? 'Resend' : 'Send',
              style: TextStyle(
                color: wait ? Colors.blue : Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
        backgroundColor: Color(0xff1d1d1d),
        borderColor: Colors.white,
      ),
      style: TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceEvenly,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

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

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }
}
