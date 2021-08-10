import 'package:astrology_app/Forum/forumController.dart';

import 'package:astrology_app/atentication/otp_controller.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:astrology_app/widgets/countrycode.dart';
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

  String countryCode = '+91';
  List countries = codes;
  List getCountryCode() {
    List<String> getCountryCode = [];
    for (var country in countries) {
      getCountryCode.add(country['code']);
    }
    return getCountryCode;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: KeyboardDismisser(
          child: Container(
            color: Vx.white,
            child: ListView(
              children: [
                SizedBox(
                  height: 100,
                ),
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
                    CountryCodePicker(
                      hideMainText: false,
                      showFlag: false,
                      padding: EdgeInsets.all(0),
                      favorite: ['+91', '+54', 'US'],
                      textStyle: TextStyle(
                        fontFamily: 'Ubuntu',
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                      ),
                      backgroundColor: Colors.transparent,
                      onChanged: (object) {
                        print('object $object');
                        _otpController.getCountryCode.value = object.toString();
                      },
                      initialSelection:
                          getCountryCode()[getCountryCode().indexOf('IN')],
                      showFlagDialog: true,
                      showDropDownButton: true,
                      dialogBackgroundColor: Colors.white,
                      hideSearch: false,
                      dialogSize: Size(double.infinity, double.infinity),
                      dialogTextStyle: TextStyle(
                        fontFamily: 'Ubuntu',
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                      ),
                      enabled: true,
                      boxDecoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    )
                        .box
                        .border(color: Vx.blue400)
                        .leftRounded(value: 8)
                        .make(),
                    // Obx(() => Text(_otpController.countryCode.value))
                    //     .box
                    //     .p16
                    //     .gray200
                    //     .border(color: Vx.blue400)
                    //     .rounded
                    //     .leftRounded(value: 8)
                    //     .make()
                    //     .onTap(() {
                    //   VxBottomSheet.bottomSheetOptions(context,
                    //       option: codes,
                    //       defaultData: _otpController.countryCode.value,
                    //       backgroundColor: Vx.white,
                    //       roundedFromTop: true,
                    //       enableDrag: true,
                    //       isSafeAreaFromBottom: true, onSelect: (index, value) {
                    //     print(value);
                    //
                    //     _otpController.countryCode.value = value;
                    //   });
                    // }),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: VxTextField(
                              fillColor: Vx.white,
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
                      MediaQuery.of(context).size.width,
                    )
                    .alignCenter
                    .roundedSM
                    .make()
                    .px2()
                    .onInkTap(() {
                  _otpController.setUserPhoneNumber(
                      '${_otpController.getCountryCode.value} ${_phoneNumber.text}');
                  print(
                      '.........................${_otpController.userPhoneNumber.value} ........................');
                  _otpController.verifyPhoneNumber(
                      _otpController.userPhoneNumber.value.toString(), context);
                }).p12(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
