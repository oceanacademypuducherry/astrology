import 'package:astrology_app/Forum/forumController.dart';
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
  ForumContreller _forumContreller = Get.find<ForumContreller>();
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/otp 1.png',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    VxPinView(
                      keyboardType: TextInputType.number,
                      color: Vx.blue400,
                      size: 40,
                      obscureText: false,
                      onChanged: (value) {
                        smsCode.value = value;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
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
