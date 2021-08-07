import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/screens/SomeoneElseScreen.dart';
import 'package:astrology_app/widgets/BottomNavigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';

enum Appointment { ForMe, SomeoneElse }
enum Purpose { Marriage, Astrology, Other }

class BookingDetails extends StatefulWidget {
  // DateTime selectedTime;
  // BookingDetails({required this.selectedTime});

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _BookingDetailsState extends State<BookingDetails> {
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  late Razorpay _razorpay;
  Appointment _appointment = Appointment.ForMe;
  Purpose _purpose = Purpose.Marriage;

  ///variable
  bool validation = false;
  var fullname;

  ///controller
  TextEditingController? nameController = TextEditingController();
  DateTime newDate = Get.arguments;

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
    super.initState();
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
      'payment': rupees,
      'birthTime': _forumContreller.sessionUserInfo.value['birthTime'],
      'birthPlace': _forumContreller.sessionUserInfo.value['birthPlace'],
      'bookingFor': _appointment.toString(),
      'purposeFor': _purpose.toString(),
    });
    print('uploaded successfully');

    Get.to(() => BottomNavigation(),
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
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('*************Error******************');
    print(response.message);
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
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
          return Container(
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.2, 0.2),
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.2, 0.2),
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
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 80,
                        height: 40,
                        margin:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.2, 0.2),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Booking Fees',
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.2, 0.2),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '₹${rupees}',
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

                ///radio button
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: const Text(
                    'Marriage',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Ubuntu',
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  leading: Radio(
                    value: Purpose.Marriage,
                    groupValue: _purpose,
                    onChanged: (value) {
                      setState(() {
                        _purpose = Purpose.Marriage;
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: const Text(
                    'Astrology',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Ubuntu',
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  leading: Radio(
                    value: Purpose.Astrology,
                    groupValue: _purpose,
                    onChanged: (value) {
                      setState(() {
                        _purpose = Purpose.Astrology;
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: const Text(
                    'Other',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Ubuntu',
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  leading: Radio(
                    value: Purpose.Other,
                    groupValue: _purpose,
                    onChanged: (value) {
                      setState(() {
                        _purpose = Purpose.Other;
                      });
                    },
                  ),
                ),

                ///Condition  value == other means Textfield
                _purpose == Purpose.Other
                    ? Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: const Text(
                    'For me',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Ubuntu',
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  leading: Radio(
                    value: Appointment.ForMe,
                    groupValue: _appointment,
                    onChanged: (value) {
                      setState(() {
                        _appointment = Appointment.ForMe;
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: const Text(
                    'Someone else',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Ubuntu',
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  leading: Radio(
                    value: Appointment.SomeoneElse,
                    groupValue: _appointment,
                    onChanged: (value) {
                      setState(() {
                        _appointment = Appointment.SomeoneElse;
                      });
                    },
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
                      onPressed: _appointment == Appointment.ForMe
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
                                  () => SomeoneElse(
                                        appointmentFor: _appointment.toString(),
                                        purpose: _purpose.toString(),
                                      ),
                                  transition: Transition.topLevel,
                                  // curve: Curves.ease,
                                  duration: Duration(milliseconds: 600));
                            },
                      child: _appointment == Appointment.ForMe
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
          );
        },
      ),
    );
  }
}
