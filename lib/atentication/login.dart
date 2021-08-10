import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/atentication/country_code.dart';
import 'package:astrology_app/atentication/otp_controller.dart';
import 'package:astrology_app/atentication/otp_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:velocity_x/velocity_x.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _phoneNumber = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final verifyId = ''.obs;
  OTPController _otpController = Get.find<OTPController>();
  ForumContreller _forumContreller = Get.find<ForumContreller>();

  List<String> codes = [];

  countryCodeGet() {
    for (var item in CountryCode) {
      codes.add(item['dial_code'].toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countryCodeGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: KeyboardDismisser(
          child: Container(
            color: Vx.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/login 1.png',
                  width: MediaQuery.of(context).size.width / 1.3,
                ),
                SizedBox(
                  height: 20,
                ),
                "Enter your Phone Number"
                    .text
                    .size(22)
                    .blue400
                    .make()
                    .box
                    .p4
                    .alignCenter
                    .make(),
                "we will send you the 6 digit verification code"
                    .text
                    .gray400
                    .make()
                    .box
                    .alignCenter
                    .make(),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => Text(_otpController.countryCode.value))
                        .box
                        .p16
                        .gray200
                        .border(color: Vx.blue400)
                        .rounded
                        .leftRounded(value: 8)
                        .make()
                        .onTap(() {
                      VxBottomSheet.bottomSheetOptions(context,
                          option: codes,
                          defaultData: _otpController.countryCode.value,
                          backgroundColor: Vx.white,
                          roundedFromTop: true,
                          enableDrag: true,
                          isSafeAreaFromBottom: true, onSelect: (index, value) {
                        print(value);

                        _otpController.countryCode.value = value;
                      });
                    }),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: VxTextField(
                              controller: _phoneNumber,
                              borderType: VxTextFieldBorderType.none,
                              hint: 'Phone Number',
                              borderRadius: 5,
                              keyboardType: TextInputType.number,
                              contentPaddingLeft: 10,
                            ))
                        .box
                        .px3
                        .border(color: Vx.blue400)
                        .rightRounded(value: 8)
                        .make(),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                "Request OTP"
                    .text
                    .white
                    .size(18)
                    .bold
                    .make()
                    .box
                    .p16
                    .blue400
                    .width(
                      MediaQuery.of(context).size.width / 1.1,
                    )
                    .alignCenter
                    .roundedSM
                    .make()
                    .px12()
                    .onInkTap(() {
                  _otpController.setUserPhoneNumber(
                      '${_otpController.countryCode.value} ${_phoneNumber.text}');
                  print(
                      '.........................${_forumContreller.userSession.value} ........................');
                  _otpController.verifyPhoneNumber(context);
                  // Get.to(OTP());
                }).p12(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
