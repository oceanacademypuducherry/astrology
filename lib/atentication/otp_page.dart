import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/atentication/login.dart';
import 'package:astrology_app/atentication/otp_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:velocity_x/velocity_x.dart';

class OTP extends StatefulWidget {
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  OTPController _otpController = Get.find<OTPController>();
  ForumContreller _forumContreller = Get.find<ForumContreller>();

  final smsCode = ''.obs;
  final faildOTP = true.obs;

  final countDown = 60.obs;

  int timeCount = 0;

  FocusNode messageFocusNode1 = FocusNode();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageFocusNode1.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: KeyboardDismisser(
          child: SingleChildScrollView(
            reverse: true,
            child: Container(
              color: Vx.white,
              width: context.screenWidth,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/otp 2.png',
                      width: MediaQuery.of(context).size.width / 1.2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () =>
                          "Enter your OTP with in ${_otpController.otpCount.value.toString()} Second"
                              .text
                              .size(20)
                              .blue400
                              .make()
                              .box
                              .p4
                              .alignCenter
                              .make(),
                    ),
                    "OTP sent this number ${_otpController.userPhoneNumber.value}"
                        .text
                        .gray400
                        .make()
                        .box
                        .alignCenter
                        .make(),
                    SizedBox(
                      height: 30,
                    ),
                    // VxPinView(
                    //   focusNode: messageFocusNode1,
                    //   keyboardType: TextInputType.number,
                    //   color: Vx.blue400,
                    //   size: 40,
                    //   obscureText: false,
                    //   onChanged: (value) async {
                    //     smsCode.value = value;
                    //
                    //     if (smsCode.value.length == 6) {
                    //       dynamic close =
                    //           context.showLoading(msg: "Loading");
                    //       Future.delayed(1.seconds, close);
                    //       await _otpController.signWithPhoneNumber(
                    //           smsCode.value, context);
                    //     }
                    //   },
                    // ),
                    Container(
                      width: context.screenWidth,
                      child: OTPTextField(
                        length: 6,
                        fieldWidth: context.screenWidth / 7,
                        outlineBorderRadius: 5,
                        style: TextStyle(fontSize: 17),
                        textFieldAlignment: MainAxisAlignment.center,
                        fieldStyle: FieldStyle.box,
                        onCompleted: (value) async {
                          smsCode.value = value;

                          if (smsCode.value.length == 6) {
                            FocusScope.of(context).unfocus();
                            dynamic close = context.showLoading(msg: "Loading");
                            Future.delayed(1.seconds, close);
                            await _otpController.signWithPhoneNumber(
                                smsCode.value, context);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(() => Text(
                              _otpController.resend.value ? "Resend" : "Submit",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ))
                        .box
                        .p16
                        .blue400
                        .alignCenter
                        .roundedSM
                        .make()
                        .px12()
                        .onInkTap(() async {
                      if (_otpController.resend.value) {
                        VxDialog.showAlert(context,
                            title: "Login Failed",
                            content: "Request Timeout Try Again",
                            onPressed: () {
                          messageFocusNode1.unfocus();
                          Get.off(Login());
                          _otpController.resend.value = false;
                        });
                      } else {
                        await _otpController.signWithPhoneNumber(
                            smsCode.value, context);
                      }
                    }).p12(),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
