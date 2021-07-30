import 'package:astrology_app/screens/registerscreen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  List<String> getCountryCodes = [
    'India (+91)',
    'Demo (+638)',
    'Demo (+423)',
    'Demo (+95)',
    'Demo (+683)',
  ];


  String? fullname;
  String? email;
  String? query;
  String? phoneNumber;
  bool validation = false;
  String countryCode = 'India (+91)';
  // var getCountryCodes;

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
          border:  InputBorder.none,
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

  getDropdown() {
    List<DropdownMenuItem<String>> dropList = [];
    for (var getCountryCode in getCountryCodes) {
      var newList = DropdownMenuItem(
        child: Text(getCountryCode),
        value: getCountryCode,
      );
      dropList.add(newList);
    }
    return dropList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            // image:  DecorationImage(
            //     image:  AssetImage("images/background_image.png"),
            //     fit: BoxFit.cover,
            //     alignment: Alignment.center
            // ),
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
                            )
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child:  const Text(
                            'OTP',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Ubuntu',
                              fontSize: 15,
                              color: Colors.white,
                            ),),
                        ),
                        Container(
                          child: const Text(
                            'Please enter the OTP sent to your mobile number',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Ubuntu',
                              fontSize: 12,
                              color: Colors.white,
                            ),),
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
                        topRight: Radius.circular(50),
                        // topRight: Radius.circular(30),
                      ),
                    ),
                    // width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.grey,
                            height: 50,
                            width: 50,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.grey,
                            height: 50,
                            width: 50,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.grey,
                            height: 50,
                            width: 50,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.grey,
                            height: 50,
                            width: 50,
                          ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 40),
                          child: Text("Didn't receive an OTP"),
                        ),
                        TextButton(onPressed: () {}, child: Text('Resend OTP')),
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.only(top: 25, left: 20, right: 20, ),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => Register(), transition: Transition.rightToLeft,
                                  curve: Curves.easeInToLinear,
                                  duration: Duration(milliseconds: 600));
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              elevation: 2,
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              textStyle: const TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 15,
                              ),
                            ),
                            child: const Text('Log In'),),
                        ),
                      ],
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}