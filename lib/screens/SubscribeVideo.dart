import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/payment%20info/payment_successfuly.dart';
import 'package:astrology_app/screens/PaidVedios.dart';
import 'package:astrology_app/widgets/BottomNavigation.dart';
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
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  late Razorpay _razorpay;
  var smsNumber;
  String rupees = " \$50";
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
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _firestore.collection('subscribeList').add({
      'time': DateTime.now(),
      'phoneNumber': _forumContreller.userSession.value,
      'email': _forumContreller.sessionUserInfo.value['email'],
      'userName': _forumContreller.sessionUserInfo.value['name'],
      'profile': _forumContreller.sessionUserInfo.value['profile'],
      'payment': rupees,
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

    Get.to(() => PaymentSuccessfully(),
        transition: Transition.rightToLeft,
        curve: Curves.easeInToLinear,
        duration: Duration(milliseconds: 600));
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message!,
    //     toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
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

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff045de9),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff045de9),
              Colors.blue,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: h / 5,
              child: Text(
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
              height: h / 15,
              child: Text(
                'Get access to our all premium videos, inspirational speeches and much, much more.',
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: h / 2.8,
              child: Image(
                image: AssetImage('images/s.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: h / 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    width: 270,
                    child: ElevatedButton(
                      onPressed: () {
                        openCheckout();
                        // Get.to(() => PaidVedios(),
                        //     // transition: Transition.cupertinoDialog,
                        //     fullscreenDialog: true,
                        //     curve: Curves.easeInToLinear,
                        //     duration: Duration(milliseconds: 600));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Start Your lifetime access video',
                              style: TextStyle(
                                height: 1.3,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Ubuntu',
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Then 5,400.00 /lifeTime',
                              style: TextStyle(
                                height: 1.6,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Ubuntu',
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Text(
                      "Makarajothi Premium is a paid membership, available in certain countries, that gives you an ad-free, "
                      "feature-rich offline viewing.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.3,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Ubuntu',
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
