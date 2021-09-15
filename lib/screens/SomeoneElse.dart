// ignore_for_file: file_names

import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/payment%20info/payment_successfuly.dart';
import 'package:astrology_app/screens/AppointmentScreen.dart';
import 'package:astrology_app/services/storage_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class SomeoneElseScreen extends StatefulWidget {
  String appointmentFor;
  String purpose;
  String ruppess;
  DateTime time;
  SomeoneElseScreen(
      {required this.appointmentFor,
      required this.purpose,
      required this.ruppess,
      required this.time});
  @override
  State<SomeoneElseScreen> createState() => _SomeoneElseScreenState();
}

class _SomeoneElseScreenState extends State<SomeoneElseScreen> {
  late Razorpay _razorpay;
  FocusNode messageFocusNode1 = FocusNode();
  late FlutterLocalNotificationsPlugin localNotification;
  FocusNode messageFocusNode2 = FocusNode();
  FocusNode messageFocusNode3 = FocusNode();
  FocusNode messageFocusNode4 = FocusNode();
  ForumContreller _forumContreller = Get.find<ForumContreller>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final birthPlaceController = TextEditingController();
  var textDate;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UploadTask? task;
  File? file;
  String? profilePictureLink;
  String? jadhagamLink;
  String? fullname;
  String? email;
  String? birthPlace;
  String? query;
  String? phoneNumber;
  bool validation = false;
  var username;
  String? monthFormat;
  String? dayTime;
  int? dayFormat;
  var message;
  int? hourFormat;
  int? minuteFormat;
  int? yearFormat;
  var newHour;
  var newMinute;
  var validationEmail;

  Widget _buildEmail() {
    return TextFormField(
      focusNode: messageFocusNode1,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Ubuntu',
        fontSize: 14,
        color: Colors.black54,
      ),
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
      // ignore: deprecated_member_use
      autovalidate: validation,
      validator: (value) {
        validationEmail = value;
        return EmailValidator.validate(value!)
            ? null
            : "please enter a valid email";
      },
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

  smsData(String number, String message) async {
    print(
        '$number 7777777777777777777777777777777777777777777777777777777777777777');
    final response = await http.get(
      Uri.parse(
          'https://sms.nettyfish.com/vendorsms/pushsms.aspx?apikey=6b980394-3890-4102-a739-c43c8548801f&clientId=a0b0e595-2cfb-4dc6-bba1-641ad1af1c1c&msisdn=${number}&sid=AKSPDY&msg=${message}&fl=0&gwid=2'),
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
    } else {
      print(response.statusCode);
      throw Exception('Failed *********************');
    }
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "channelName", "you booked",
        importance: Importance.max);

    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails);
    await localNotification.show(
        0,
        'Hi ${_forumContreller.sessionUserInfo.value['name']}',
        'You have booked the meeting at ${widget.time.day.toString()} ${monthFormat} ${widget.time.year.toString()}@${hour}:${minute} ${dayTime}',
        generalNotificationDetails);
  }

  Future _scheduleHourNotification() async {
    print(Get.arguments.second);
    print(Get.arguments.year);
    print('${monthForSchedule}mmmmmpommm');
    print('${dayForSchedule}dayyyy');
    print('${hourForSchedule}jhhhhhhhhhhhh');
    print(Get.arguments.minute);
    print(Get.arguments.second);

    var androidDetails = new AndroidNotificationDetails(
        "channelId", "channelName", "you booked",
        importance: Importance.max);

    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails);
    var scheduledTime = DateTime.now().add(Duration(minutes: (diff * -1) - 60));
    await localNotification.schedule(
        0,
        'Hi ${_forumContreller.sessionUserInfo.value['name']}',
        'You have booked the meeting at today @${hour}:${minute} ${dayTime}',
        scheduledTime,
        generalNotificationDetails);
  }

  Future _scheduleDayNotification() async {
    print(Get.arguments.year.toString().runtimeType);
    print(Get.arguments.year);
    print('${monthForSchedule}mmmmmpommm');
    print('${dayForSchedule}dayyyy');
    print('${hourForSchedule}jhhhhhhhhhhhh');
    print(Get.arguments.minute);
    print(Get.arguments.second);

    var androidDetails = new AndroidNotificationDetails(
        "channelId", "channelName", "you booked",
        importance: Importance.max);

    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails);
    var scheduledTime = DateTime.parse(
        '${widget.time.year.toString()}-${monthForSchedule.toString()}-${dayForSchedule.toString()} 08:00:00');
    await localNotification.schedule(
        0,
        'Hi ${_forumContreller.sessionUserInfo.value['name']}',
        'You have booked the meeting at ${widget.time.day.toString()} ${monthFormat} ${widget.time.year.toString()}@${hour}:${minute} ${dayTime}',
        scheduledTime,
        generalNotificationDetails);
  }

  Future _scheduleMinutesNotification() async {
    print(widget.time.year.toString().runtimeType);
    print(widget.time.year);
    print('${monthForSchedule}mmmmmpommm');
    print('${dayForSchedule}dayyyy');
    print('${hourForSchedule}jhhhhhhhhhhhh');
    print(widget.time.minute);
    print(widget.time.second);

    var androidDetails = new AndroidNotificationDetails(
        "channelId", "channelName", "you booked",
        importance: Importance.max);

    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails);
    var scheduledTime = DateTime.now().add(Duration(minutes: (diff * -1) - 2));
    await localNotification.schedule(
        0,
        'Hi ${_forumContreller.sessionUserInfo.value['name']}',
        'You have booked the meeting at today @${hour}:${minute} ${dayTime}',
        scheduledTime,
        generalNotificationDetails);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var alteredPhone = _forumContreller.userSession.value;
    smsNumber = (alteredPhone.substring(1, 3) + alteredPhone.substring(4, 14));
    getTime();
    username = _forumContreller.sessionUserInfo.value['name'];
    _razorpay = Razorpay();
    phoneNumberController.text = _forumContreller.userSession.value;
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    var androidInitialize =
        new AndroidInitializationSettings("@mipmap/ic_launcher_foreground");
    var initialzationSetting =
        new InitializationSettings(android: androidInitialize);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initialzationSetting,
        onSelectNotification: notificationSelected);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  var smsNumber;

  var diff;

  ///RAZORPAY START
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    date = DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
        _time.hour, _time.minute);
    _firestore.collection("booking").add({
      'time': widget.time,
      'payment': widget.ruppess,
      "userName": nameController.text,
      "email": emailController.text,
      "jadhagam": jadhagamLink,
      'profile': profilePictureLink,
      'phoneNumber': _forumContreller.userSession.value,
      'bookingFor': widget.appointmentFor,
      'purposeFor': widget.purpose,
      "birthPlace": birthPlace,
      "birthTime": date,
      'adminZoomLink': '${_forumContreller.startUrl.value}',
      'userZoomLink': '${_forumContreller.joinUrl.value}',
    });
    message =
        "Hi ${_forumContreller.sessionUserInfo.value['name']} You have booked the meeting at ${widget.time.day.toString()} ${monthFormat} ${widget.time..toString()}@${hour}:${minute} ${dayTime}";
    smsData(smsNumber, message);
    _showNotification();
    _scheduleHourNotification();
    _scheduleDayNotification();
    _scheduleMinutesNotification();

    Get.to(() => PaymentSuccessfully(),
        transition: Transition.rightToLeft,
        curve: Curves.easeInToLinear,
        duration: Duration(milliseconds: 600));
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response.walletName);
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_live_yI4lHyiI5FRJWt',
      'amount': 100,
      'name': 'OceanAcademy',
      'description': 'Booking Appointment',
      'prefill': {
        'contact': '${_forumContreller.userSession.value}',
        'email': '${_forumContreller.sessionUserInfo.value['email']}'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  ///RAZORPAY END

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
    textDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
        _time.hour, _time.minute);
    print('date in button  ${textDate}');
    print(DateFormat.jm().format(textDate));
    print(DateFormat.yMMMd().format(textDate));
  }

  var hour;
  var minute;
  var monthForSchedule;
  var dayForSchedule;
  var hourForSchedule;
  var minuteForSchedule;
  var month = DateFormat('MMMM');

  void getTime() {
    monthForSchedule = widget.time.month;
    dayForSchedule = widget.time.day;
    hourForSchedule = widget.time.hour;
    minuteForSchedule = widget.time.minute;
    DateTime newDate = widget.time;

    if (newDate.hour > 12) {
      hour = newDate.hour - 12;

      dayTime = 'PM';
      minute = newDate.minute;
    } else {
      hour = newDate.hour;
      dayTime = 'AM';
      minute = newDate.minute;
    }
    hour = hour < 10 ? '0$hour' : hour;
    minute = minute < 10 ? '0$minute' : minute;
    monthForSchedule =
        monthForSchedule < 10 ? '0$monthForSchedule' : monthForSchedule;
    dayForSchedule =
        dayForSchedule < 10 ? '0$dayForSchedule' : monthForSchedule;
    hourForSchedule =
        hourForSchedule < 10 ? '0${hourForSchedule - 1}' : hourForSchedule - 1;
    hourForSchedule =
        minuteForSchedule < 10 ? '0${minuteForSchedule}' : hourForSchedule - 1;
    monthFormat = month.format(newDate);
    print(monthFormat);
    diff = DateTime.now().difference(newDate).inMinutes;
    print('${diff * -1} hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
    print('${(diff * -1) - 2} hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
  }

  @override
  Widget build(BuildContext context) {
    ///mediaQuery width
    var m = MediaQuery.of(context).size.width / 6;
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
                // TextButton(
                //   child: Text('chhhjjkkkk'),
                //   onPressed: () {
                //
                //   },
                // ),
                Container(
                  alignment: Alignment.center,
                  height: m,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 100),
                        child: Text(
                          "Upload Their Details",
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ],
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
                              horizontal: 25, vertical: 25),
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
                                    width: 100,
                                    // color: Colors.amberAccent,
                                    alignment: Alignment.center,
                                    child: CachedNetworkImage(
                                      imageUrl: profilePictureLink == null
                                          ? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
                                          : '${profilePictureLink.toString()}',
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        height: 150.0,
                                        child: Icon(Icons.error),
                                      ),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        height: 150.0,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
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
                                    // CircleAvatar(
                                    //   backgroundColor: Colors.blue[900],
                                    //   maxRadius: 55,
                                    //   child: Container(
                                    //     decoration: const BoxDecoration(
                                    //         borderRadius: BorderRadius.all(
                                    //             Radius.circular(40)),
                                    //         boxShadow: [
                                    //           BoxShadow(
                                    //             color: Colors.black26,
                                    //             blurRadius: 5,
                                    //             spreadRadius: 0,
                                    //             offset: Offset(
                                    //               3.0,
                                    //               4.0,
                                    //             ),
                                    //           ),
                                    //         ]),
                                    //     child: CircleAvatar(
                                    //       maxRadius: 48,
                                    //       backgroundColor: Colors.white,
                                    //       backgroundImage: profilePictureLink ==
                                    //               null
                                    //           ? NetworkImage(
                                    //               'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png')
                                    //           : NetworkImage(
                                    //               "${profilePictureLink.toString()}"),
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      selectProfileFile(context);
                                    },
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
                                    height: 100,
                                    width: 100,
                                    child: CachedNetworkImage(
                                      imageUrl: jadhagamLink == null
                                          ? 'https://cdn.dribbble.com/users/376964/screenshots/2456984/information.png?compress=1&resize=800x600'
                                          : '${jadhagamLink}',
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        height: 150.0,
                                        child: Icon(Icons.error),
                                      ),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        height: 150.0,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
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
                                  ),
                                  SizedBox(height: 13),
                                  ElevatedButton(
                                    onPressed: () {
                                      selectJadhagamFile(context);
                                    },
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
                                      // color: Colors.grey.shade100,
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
                        Divider(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                color: Colors.grey,
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
                            onPressed: () {
                              if (nameController.text.isNotEmpty &&
                                  emailController.text.isNotEmpty &&
                                  textDate != null &&
                                  EmailValidator.validate(
                                      emailController.text) &&
                                  birthPlaceController.text.isNotEmpty) {
                                openCheckout();
                                print(validationEmail);
                              } else {
                                Get.snackbar(
                                  "Hello! ${username}",
                                  "Please provide their documents",
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

                              print('///////////////////$date');

                              ///route
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 2,
                              primary: Color(0xff045de9),
                              onPrimary: Colors.white,
                              textStyle: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 15,
                              ),
                            ),
                            child: Text('Proceed To Pay'),
                          ),
                        ),
                        SizedBox(height: 50),
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
    dynamic loadingJadhagam = VxToast.showLoading(context,
        msg: "Loading", bgColor: Colors.transparent);

    final fileName = basename(file!.path);
    final destination = 'jadhagam/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {
      print('profile picture uploaded');
    });
    final urlDownload = await snapshot.ref.getDownloadURL();
    Future.delayed(0.100.seconds, loadingJadhagam);
    setState(() {
      jadhagamLink = urlDownload;
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
    dynamic close =
        context.showLoading(msg: "Uploading", bgColor: Colors.transparent);

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
    Future.delayed(0.100.seconds, close);
    setState(() {
      profilePictureLink = urlDownload;
    });

    print('Download-Link: $urlDownload');
  }

  Future notificationSelected(String? payload) async {
    Get.to(
      () => AppointmentScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.easeInToLinear,
      duration: Duration(milliseconds: 600),
    );
  }
}
