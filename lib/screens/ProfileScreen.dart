import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:astrology_app/services/storage_service.dart';
import 'package:astrology_app/widgets/BottomNavigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:path/path.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _ProfileScreenState extends State<ProfileScreen> {
  FocusNode messageFocusNode1 = FocusNode();
  FocusNode messageFocusNode2 = FocusNode();
  FocusNode messageFocusNode3 = FocusNode();
  FocusNode messageFocusNode4 = FocusNode();
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  UploadTask? task;
  File? file;
  String? email;
  String? updatedProfile;
  String? updatedJadhagam;

  String? phoneNumber;

  String? fullname;

  bool validation = false;

  TextEditingController? emailController = TextEditingController();
  TextEditingController? nameController = TextEditingController();
  TextEditingController? phoneNumberController = TextEditingController();
  TextEditingController? birthPlaceController = TextEditingController();
  var getName;
  var getMobileNumber;
  var getEmail;
  String? birthPlace;
  Timestamp? birthTime;

  var getProfilePicture;
  var getJadhagam;

  ///widgets

  Widget _buildEmail() {
    return TextFormField(
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Ubuntu',
        fontSize: 14,
        color: Colors.black54,
      ),
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
      readOnly: true,
      controller: emailController,
      onChanged: (value) {
        email = value;
      },
    );
  }

  Widget _buildName() {
    return TextFormField(
      focusNode: messageFocusNode1,
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
          hintStyle: TextStyle(fontSize: 12)
          // labelText: 'Number',
          ),
      controller: phoneNumberController,
      readOnly: true,
      onChanged: (value) {
        phoneNumber = value;
      },
    );
  }

  Widget _buildBirthPlace() {
    return TextFormField(
      focusNode: messageFocusNode2,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Ubuntu',
        fontSize: 14,
        color: Colors.black54,
      ),
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
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

  ///format date variable
  var date;

  ///select date picker function
  DateTime selectedDate = DateTime.now();
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
        print('selectedDate////////////////// ${selectedDate}');
      });
  }

  ///select time onPress
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  onTimeChanged(newTime) {
    setState(() {
      _time = newTime;
    });
    print('_time////////////////// ${_time}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: KeyboardDismisser(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: false,
                    expandedHeight: 150,
                    // automaticallyImplyLeading: true,
                    toolbarHeight: 50,
                    // stretch: true,
                    pinned: false,
                    collapsedHeight: 50,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Image.asset(
                        'images/profile1.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Column(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                              stream:
                                  _firestore.collection('newusers').snapshots(),
                              // ignore: missing_return
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text("Loading...");
                                } else {
                                  final messages = snapshot.data!;
                                  for (var message in messages.docs) {
                                    print(
                                        "${_forumContreller.userDocumentId}  _forumContreller.userDocumentId///////");
                                    print("${message.id}  message.id///////");
                                    if (_forumContreller.userDocumentId ==
                                        message.id) {
                                      nameController!.text = message['name'];
                                      phoneNumberController!.text =
                                          message['phoneNumber'];
                                      emailController!.text = message['email'];
                                      birthPlaceController!.text =
                                          message['birthPlace'];
                                      date = message['birthTime'];

                                      getProfilePicture = message['profile'];
                                      getJadhagam = message['jadhagam'];
                                      getName = nameController!.text;
                                      getEmail = emailController!.text;
                                      getMobileNumber =
                                          phoneNumberController!.text;
                                    }
                                  }
                                  return Container(
                                    // color: Colors.grey[200],
                                    margin: EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 25),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 120,
                                                    width: 120,
                                                    // color: Colors.amberAccent,
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  updatedProfile ==
                                                                          null
                                                                      ? '${getProfilePicture}'
                                                                      : '${updatedProfile}'),
                                                              fit:
                                                                  BoxFit.cover),
                                                          border: Border.all(
                                                            width: 2,
                                                            color: Colors
                                                                .blue.shade900,
                                                          ),
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black26,
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
                                                    onPressed:
                                                        selectProfileFile,
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      elevation: 2,
                                                      onPrimary: Colors.white,
                                                      textStyle:
                                                          const TextStyle(
                                                        fontFamily: 'Ubuntu',
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    child: const Text(
                                                        'Update Profile'),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 120,
                                                    width: 120,
                                                    // color: Colors.amberAccent,
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  updatedJadhagam ==
                                                                          null
                                                                      ? '${getJadhagam}'
                                                                      : '${updatedJadhagam}'),
                                                              fit:
                                                                  BoxFit.cover),
                                                          border: Border.all(
                                                            width: 2,
                                                            color: Colors
                                                                .blue.shade900,
                                                          ),
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black26,
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
                                                    onPressed:
                                                        selectJadhagamFile,
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      elevation: 2,
                                                      onPrimary: Colors.white,
                                                      textStyle:
                                                          const TextStyle(
                                                        fontFamily: 'Ubuntu',
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    child: const Text(
                                                        'Update Jadhagam'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 25),
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
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
                                                padding: const EdgeInsets.only(
                                                    left: 15, top: 5),
                                                color: Colors.white,
                                                height: 70,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: RichText(
                                                        text: TextSpan(
                                                            text: 'Full Name ',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    "(Editable)",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Ubuntu',
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .lightBlue,
                                                                ),
                                                              )
                                                            ]),
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
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.black26,
                                          thickness: 0.2,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 33, vertical: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  'Mobile Phone',
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 15,
                                                    fontFamily: 'Ubuntu',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              _buildphonenumber(),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.black26,
                                          thickness: 0.2,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 33, vertical: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  'Email',
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 15,
                                                    fontFamily: 'Ubuntu',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              _buildEmail(),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.black26,
                                          thickness: 0.2,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 25),
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
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
                                                padding: const EdgeInsets.only(
                                                    left: 15, top: 5),
                                                color: Colors.white,
                                                height: 70,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: RichText(
                                                        text: TextSpan(
                                                            text:
                                                                'Birth Place ',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    "(Editable)",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Ubuntu',
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .lightBlue,
                                                                ),
                                                              )
                                                            ]),
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
                                        Divider(
                                          color: Colors.black38,
                                          thickness: 0.2,
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          padding: EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 15),
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Date and Time',
                                                  style: TextStyle(
                                                    fontFamily: 'Ubuntu',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  '${date}',
                                                  style: TextStyle(
                                                    fontFamily: 'Ubuntu',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ElevatedButton(
                                            onPressed: () async {
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
                                              await Navigator.of(context).push(
                                                showPicker(
                                                  context: context,
                                                  value: _time,
                                                  onChange: onTimeChanged,
                                                ),
                                              );

                                              date = DateTime(
                                                  selectedDate.year,
                                                  selectedDate.month,
                                                  selectedDate.day,
                                                  _time.hour,
                                                  _time.minute);
                                              print('date in button  ${date}');

                                              ///update only date and time
                                              _firestore
                                                  .collection("newusers")
                                                  .doc(Get.find<
                                                          ForumContreller>()
                                                      .userDocumentId
                                                      .toString())
                                                  .update({
                                                "birthTime": date,
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize:
                                                  Size(double.infinity, 50),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              elevation: 2,
                                              primary: Color(0xff045de9),
                                              onPrimary: Colors.white,
                                              textStyle: const TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            child: Text(
                                              "Update Birth Day and Birth Time",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                            onPressed: () {
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
                                              if (nameController!
                                                      .text.isNotEmpty &&
                                                  birthPlaceController!
                                                      .text.isNotEmpty) {
                                                _firestore
                                                    .collection("newusers")
                                                    .doc(Get.find<
                                                            ForumContreller>()
                                                        .userDocumentId
                                                        .toString())
                                                    .update({
                                                  "name": nameController!.text,
                                                  "birthPlace":
                                                      birthPlaceController!
                                                          .text,
                                                  "jadhagam": updatedJadhagam,
                                                  'profile': updatedProfile,
                                                  'phoneNumber':
                                                      phoneNumberController!
                                                          .text,
                                                });

                                                Get.snackbar(
                                                  "Hello user!",
                                                  "Docuemnts are Updated",
                                                  icon: Icon(Icons.person,
                                                      color: Colors.white),
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                  backgroundColor:
                                                      Colors.blue[500],
                                                  borderRadius: 10,
                                                  margin: EdgeInsets.all(12),
                                                  colorText: Colors.white,
                                                  duration:
                                                      Duration(seconds: 4),
                                                  isDismissible: true,
                                                  dismissDirection:
                                                      SnackDismissDirection
                                                          .HORIZONTAL,
                                                  forwardAnimationCurve:
                                                      Curves.easeOutBack,
                                                );
                                                print('Updated Successfully');
                                              } else {
                                                Get.snackbar(
                                                  "Hello user!",
                                                  "Please provide your documents",
                                                  icon: Icon(Icons.person,
                                                      color: Colors.white),
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                  backgroundColor:
                                                      Colors.blue[500],
                                                  borderRadius: 10,
                                                  margin: EdgeInsets.all(12),
                                                  colorText: Colors.white,
                                                  duration:
                                                      Duration(seconds: 4),
                                                  isDismissible: true,
                                                  dismissDirection:
                                                      SnackDismissDirection
                                                          .HORIZONTAL,
                                                  forwardAnimationCurve:
                                                      Curves.easeOutBack,
                                                );
                                              }

                                              ///route
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              elevation: 2,
                                              primary: Color(0xff045de9),
                                              onPrimary: Colors.white,
                                              textStyle: const TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            child: const Text('Update'),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.black54,
                                          thickness: 0.2,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                alignment: Alignment.centerLeft,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  'History of Appointment',
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 15,
                                                    fontFamily: 'Ubuntu',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 20),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              offset: Offset(
                                                                  0.1, 0.2),
                                                            )
                                                          ],
                                                          color:
                                                              Colors.grey[100],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        height: 40,
                                                        width: 100,
                                                        child: Text(
                                                          'Wed 1 Jul',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 20),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              offset: Offset(
                                                                  0.1, 0.2),
                                                            )
                                                          ],
                                                          color:
                                                              Colors.grey[100],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        height: 40,
                                                        width: 100,
                                                        child: Text(
                                                          'Wed 1 Jul',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 20),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              offset: Offset(
                                                                  0.1, 0.2),
                                                            )
                                                          ],
                                                          color:
                                                              Colors.grey[100],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        height: 40,
                                                        width: 100,
                                                        child: Text(
                                                          'Wed 1 Jul',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 20),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              offset: Offset(
                                                                  0.1, 0.2),
                                                            )
                                                          ],
                                                          color:
                                                              Colors.grey[100],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        height: 40,
                                                        width: 100,
                                                        child: Text(
                                                          'Wed 1 Jul',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
            ),
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
      updatedJadhagam = urlDownload;
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
      updatedProfile = urlDownload;
      // profilePicture = updatedProfile;
    });

    // setState(() {
    //
    // });

    print('Download-Link: $urlDownload');
  }
}
