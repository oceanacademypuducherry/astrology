import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(
      const GetMaterialApp(
        debugShowCheckedModeBanner: false,
    home: Scaffold(
      resizeToAvoidBottomInset : true,
      // extendBodyBehindAppBar: true,
      body: Register(),
    ),
  ));
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();


  String? fullname;
  String? email;
  String? query;
  String? phoneNumber;
  bool validation = false;

  Widget _buildEmail() {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
      // ignore: deprecated_member_use
      autovalidate: validation,
      validator: (value) =>
      EmailValidator.validate(value!) ? null : "please enter a valid email",
      decoration: const InputDecoration(
        // prefixIcon: Icon(Icons.email_outlined),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: OutlineInputBorder(),
        hintText: 'Enter Your Email',
        labelText: 'Email',
      ),
      controller: emailController,
      onChanged: (value) {
        email = value;
      },
    );
  }

  Widget _buildName() {
    return TextFormField(
      // ignore: deprecated_member_use
      autovalidate: validation,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
        LengthLimitingTextInputFormatter(40),
      ],
      // autovalidate: _autoValidate,
      validator: (value) {
        if (value!.isEmpty) {
          return 'name is required';
        } else if (value.length < 3) {
          return 'character should be morethan 2';
        }
        return null;
      },
      decoration: const InputDecoration(
        // prefixIcon: Icon(Icons.drive_file_rename_outline),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: InputBorder.none,
        // hintText: 'Enter Your Name',
        // labelText: 'Name',
      ),
      controller: nameController,
      onChanged: (value) {
        fullname = value;
      },
    );
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
        prefixIcon: Icon(Icons.phone_android_outlined),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: OutlineInputBorder(),
        hintText: 'Enter Your Number',
        labelText: 'Number',
      ),
      controller: phoneNumberController,
      onChanged: (value) {
        phoneNumber = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image:  DecorationImage(
            image:  AssetImage("images/background_image.png"),
            fit: BoxFit.fill,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
              Container(
                color: Colors.black26,
                height: 100,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.white,
                          size: 30,
                        ),
                    ),
                    const Spacer(),
                    const SizedBox(
                      width: 110,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(90),
                    ),
                  ),
                  // width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Container(
                              height: 100,
                              // color: Colors.amberAccent,
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue[900],
                                maxRadius: 50,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                          offset:  Offset(
                                            5.0,
                                            5.0,
                                          ),
                                        ),]
                                  ),
                                  child: const CircleAvatar(
                                    maxRadius: 47,
                                    backgroundColor: Colors.white,
                                   child: Icon(
                                     Icons.person_rounded,
                                     size: 40,
                                   ),

                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        elevation: 2,
                                        primary: Colors.blue,
                                        onPrimary: Colors.white,
                                        textStyle: const TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 12,
                                        ),
                                      ),
                                      child: const Text('Upload Profile'),),
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        elevation: 2,
                                        primary: Colors.blue,
                                        onPrimary: Colors.white,
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Ubuntu',
                                        ),
                                      ),
                                      child: const Text('Upload Jathagam'),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            // color: Colors.amberAccent,
                            width: 300,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text('Full name', style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 15
                                  ),),
                                ),
                                Container(
                                  // color: Colors.pinkAccent,
                                  child: _buildName(),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ),
              ),
          ],
        ),
      ),
    );
  }
}





