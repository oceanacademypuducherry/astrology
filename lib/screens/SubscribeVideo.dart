// ignore_for_file: file_names

import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/payment%20info/payment_successfuly.dart';
import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:astrology_app/screens/PaidVedios.dart';
import 'package:astrology_app/widgets/BottomNavigation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscribeVideoScreen extends StatefulWidget {
  const SubscribeVideoScreen({Key? key}) : super(key: key);

  @override
  _SubscribeVideoScreenState createState() => _SubscribeVideoScreenState();
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _SubscribeVideoScreenState extends State<SubscribeVideoScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff045de9),
                  Color(0xff045de9),
                  Colors.blue,
                  Colors.blue,
                  Colors.blue,
                  Colors.blue.shade300,
                  // Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  // width: MediaQuery.of(context).size.width,
                  height: 70,
                  // color: Colors.green,
                  child: IconButton(
                    onPressed: () {
                      Get.offAll(
                        BottomNavigation(),
                      );
                    },
                    icon: const Icon(
                      Icons.cancel,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: const Text(
                    'Access all Premium Videos on Makarajothi',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.3,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Ubuntu',
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    'Get access to our all premium videos, inspirational speaches and much, much more.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.4,
                      height: 1.3,
                      fontFamily: 'Ubuntu',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                Column(
                  children: [
                    SubScribeList(
                      width: MediaQuery.of(context).size.width,
                      plan: "Monthly Subscription",
                      cost: '500',
                      days: "28",
                    ),
                    SubScribeList(
                      width: MediaQuery.of(context).size.width,
                      plan: "Quarterly Subscription",
                      cost: '1500',
                      days: "112",
                    ),
                    SubScribeList(
                      width: MediaQuery.of(context).size.width,
                      plan: "Half-yearly Subscription",
                      cost: '2000',
                      days: "168",
                    ),
                    SubScribeList(
                      width: MediaQuery.of(context).size.width,
                      plan: "Yearly Subscription",
                      cost: '2500',
                      days: "365",
                    ),
                    SubScribeList(
                      width: MediaQuery.of(context).size.width,
                      plan: "Life Time Subscription",
                      cost: '3000',
                      days: "Life Time Acesss",
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: const Text(
                        "Makarajothi Premium is a paid membership, available in certain countries, that gives you an ad-free, "
                        "feature-rich online viewing.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.3,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Ubuntu',
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubScribeList extends StatefulWidget {
  String cost;
  String plan;
  String days;
  double width;

  SubScribeList({
    required this.cost,
    required this.plan,
    required this.days,
    required this.width,
  });

  @override
  _SubScribeListState createState() => _SubScribeListState();
}

class _SubScribeListState extends State<SubScribeList> {
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  late Razorpay _razorpay;
  var smsNumber;

  smsData(String number, String message) async {
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

  void initState() {
    // TODO: implement initState
    super.initState();
    var alteredPhone = _forumContreller.userSession.value;
    smsNumber = (alteredPhone.substring(1, 3) + alteredPhone.substring(4, 14));
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  ///RAZORPAY START
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    if (widget.plan != "Life Time Subscription") {
      _firestore
          .collection('subscribeList')
          .doc(_forumContreller.userSession.value)
          .set({
        'time': DateTime.now().add(Duration(days: int.parse(widget.days))),
        'phoneNumber': _forumContreller.userSession.value,
        'email': _forumContreller.sessionUserInfo.value['email'],
        'userName': _forumContreller.sessionUserInfo.value['name'],
        'profile': _forumContreller.sessionUserInfo.value['profile'],
        'payment': widget.cost,
        'plan': widget.plan
      });
      _firestore
          .collection('newusers')
          .doc(_forumContreller.userDocumentId.value)
          .update({
        'subscribe': true,
      });
      var message =
          "Hi ${_forumContreller.sessionUserInfo.value['name']} you have Subscribe for vedio";
      smsData(smsNumber, message);

      Get.off(() => PaymentSuccessfully(),
          transition: Transition.rightToLeft,
          curve: Curves.easeInToLinear,
          duration: Duration(milliseconds: 600));
      Fluttertoast.showToast(
          msg: "SUCCESS: " + response.paymentId!,
          toastLength: Toast.LENGTH_SHORT);
    } else {
      _firestore
          .collection('subscribeList')
          .doc(_forumContreller.userSession.value)
          .set({
        'time': DateTime.now(),
        'phoneNumber': _forumContreller.userSession.value,
        'email': _forumContreller.sessionUserInfo.value['email'],
        'userName': _forumContreller.sessionUserInfo.value['name'],
        'profile': _forumContreller.sessionUserInfo.value['profile'],
        'payment': widget.cost,
        'plan': widget.plan
      });
      _firestore
          .collection('newusers')
          .doc(_forumContreller.userDocumentId.value)
          .update({
        'subscribe': true,
      });
      var message =
          "Hi ${_forumContreller.sessionUserInfo.value['name']} you have Subscribe for vedio";
      smsData(smsNumber, message);

      Get.off(() => PaymentSuccessfully(),
          transition: Transition.rightToLeft,
          curve: Curves.easeInToLinear,
          duration: Duration(milliseconds: 600));
      Fluttertoast.showToast(
          msg: "SUCCESS: " + response.paymentId!,
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message!,
    //     toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET: " + response.walletName!,
    //     toastLength: Toast.LENGTH_SHORT);
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
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: openCheckout,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        width: MediaQuery.of(context).size.width,
        height: 75,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade500,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0.2, 0.2),
            ),
          ],
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  // color: Colors.blue,
                  width: 200,
                  child: Text(
                    "${widget.plan}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4,
                      height: 1.3,
                      fontFamily: 'Ubuntu',
                      fontSize: 17,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 80,
                  // color: Colors.green,
                  child: RichText(
                    text: TextSpan(
                        text: '₹ ',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.4,
                          height: 1.3,
                          fontFamily: 'Ubuntu',
                          fontSize: 22,
                          color: Colors.blue.shade800,
                        ),
                        children: [
                          TextSpan(
                              text: widget.cost,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.4,
                                height: 1.3,
                                fontFamily: 'Ubuntu',
                                fontSize: 17,
                                color: Colors.blue.shade700,
                              ))
                        ]),
                  ),
                ).marginSymmetric(vertical: 5),
                Container(
                  // color: Colors.blue,
                  alignment: Alignment.center,
                  width: 110,
                  // color: Colors.green,
                  child: widget.days == "Life Time Acesss"
                      ? Text(
                          "${widget.days}",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.4,
                            height: 1.3,
                            fontFamily: 'Ubuntu',
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        )
                      : Text(
                          "${widget.days} Days",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.4,
                            height: 1.3,
                            fontFamily: 'Ubuntu',
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
