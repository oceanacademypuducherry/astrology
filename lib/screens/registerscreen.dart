import 'package:astrology_app/screens/loginscreen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
          border: InputBorder.none,
          hintText: 'Enter Your Email',
          hintStyle: TextStyle(fontSize: 12)
        // labelText: 'Email',
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
          hintText: 'Enter Your Name',
          hintStyle: TextStyle(fontSize: 12)
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image:  DecorationImage(
                image:  AssetImage("images/background_image.png"),
                fit: BoxFit.cover,
                alignment: Alignment.center
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                color: Colors.black26,
                height: 60,
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
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    // width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
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
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                        offset:  Offset(
                                          2.0,
                                          2.0,
                                        ),
                                      ),]
                                ),
                                padding: const EdgeInsets.only(left: 15, top: 5),
                                width: 150,
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Full name',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 15,
                                          color: Colors.blue,
                                        ),),
                                    ),
                                    Container(
                                      height: 30,
                                      // color: Colors.pinkAccent,
                                      child: _buildName(),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 15, top: 5),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                        offset:  Offset(
                                          2.0,
                                          2.0,
                                        ),
                                      ),]
                                ),
                                width: 150,
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Mobile', style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: 15,
                                        color: Colors.blue,
                                      ),),
                                    ),
                                    Container(
                                      height: 30,
                                      // color: Colors.pinkAccent,
                                      child: _buildphonenumber(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                  offset:  Offset(
                                    2.0,
                                    2.0,
                                  ),
                                ),]
                          ),

                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 15, top: 5),
                                color: Colors.white,
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Email', style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: 15,
                                        color: Colors.blue,
                                      ),),
                                    ),
                                    Container(
                                      height: 30,
                                      // color: Colors.pinkAccent,
                                      child: _buildEmail(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                        offset:  Offset(
                                          2.0,
                                          2.0,
                                        ),
                                      ),]
                                ),
                                padding: const EdgeInsets.only(left: 15, top: 5),

                                width: 150,
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Password',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 15,
                                          color: Colors.blue,
                                        ),),
                                    ),
                                    Container(
                                      height: 30,
                                      // color: Colors.pinkAccent,
                                      child: _buildName(),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 15, top: 5),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                        offset:  Offset(
                                          2.0,
                                          2.0,
                                        ),
                                      ),]
                                ),
                                width: 150,
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text('Confirm Password',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 15,
                                          color: Colors.blue,
                                        ),),
                                    ),
                                    Container(
                                      height: 30,
                                      // color: Colors.pinkAccent,
                                      child: _buildphonenumber(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.only(top: 25, left: 20, right: 20, ),
                          child: ElevatedButton(
                            onPressed: () {},
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
                            child: const Text('Register'),),
                        ),
                        Container(
                          // color: Colors.blue,
                          alignment: Alignment.center,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an Account? ',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 13,
                                  )),
                              TextButton(onPressed: () {
                                Get.to(() => Login(), transition: Transition.rightToLeft,
                                    curve: Curves.easeInToLinear,
                                    duration: Duration(milliseconds: 600));
                              }, child: Text('Sign In',
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: Colors.blue,
                                      fontSize: 15
                                  ))),
                            ],
                          ),
                        )
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