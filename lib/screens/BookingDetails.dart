// ignore_for_file: file_names

import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/payment%20info/payment_successfuly.dart';
import 'package:astrology_app/screens/AppointmentScreen.dart';
import 'package:astrology_app/screens/SomeoneElse.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';

enum Appointment { MySelf, others }
enum Purpose { Marriage, Astrology, Other }

class BookingDetails extends StatefulWidget {
  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _BookingDetailsState extends State<BookingDetails> {
  late FlutterLocalNotificationsPlugin localNotification;
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  late Razorpay _razorpay;
  Appointment _appointment = Appointment.MySelf;
  Purpose _purpose = Purpose.Marriage;

  ///variable
  bool validation = false;
  var fullname;

  ///controller
  TextEditingController? nameController = TextEditingController();
  DateTime newDate = Get.arguments;

  List purpose = [
    'Marriage',
    'Financial',
    'Love',
    'Job&Abroad',
    'Studies',
    'Health',
    'Character',
    'Wealth',
    'Personal'
  ];
  List userPurpose = [];
  Map checking = {};

  ///widgets
  Widget _buildOther() {
    return TextFormField(
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Ubuntu',
        fontSize: 15,
        color: Colors.black54,
      ),
      // ignore: deprecated_member_use
      autovalidate: validation,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
        LengthLimitingTextInputFormatter(100),
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
        contentPadding: EdgeInsets.all(11),
        prefixIcon: Icon(Icons.drive_file_rename_outline),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: InputBorder.none,
        hintText: 'Enter Your Reason',
        hintStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontFamily: 'Ubuntu',
          fontSize: 16,
          color: Colors.grey,
        ),
        // labelText: 'Reason',
      ),
      controller: nameController,
      onChanged: (value) {
        fullname = value;
      },
    );
  }

  bool value = false;
  String rupees = "100";
  @override
  void initState() {
    // TODO: implement initState
    print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    print('${_forumContreller.startUrl.value}');
    super.initState();
    var androidInitialize =
        new AndroidInitializationSettings("@mipmap/ic_launcher_foreground");
    var initialzationSetting =
        new InitializationSettings(android: androidInitialize);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initialzationSetting,
        onSelectNotification: notificationSelected);
    getTime();

    _razorpay = Razorpay();
    print(_forumContreller.userSession.value);
    print(_forumContreller.sessionUserInfo.value);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    print('************************************************');
    print(_forumContreller.userSession.value);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "channelName", "you booked",
        importance: Importance.max);

    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails);
    await localNotification.show(0, 'Hi User', 'You have booked the meeting ',
        generalNotificationDetails);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  ///RAZORPAY START
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _firestore.collection('booking').add({
      'time': Get.arguments,
      'phoneNumber': _forumContreller.userSession.value,
      'email': _forumContreller.sessionUserInfo.value['email'],
      'userName': _forumContreller.sessionUserInfo.value['name'],
      'jadhagam': _forumContreller.sessionUserInfo.value['jadhagam'],
      'profile': _forumContreller.sessionUserInfo.value['profile'],
      'payment': rupees,
      'birthTime': _forumContreller.sessionUserInfo.value['birthTime'],
      'birthPlace': _forumContreller.sessionUserInfo.value['birthPlace'],
      'bookingFor': _appointment.toString(),
      'purposeFor': FieldValue.arrayUnion(checking.keys.toList()),
      'adminZoomLink': '${_forumContreller.startUrl.value}',
      'userZoomLink': '${_forumContreller.joinUrl.value}',
    });
    print('uploaded successfully');

    Get.off(() => PaymentSuccessfully(),
        transition: Transition.rightToLeft,
        curve: Curves.easeInToLinear,
        duration: Duration(milliseconds: 600));
    print(
        '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    print(response.paymentId);
    print(response.orderId);
    print(response.signature);
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
    _showNotification();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('*************Error******************');
    print(response.message);
    Fluttertoast.showToast(msg: "ERROR");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('*************WALLETETTETTE******************');
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

  bool hasClicked = false;

  var minute;
  String? monthFormat;
  var hour;
  var dayTime;
  var month = DateFormat('MMMM');
  void getTime() {
    DateTime newDate = Get.arguments;

    if (newDate.hour > 12) {
      hour = newDate.hour - 12;

      dayTime = 'PM';
      minute = newDate.minute;
    } else {
      hour = newDate.hour;
      dayTime = 'AM';
      minute = newDate.minute;
    }
    hour = hour < 9 ? '0$hour' : hour;
    minute = minute < 9 ? '0$minute' : minute;
    monthFormat = month.format(newDate);
    print(monthFormat);
  }

  ///RAZORPAY END
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff045de9),
        centerTitle: true,
        title: Text(
          'Booking Details',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontFamily: 'Ubuntu',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return KeyboardDismisser(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  ///date and time
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Appointment Date and Time',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 40,
                          margin: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0.5,
                                offset: Offset(0.3, 0.3),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            '${hour}:${minute} ${dayTime}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Ubuntu',
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          margin: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0.5,
                                offset: Offset(0.3, 0.3),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${newDate.day.toString()} ${monthFormat} ${newDate.year.toString()}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Ubuntu',
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.2,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Booking Price',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          margin: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0.5,
                                offset: Offset(0.3, 0.3),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                  text: '₹ ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Ubuntu',
                                    fontSize: 19,
                                    color: Colors.black54,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${rupees}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Ubuntu',
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.2,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),

                  ///purpose of appointment
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Purpose of Appointment',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  ///Appointment button
                  Container(
                    // color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runSpacing: 13,
                      spacing: 12,
                      children: [
                        for (var i in purpose)
                          GestureDetector(
                            onTap: () {
                              checking.containsKey(i)
                                  ? checking.remove(i)
                                  : checking.addAll({i: true});

                              setState(() {
                                hasClicked = !hasClicked;
                              });

                              print(checking);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              // height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: checking.containsKey(i)
                                      ? Border.all(
                                          color: Colors.blue.shade700,
                                          width: 3,
                                        )
                                      : Border.all(
                                          color: Colors.grey.shade400,
                                          width: 3,
                                        ),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0.5, 0.5),
                                      color: Colors.grey.shade400,
                                      blurRadius: 3,
                                      // spreadRadius: 0.1,
                                    ),
                                  ]),
                              child: Text(
                                "${i}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Ubuntu',
                                  fontSize: 14,
                                  color: Colors.blue[400],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  ///Condition  value == other means Textfield
                  _purpose == Purpose.Other
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.3, 0.3),
                              ),
                            ],
                          ),
                          child: _buildOther(),
                        )
                      : Container(),
                  Divider(
                    thickness: 0.2,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),

                  ///this appointment is for
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'This Appointment is for',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  ///radio button
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: Appointment.MySelf,
                              groupValue: _appointment,
                              onChanged: (value) {
                                setState(() {
                                  _appointment = Appointment.MySelf;
                                });
                              },
                            ),
                            Text(
                              'For me',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Ubuntu',
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Row(
                          children: [
                            Radio(
                              value: Appointment.others,
                              groupValue: _appointment,
                              onChanged: (value) {
                                setState(() {
                                  _appointment = Appointment.others;
                                });
                              },
                            ),
                            Text(
                              'Someone else',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Ubuntu',
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.2,
                    color: Colors.grey,
                  ),

                  ///continue button
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xff045de9),
                              Colors.blue,
                            ],
                          )),
                      child: ElevatedButton(
                        ///checking For Me or SomeoneElse to Route to next Page
                        onPressed: _appointment == Appointment.MySelf
                            ? () {
                                ///payment page
                                openCheckout();

                                // _firestore.collection('booking').add({
                                //   'time': Get.arguments,
                                //   'purpose of appointment':
                                //       _appointment.toString(),
                                //   'appointment For': _purpose.toString(),
                                // });
                                //
                                // Get.to(() => BottomNavigation(),
                                //     transition: Transition.topLevel,
                                //     // curve: Curves.ease,
                                //     duration: Duration(milliseconds: 600));
                              }
                            : () {
                                ///someone else page
                                Get.to(
                                    () => SomeoneElseScreen(
                                          appointmentFor:
                                              _appointment.toString(),
                                          purpose: _purpose.toString(),
                                          time: newDate,
                                          ruppess: rupees,
                                        ),
                                    transition: Transition.topLevel,
                                    // curve: Curves.ease,
                                    duration: Duration(milliseconds: 600));
                              },
                        child: _appointment == Appointment.MySelf
                            ? Text('Proceed to Payment')
                            : Text('Update Their Document'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          fixedSize: Size(double.infinity, 50),
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 25,
                          ),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Ubuntu',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
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
