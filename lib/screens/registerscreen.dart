import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:astrology_app/screens/loginscreen.dart';
import 'package:astrology_app/services/storage_service.dart';
import 'package:astrology_app/widgets/BottomNavigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:typed_data';

class Register extends StatefulWidget {
  String? userNumber;
  Register({this.userNumber});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  ForumContreller _forumContreller = Get.find<ForumContreller>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UploadTask? task;
  File? file;
  String? profilePictureLink;
  String? jadhagamLink;
  String? fullname;
  String? email;
  String? query;
  String? phoneNumber;
  bool validation = false;

  String? getId;
  void user_id() async {
    print("---------------------------");

    await for (var snapshot in _firestore
        .collection('newusers')

        ///todo LogIn.registerNumber
        .where("PhoneNumber", isEqualTo: widget.userNumber)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        getId = message.id;
        print('${getId} testingggggggggggggggggggggggggggggggggggg');
      }
    }

    print("---------------------------");
  }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNumberController.text = '${widget.userNumber.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userNumber);
    // final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background_image.png"),
                fit: BoxFit.cover,
                alignment: Alignment.center),
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
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                // color: Colors.amberAccent,
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue[900],
                                  maxRadius: 50,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 10,
                                            spreadRadius: 0,
                                            offset: Offset(
                                              5.0,
                                              5.0,
                                            ),
                                          ),
                                        ]),
                                    child: CircleAvatar(
                                      maxRadius: 47,
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          NetworkImage("${profilePictureLink}"),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 100,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: selectJadhagamFile,
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        elevation: 2,
                                        primary: Colors.blue,
                                        onPrimary: Colors.white,
                                        textStyle: const TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 12,
                                        ),
                                      ),
                                      child: const Text('Upload Jadhagam'),
                                    ),
                                    ElevatedButton(
                                      onPressed: selectProfileFile,
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        elevation: 2,
                                        primary: Colors.blue,
                                        onPrimary: Colors.white,
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Ubuntu',
                                        ),
                                      ),
                                      child: const Text('Upload Profile'),
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
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                width: 150,
                                height: 60,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Full name',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 15,
                                          color: Colors.blue,
                                        ),
                                      ),
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
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
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
                                width: 150,
                                height: 60,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Mobile',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 15,
                                          color: Colors.blue,
                                        ),
                                      ),
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
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 25),
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
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                color: Colors.white,
                                height: 60,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Email',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 15,
                                          color: Colors.blue,
                                        ),
                                      ),
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
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.only(
                            top: 25,
                            left: 20,
                            right: 20,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              print(widget.userNumber);
                              _firestore.collection("newusers").add({
                                "name": nameController.text,
                                "email": emailController.text,
                                "jadhagam": jadhagamLink,
                                'profile': profilePictureLink,
                                'PhoneNumber': widget.userNumber
                              });
                              Get.to(() => BottomNavigation(),
                                  transition: Transition.rightToLeft,
                                  curve: Curves.easeInToLinear,
                                  duration: Duration(milliseconds: 600));
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
                            child: const Text('Register'),
                          ),
                        ),
                        Container(
                          // color: Colors.blue,
                          alignment: Alignment.center,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an Account? ',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 13,
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Get.to(() => Login(),
                                        transition: Transition.rightToLeft,
                                        curve: Curves.easeInToLinear,
                                        duration: Duration(milliseconds: 600));
                                  },
                                  child: Text('Sign In',
                                      style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          color: Colors.blue,
                                          fontSize: 15))),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future selectJadhagamFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
    setState(() {
      uploadJadhagam();
    });
  }

  Future uploadJadhagam() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'jadhagam/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {
      print('profile picture uploaded');
    });
    final urlDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      jadhagamLink = urlDownload;
    });

    print('Download-Link: $urlDownload');
  }

  Future selectProfileFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
    setState(() {
      uploadProfile();
    });
  }

  Future uploadProfile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'profile/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {
      print('profile picture uploaded');

      ///Todo snakbar upload
    });
    final urlDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      profilePictureLink = urlDownload;
    });

    print('Download-Link: $urlDownload');
  }
}
