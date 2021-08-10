import 'package:astrology_app/atentication/otp_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class OTP extends StatefulWidget {
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  OTPController _otpController = Get.find<OTPController>();
  final smsCode = ''.obs;
  final faildOTP = true.obs;

  final countDown = 60.obs;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Vx.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Obx(() => Text(
                //     '"Enter your OTP with in ${_otpController.otpCount.value.toString()} Second')),
                Obx(
                  () =>
                      "Enter your OTP with in ${_otpController.otpCount.value.toString()} Second"
                          .text
                          .size(25)
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
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    VxPinView(
                      keyboardType: TextInputType.number,
                      color: Vx.blue400,
                      size: 50,
                      obscureText: false,
                      onChanged: (value) {
                        smsCode.value = value;
                      },
                    ),
                  ],
                ),
                Obx(() => Text(
                          _otpController.resend.value ? "Resend" : "Submit",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ))
                    .box
                    .p16
                    .blue400
                    .alignCenter
                    .roundedSM
                    .make()
                    .px12()
                    .onInkTap(() async {
                  await _otpController.signWithPhoneNumber(
                      smsCode.value, context);
                }).p12(),
              ]),
        ),
      ),
    );
  }
}
