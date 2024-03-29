// ignore_for_file: file_names
import 'package:velocity_x/velocity_x.dart';
import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/SupportPage/SupportPage.dart';
import 'package:astrology_app/atentication/login.dart';
import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:astrology_app/services/storage_service.dart';
import 'package:astrology_app/widgets/BottomNavigation.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';
import 'package:velocity_x/src/flutter/gesture.dart';
import 'package:velocity_x/velocity_x.dart';

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
  dynamic close;
  dynamic loadingJadhagam;
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

  String? monthFormat;
  String? dateMonth;
  String? dayTime;
  int? dayFormat;
  int? hourFormat;
  int? minuteFormat;
  int? yearFormat;
  var newHour;
  var newMinute;

  List bookIds = [];

  void bookingid() async {
    await for (var snapshot in _firestore
        .collection('booking')
        .where("phoneNumber",
            isEqualTo: _forumContreller.sessionUserInfo.value['phoneNumber'])
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        //print(message.documentID);
        String id = message.id;
        bookIds.add(id);
      }
      print('hgjkggfhjhjkjhgggggggggggggggggggggggggggggg');
      print(bookIds);
    }
  }

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

  ///format date variable
  var date;

  ///select date picker function

  _selectDate(BuildContext context) async {
    TimeOfDay _time = TimeOfDay(hour: newHour, minute: newMinute);
    DateTime selectedDate = DateTime.parse(
        '${yearFormat.toString()}-${dateMonth}-${dayFormat.toString()} ${newHour.toString()}:${newMinute.toString()}');
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );
    print('$picked uuuuuuuuuuuuuuuuuuuuuuuuuuuuu');
    print('$selectedDate iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print('selectedDate////////////////// ${selectedDate}');
      });
      onTimeChanged(newTime) {
        setState(() {
          _time = newTime;
        });
        print('_time////////////////// ${_time}');
      }

      await Navigator.of(context).push(
        showPicker(
          context: context,
          value: _time,
          onChange: onTimeChanged,
        ),
      );
      date = DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
          _time.hour, _time.minute);

      ///update only date and time
      _firestore
          .collection("newusers")
          .doc(Get.find<ForumContreller>().userDocumentId.toString())
          .update({
        "birthTime": date,
      });
    }
  }

  ///select time onPress

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
                      collapseMode: CollapseMode.pin,
                      centerTitle: true,
                      background: Image.asset(
                        'images/profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Column(
                          children: [
                            // TextButton(
                            //     onPressed: () async {
                            //       SharedPreferences pref =
                            //           await SharedPreferences.getInstance();
                            //
                            //       pref.clear();
                            //
                            //       Get.to(
                            //         () => Login(),
                            //         transition: Transition.rightToLeft,
                            //         curve: Curves.easeInToLinear,
                            //         duration: Duration(milliseconds: 600),
                            //       );
                            //       print('logout');
                            //     },
                            //     child: ),
                            StreamBuilder<QuerySnapshot>(
                              stream:
                                  _firestore.collection('newusers').snapshots(),
                              // ignore: missing_return
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return LinearProgressIndicator(
                                    color: Colors.blue[900],
                                  );
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

                                      getProfilePicture = message['profile'];
                                      getJadhagam = message['jadhagam'];
                                      getName = nameController!.text;
                                      getEmail = emailController!.text;
                                      getMobileNumber =
                                          phoneNumberController!.text;
                                      date = message['birthTime'];

                                      var month = DateFormat('MMMM');
                                      var monthDate = DateFormat('MM');
                                      var year = DateFormat('yyyy');
                                      var day = DateFormat('d');
                                      var hour = DateFormat('hh');
                                      var minute = DateFormat('mm');
                                      var daytime = DateFormat('a');
                                      dateMonth =
                                          monthDate.format(date.toDate());

                                      monthFormat = month.format(date.toDate());
                                      yearFormat =
                                          int.parse(year.format(date.toDate()));
                                      dayFormat =
                                          int.parse(day.format(date.toDate()));
                                      hourFormat =
                                          int.parse(hour.format(date.toDate()));
                                      minuteFormat = int.parse(
                                          minute.format(date.toDate()));
                                      dayTime = daytime.format(date.toDate());

                                      newHour = hourFormat! < 10
                                          ? '0$hourFormat'
                                          : hourFormat;
                                      newMinute = minuteFormat! < 10
                                          ? '0$minuteFormat'
                                          : minuteFormat;
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
                                                    child: CachedNetworkImage(
                                                      imageUrl: _forumContreller
                                                                      .sessionUserInfo
                                                                      .value[
                                                                  'profile'] ==
                                                              null
                                                          ? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
                                                          : '${_forumContreller.sessionUserInfo.value['profile'].toString()}',
                                                      placeholder:
                                                          (context, url) =>
                                                              Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Container(
                                                        height: 150.0,
                                                        child:
                                                            Icon(Icons.error),
                                                      ),
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        height: 150.0,
                                                        decoration:
                                                            BoxDecoration(
                                                                image: DecorationImage(
                                                                    image:
                                                                        imageProvider,
                                                                    fit: BoxFit
                                                                        .cover),
                                                                border:
                                                                    Border.all(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .blue
                                                                      .shade900,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
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
                                                  ),
                                                  SizedBox(height: 13),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      selectProfileFile(
                                                          context);
                                                    },
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
                                                        'Upload Profile'),
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
                                                    child: CachedNetworkImage(
                                                      imageUrl: _forumContreller
                                                                      .sessionUserInfo
                                                                      .value[
                                                                  'jadhagam'] ==
                                                              null
                                                          ? '${getJadhagam}'
                                                          : '${_forumContreller.sessionUserInfo.value['jadhagam']}',
                                                      placeholder:
                                                          (context, url) =>
                                                              Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Container(
                                                        height: 150.0,
                                                        child:
                                                            Icon(Icons.error),
                                                      ),
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        height: 150.0,
                                                        decoration:
                                                            BoxDecoration(
                                                                image: DecorationImage(
                                                                    image:
                                                                        imageProvider,
                                                                    fit: BoxFit
                                                                        .cover),
                                                                border:
                                                                    Border.all(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .blue
                                                                      .shade900,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
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
                                                  ),
                                                  SizedBox(height: 13),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      selectJadhagamFile(
                                                          context);
                                                    },
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
                                                        'Upload Jadhagam'),
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
                                                        text: const TextSpan(
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
                                                                text: "*",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Ubuntu',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .redAccent,
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
                                        const Divider(
                                          color: Colors.black26,
                                          thickness: 0.2,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 33, vertical: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: RichText(
                                                  text: const TextSpan(
                                                    text: 'Phone Number ',
                                                    style: TextStyle(
                                                      fontFamily: 'Ubuntu',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              _buildphonenumber(),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: Colors.black26,
                                          thickness: 0.2,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 33, vertical: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: const Text(
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
                                        const Divider(
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
                                                        text: const TextSpan(
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
                                                                text: "*",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Ubuntu',
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .redAccent,
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
                                        const Divider(
                                          color: Colors.black38,
                                          thickness: 0.2,
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
                                          },
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            padding: EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 15),
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: RichText(
                                                        text: const TextSpan(
                                                            text: 'DOB ',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text: "*",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Ubuntu',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .redAccent,
                                                                ),
                                                              )
                                                            ]),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        '${monthFormat} ${dayFormat} ,'
                                                        ' ${yearFormat} at ${newHour}:${newMinute} ${dayTime}',
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
                                                IconButton(
                                                  icon: Icon(
                                                    Icons
                                                        .calendar_today_outlined,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed: () async {
                                                    if (messageFocusNode1.hasFocus ||
                                                        messageFocusNode2
                                                            .hasFocus ||
                                                        messageFocusNode3
                                                            .hasFocus ||
                                                        messageFocusNode4
                                                            .hasFocus) {
                                                      messageFocusNode1
                                                          .unfocus();
                                                      messageFocusNode2
                                                          .unfocus();
                                                      messageFocusNode3
                                                          .unfocus();
                                                      messageFocusNode4
                                                          .unfocus();
                                                    }

                                                    await _selectDate(context);
                                                    // await Navigator.of(context)
                                                    //     .push(
                                                    //   showPicker(
                                                    //     context: context,
                                                    //     value: _time,
                                                    //     onChange: onTimeChanged,
                                                    //   ),
                                                    // );
                                                  },
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
                                                  "name": nameController!.text
                                                      .toLowerCase(),
                                                  "birthPlace":
                                                      birthPlaceController!
                                                          .text,
                                                  "jadhagam":
                                                      updatedJadhagam == null
                                                          ? getJadhagam
                                                          : updatedJadhagam,
                                                  'profile':
                                                      updatedProfile == null
                                                          ? getProfilePicture
                                                          : updatedProfile,
                                                  'phoneNumber':
                                                      phoneNumberController!
                                                          .text,
                                                });
                                                for (var i in bookIds) {
                                                  _firestore
                                                      .collection('booking')
                                                      .doc(i)
                                                      .update({
                                                    "userName":
                                                        "${nameController!.text.toLowerCase()}",
                                                    "birthPlace":
                                                        birthPlaceController!
                                                            .text,
                                                    "jadhagam":
                                                        updatedJadhagam == null
                                                            ? getJadhagam
                                                            : updatedJadhagam,
                                                    'profile':
                                                        updatedProfile == null
                                                            ? getProfilePicture
                                                            : updatedProfile,
                                                    'phoneNumber':
                                                        phoneNumberController!
                                                            .text,
                                                  });
                                                }
                                                var update = await _firestore
                                                    .collection("newusers")
                                                    .doc(Get.find<
                                                            ForumContreller>()
                                                        .userDocumentId
                                                        .toString())
                                                    .get();
                                                _forumContreller
                                                    .setUserInfo(update.data());
                                                Get.snackbar(
                                                  "Hello ${_forumContreller.sessionUserInfo['name'].toString().substring(0, 1).toUpperCase()}${_forumContreller.sessionUserInfo['name'].toString().substring(1, _forumContreller.sessionUserInfo['name'].length).toLowerCase()}",
                                                  "Documents are updated",
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
                                              } else {
                                                Get.snackbar(
                                                  "Hello ${_forumContreller.sessionUserInfo['name'].toString().substring(0, 1).toUpperCase()}${_forumContreller.sessionUserInfo['name'].toString().substring(1, _forumContreller.sessionUserInfo['name'].length).toLowerCase()}",
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
                                            child: const Text('Update All'),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.black54,
                                          thickness: 0.2,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.all(10.0),
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                // SharedPreferences pref =
                                                //     await SharedPreferences.getInstance();
                                                //
                                                // pref.clear();
                                                //
                                                // Get.to(
                                                //   () => Login(),
                                                //   transition: Transition.rightToLeft,
                                                //   curve: Curves.easeInToLinear,
                                                //   duration: Duration(milliseconds: 600),
                                                // );
                                                // print('logout');
                                                Get.defaultDialog(
                                                  title:
                                                      "Hi ${_forumContreller.sessionUserInfo.value['name']}",
                                                  titlePadding: EdgeInsets.only(
                                                      top: 40.0),
                                                  content: Container(
                                                    margin:
                                                        EdgeInsets.all(10.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "Are you sure want to logout ?",
                                                        ),
                                                        // SizedBox(
                                                        //   height: 10,
                                                        // ),
                                                        Container(
                                                          // color: Colors.blue,
                                                          // margin:
                                                          //     EdgeInsets.all(
                                                          //         20),
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 20,
                                                                  left: 10.0,
                                                                  right: 10.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () async {
                                                                    SharedPreferences
                                                                        pref =
                                                                        await SharedPreferences
                                                                            .getInstance();

                                                                    pref.clear();

                                                                    Get.offAll(
                                                                      () =>
                                                                          Login(),
                                                                      transition:
                                                                          Transition
                                                                              .rightToLeft,
                                                                      curve: Curves
                                                                          .easeInToLinear,
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              600),
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                      'YES')),
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  child: Text(
                                                                      'NO')),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'LOG OUT',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontFamily: 'Ubuntu',
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.pink[200],
                                                  fixedSize: Size(
                                                      double.infinity, 50))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              'Note : '
                                                  .text
                                                  .blue400
                                                  .bold
                                                  .make(),
                                              HStack([
                                                'For more Information reach us '
                                                    .text
                                                    .blue400
                                                    .make(),
                                                'Click here'
                                                    .text
                                                    .underline
                                                    .blue400
                                                    .make()
                                              ]).onInkTap(() {
                                                Get.to(
                                                  SupportPage(),
                                                  transition:
                                                      Transition.cupertino,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                );
                                              }),
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

  Future selectJadhagamFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
    setState(() {
      uploadJadhagam(context);
    });
  }

  Future uploadJadhagam(BuildContext context) async {
    if (file == null) return;
    loadingJadhagam = VxToast.showLoading(context,
        msg: "Loading", bgColor: Colors.transparent);

    final fileName = basename(file!.path);
    final destination = 'jadhagam/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {
      Get.snackbar(
        "Hello ${_forumContreller.sessionUserInfo.value['name']}!",
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
    _firestore
        .collection('newusers')
        .doc(_forumContreller.userDocumentId.value.toString())
        .update({'jadhagam': urlDownload});
    for (var i in bookIds) {
      _firestore.collection('booking').doc(i).update({'jadhagam': urlDownload});
    }
    var update = await _firestore
        .collection("newusers")
        .doc(Get.find<ForumContreller>().userDocumentId.toString())
        .get();
    _forumContreller.setUserInfo(update.data());
    Future.delayed(0.100.seconds, loadingJadhagam);
    setState(() {
      updatedJadhagam = urlDownload;
    });

    print('Download-Link: $urlDownload');
  }

  Future selectProfileFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
    setState(() {
      uploadProfile(context);
    });
  }

  Future uploadProfile(BuildContext context) async {
    if (file == null) return;
    close = context.showLoading(msg: "Uploading", bgColor: Colors.transparent);
    final fileName = basename(file!.path);
    final destination = 'profile/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {
      print('profile picture uploaded');

      ///Todo snakbar upload
      Get.snackbar(
        "Hello ${_forumContreller.sessionUserInfo.value['name']}!",
        "Profile uploaded successfully",
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
    });
    final urlDownload = await snapshot.ref.getDownloadURL();

    _firestore
        .collection('newusers')
        .doc(_forumContreller.userDocumentId.value.toString())
        .update({'profile': urlDownload});
    var update = await _firestore
        .collection("newusers")
        .doc(Get.find<ForumContreller>().userDocumentId.toString())
        .get();
    _forumContreller.setUserInfo(update.data());
    Future.delayed(0.100.seconds, close);

    for (var i in bookIds) {
      _firestore.collection('booking').doc(i).update({'profile': urlDownload});
    }

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
