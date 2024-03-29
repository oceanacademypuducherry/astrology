import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/atentication/login.dart';

import 'package:astrology_app/services/storage_service.dart';
import 'package:astrology_app/widgets/BottomNavigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  String? userNumber;
  Register({this.userNumber});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FocusNode messageFocusNode1 = FocusNode();
  FocusNode messageFocusNode2 = FocusNode();
  FocusNode messageFocusNode3 = FocusNode();
  FocusNode messageFocusNode4 = FocusNode();
  ForumContreller _forumContreller = Get.find<ForumContreller>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final birthPlaceController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UploadTask? task;
  var textDate;
  File? file;
  String? profilePictureLink;
  String? jadhagamLink;
  String? fullname;
  String? email;
  String? birthPlace;
  String? query;
  String? phoneNumber;
  bool validation = false;
  String? getId;
  var oldJadhagamLink =
      'https://firebasestorage.googleapis.com/v0/b/astrology-7cec1.appspot.com/o/profile%2Fjadhagam.webp?alt=media&token=4a51f0f5-6ea2-4b02-8089-1aba928cc736';
  var oldProfileLink =
      'https://firebasestorage.googleapis.com/v0/b/astrology-7cec1.appspot.com/o/profile%2Fprofile.png?alt=media&token=8045a2e6-f3ee-40b1-bf32-a571d917aff6';

  void user_id() async {
    print("---------------------------");

    await for (var snapshot in _firestore
        .collection('newusers')

        ///todo LogIn.registerNumber
        .where("phoneNumber", isEqualTo: widget.userNumber)
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
      focusNode: messageFocusNode1,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Ubuntu',
        fontSize: 14,
        color: Colors.black54,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r"\s")),
        // FilteringTextInputFormatter.deny(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
      ],
      // ignore: deprecated_member_use
      // autovalidate: validation,
      validator: (value) =>
          EmailValidator.validate(value!) ? null : "please enter a valid email",
      decoration: const InputDecoration(
        // prefixIcon: Icon(Icons.email_outlined),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: InputBorder.none,
        hintText: 'Enter Your Email',
        hintStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontFamily: 'Ubuntu',
          fontSize: 14,
          color: Colors.grey,
        ),
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
      focusNode: messageFocusNode2,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Ubuntu',
        fontSize: 14,
        color: Colors.black54,
      ),
      // ignore: deprecated_member_use
      autovalidate: validation,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
        LengthLimitingTextInputFormatter(30),
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
        contentPadding: EdgeInsets.zero,
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: InputBorder.none,
        hintText: 'Enter Your Name',
        hintStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontFamily: 'Ubuntu',
          fontSize: 14,
          color: Colors.grey,
        ),
        // labelText: 'Name',
      ),
      controller: nameController,
      onChanged: (value) {
        fullname = value;
      },
    );
  }

  Widget _buildBirthPlace() {
    return TextFormField(
      focusNode: messageFocusNode3,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Ubuntu',
        fontSize: 14,
        color: Colors.black54,
      ),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
        LengthLimitingTextInputFormatter(40),
      ],
      // ignore: deprecated_member_use
      autovalidate: validation,
      validator: (value) =>
          EmailValidator.validate(value!) ? null : "please enter a valid email",
      decoration: const InputDecoration(
        // prefixIcon: Icon(Icons.email_outlined),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: InputBorder.none,
        hintText: 'Enter Your Birth Place',
        hintStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontFamily: 'Ubuntu',
          fontSize: 14,
          color: Colors.grey,
        ),
        // labelText: 'Email',
      ),
      controller: birthPlaceController,
      onChanged: (value) {
        birthPlace = value;
      },
    );
  }

  Widget _buildphonenumber() {
    return TextFormField(
      focusNode: messageFocusNode4,
      readOnly: true,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Ubuntu',
        fontSize: 14,
        color: Colors.black54,
      ),
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
        hintStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontFamily: 'Ubuntu',
          fontSize: 14,
          color: Colors.grey,
        ),
        // labelText: 'Number',
      ),
      controller: phoneNumberController,
      onChanged: (value) {
        phoneNumber = value;
      },
    );
  }

  var date;
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  DateTime selectedDate = DateTime.now();

  ///select date picker function
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
  }

  ///select time onPress
  onTimeChanged(newTime) {
    setState(() {
      _time = newTime;
    });
    print('_time////////////////// ${_time}');
    textDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
        _time.hour, _time.minute);
    print('date in button  ${textDate}');
    print(DateFormat.jm().format(textDate));
    print(DateFormat.yMMMd().format(textDate));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNumberController.text = '${widget.userNumber.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    String monthFormat = DateFormat('MMMM').format(selectedDate);

    ///mediaQuery width
    var m = MediaQuery.of(context).size.width / 6;
    print(widget.userNumber);
    // final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return SafeArea(
      child: Scaffold(
        body: KeyboardDismisser(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xff045de9),
            ),
            width: double.infinity,
            child: ListView(
              // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: m,
                  width: MediaQuery.of(context).size.width,
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
                Container(
                    width: double.infinity,
                    // height: MediaQuery.of(context).size.height - m,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    // width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///circle avatar
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          maxRadius: 48,
                                          backgroundColor: Colors.white,
                                          backgroundImage: profilePictureLink ==
                                                  null
                                              ? NetworkImage(
                                                  '${oldProfileLink}')
                                              : NetworkImage(
                                                  "${profilePictureLink.toString()}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: selectProfileFile,
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
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
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 95,
                                    width: 100,
                                    // color: Colors.amberAccent,
                                    alignment: Alignment.center,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: jadhagamLink == null
                                                ? NetworkImage(
                                                    '${oldJadhagamLink}')
                                                : NetworkImage(
                                                    "${jadhagamLink.toString()}"),
                                          ),
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.blue.shade900,
                                          ),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
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
                                    ),
                                  ),
                                  SizedBox(height: 13),
                                  ElevatedButton(
                                    onPressed: selectJadhagamFile,
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      elevation: 2,
                                      onPrimary: Colors.white,
                                      textStyle: const TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: 12,
                                      ),
                                    ),
                                    child: const Text('Upload Jadhagam'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        ///Textfield
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
                                height: 70,
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
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
                                height: 70,
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
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
                                height: 70,
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
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
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 25),
                          decoration: const BoxDecoration(
                              color: Colors.red,
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
                                height: 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Birth Place',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      // color: Colors.pinkAccent,
                                      child: _buildBirthPlace(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///DOB
                        GestureDetector(
                          onTap: () async {
                            if (messageFocusNode1.hasFocus ||
                                messageFocusNode2.hasFocus ||
                                messageFocusNode3.hasFocus ||
                                messageFocusNode4.hasFocus) {
                              messageFocusNode1.unfocus();
                              messageFocusNode2.unfocus();
                              messageFocusNode3.unfocus();
                              messageFocusNode4.unfocus();
                            }

                            await _selectDate(context);
                            Navigator.of(context).push(
                              showPicker(
                                context: context,
                                value: _time,
                                onChange: onTimeChanged,
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            decoration: BoxDecoration(
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 15),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'DOB',
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: textDate == null
                                          ? Text(
                                              'Pick the date',
                                              style: TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black54,
                                              ),
                                            )
                                          : Text(
                                              "${DateFormat.yMMMd().format(textDate)} @ ${DateFormat.jm().format(textDate)}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Ubuntu',
                                                fontSize: 14,
                                                color: Colors.black54,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (messageFocusNode1.hasFocus ||
                                        messageFocusNode2.hasFocus ||
                                        messageFocusNode3.hasFocus ||
                                        messageFocusNode4.hasFocus) {
                                      messageFocusNode1.unfocus();
                                      messageFocusNode2.unfocus();
                                      messageFocusNode3.unfocus();
                                      messageFocusNode4.unfocus();
                                    }

                                    await _selectDate(context);
                                    Navigator.of(context).push(
                                      showPicker(
                                        context: context,
                                        value: _time,
                                        onChange: onTimeChanged,
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.blue,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        ///Register button
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.only(
                            top: 25,
                            left: 20,
                            right: 20,
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              date = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  _time.hour,
                                  _time.minute);
                              print(widget.userNumber);

                              ///for unfocus everykeyboard
                              if (messageFocusNode1.hasFocus ||
                                  messageFocusNode2.hasFocus ||
                                  messageFocusNode3.hasFocus ||
                                  messageFocusNode4.hasFocus) {
                                messageFocusNode1.unfocus();
                                messageFocusNode2.unfocus();
                                messageFocusNode3.unfocus();
                                messageFocusNode4.unfocus();
                              }

                              ///firebase

                              if (nameController.text.isNotEmpty &&
                                  emailController.text.isNotEmpty &&
                                  widget.userNumber!.isNotEmpty &&
                                  birthPlace != null &&
                                  textDate != null &&
                                  EmailValidator.validate(
                                      emailController.text)) {
                                print(
                                    "${selectedDate} ///////////////////////////////////////////////////////////////date///");
                                print(
                                    "${DateTime.now()} ///////////////////////////////////////////////////////////////date");
                                _firestore.collection("newusers").add({
                                  "name": nameController.text,
                                  "email": emailController.text,
                                  "jadhagam": jadhagamLink == null
                                      ? oldJadhagamLink
                                      : jadhagamLink,
                                  'profile': profilePictureLink == null
                                      ? oldProfileLink
                                      : profilePictureLink,
                                  'phoneNumber': widget.userNumber,

                                  ///todo widget.userNumber
                                  "birthPlace": birthPlace,
                                  "birthTime": date,
                                  "subscribe": false,
                                  "books": "",
                                });
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString(
                                    'user', widget.userNumber.toString());

                                Get.offAll(() => BottomNavigation(),
                                    transition: Transition.rightToLeft,
                                    curve: Curves.easeInToLinear,
                                    duration: Duration(milliseconds: 600));
                              } else {
                                Get.snackbar(
                                  "Hello User !",
                                  "Please check your documents",
                                  icon: Icon(Icons.person, color: Colors.white),
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.blue[500],
                                  borderRadius: 10,
                                  margin: EdgeInsets.all(12),
                                  colorText: Colors.white,
                                  duration: Duration(seconds: 4),
                                  isDismissible: true,
                                  dismissDirection:
                                      SnackDismissDirection.HORIZONTAL,
                                  forwardAnimationCurve: Curves.easeOutBack,
                                );
                              }

                              print('///////////////////$date');

                              ///route
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 2,
                              primary: Color(0xff045de9),
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
                                    Get.off(() => Login(),
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
                        ),
                      ],
                    )),
              ].reversed.toList(),
            ),
          ),
        ),
      ),
    );
  }

  ///upload functions
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
      Get.snackbar(
        "Hello User!",
        "Jadhagam uploaded successfully",
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue[500],
        borderRadius: 10,
        margin: EdgeInsets.all(12),
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutBack,
      );
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
      Get.snackbar(
        "Hello user!",
        "profile uploaded successfully",
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue[500],
        borderRadius: 10,
        margin: EdgeInsets.all(12),
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutBack,
      );

      ///Todo snakbar upload
    });
    final urlDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      profilePictureLink = urlDownload;
    });

    print('Download-Link: $urlDownload');
  }
}
