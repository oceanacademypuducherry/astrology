import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/payment%20info/payment_successfuly.dart';
import 'package:astrology_app/screens/PdfView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class BooksDescription extends StatefulWidget {
  String bookImage;
  String bookName;
  String bookType;
  String description;
  String pdfLink;
  BooksDescription(
      {required this.bookImage,
      required this.bookName,
      required this.description,
      required this.bookType,
      required this.pdfLink});

  @override
  _BooksDescriptionState createState() => _BooksDescriptionState();
}

class _BooksDescriptionState extends State<BooksDescription> {
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  late Razorpay _razorpay;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? getId;
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

  @override
  void initState() {
    super.initState();
    book_id();
    var alteredPhone = _forumContreller.userSession.value;
    smsNumber = (alteredPhone.substring(1, 3) + alteredPhone.substring(4, 14));
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void book_id() async {
    print("---------------------------");
    await for (var snapshot in _firestore
        .collection('books')
        .where("bookLink", isEqualTo: widget.bookImage)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        getId = message.id;
        print('${getId} testingggggggggggggggggggggggggggggggggggg');
      }
    }

    print("---------------------------");
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    _firestore.collection('BookPaymentDetails').add({
      'time': DateTime.now(),
      'phoneNumber': _forumContreller.userSession.value,
      'email': _forumContreller.sessionUserInfo.value['email'],
      'userName': _forumContreller.sessionUserInfo.value['name'],
      'payment': widget.bookType,
      'bookName': widget.bookName,
    });

    _firestore
        .collection('newusers')
        .doc('${_forumContreller.userDocumentId.value}')
        .update({
      'books': FieldValue.arrayUnion([widget.bookName]),
    });

    var updateUser = await _firestore
        .collection('newusers')
        .doc(_forumContreller.userDocumentId.value)
        .get();
    _forumContreller.setUserInfo(updateUser.data());
    print('uploaded successfully');
    var message =
        "Hi ${_forumContreller.sessionUserInfo.value['name']} you have purched ${widget.bookName} book";
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

      ///to make widget.book type
      'amount': 100,
      'name': 'Ocean Academy',
      'description': widget.bookName,
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
      debugPrint('Error: e thhhhhhhhhhhhhhhhhhhhhhhhhh');
    }
  }

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    splashRadius: 10,
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 180,
                            width: 130,
                            child: CachedNetworkImage(
                              imageUrl: widget.bookImage,
                              placeholder: (context, url) => Center(
                                child: Container(
                                  child: CircularProgressIndicator(),
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          width: 140,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.bookName,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 14,
                                    height: 1.3,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Ubuntu",
                                    letterSpacing: 0.6,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'BY GURUJI',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 10,
                                    fontFamily: "Ubuntu",
                                    letterSpacing: 0.4,
                                    height: 1,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              // SizedBox(height: 8),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.bookType == 'free'
                                      ? widget.bookType.toUpperCase()
                                      : "₹ ${widget.bookType.toUpperCase()}",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 10,
                                    fontFamily: "Ubuntu",
                                    letterSpacing: 0.4,
                                    height: 2,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: OutlinedButton(
                              onPressed: widget.bookType == 'free' ||
                                      (widget.bookType != 'free' &&
                                          _forumContreller
                                              .sessionUserInfo.value['books']
                                              .contains(widget.bookName))
                                  ? () {
                                      print('jayatha');
                                      setState(() {
                                        isOpen = true;
                                      });
                                      Get.to(
                                          () => PdfView(
                                                pdfLink: widget.pdfLink,
                                                appBarName: "View Full Book",
                                              ),
                                          transition: Transition.rightToLeft,
                                          curve: Curves.easeInToLinear,
                                          duration:
                                              Duration(milliseconds: 600));
                                    }
                                  : () {
                                      // _firestore
                                      //     .collection('books')
                                      //     .doc(getId)
                                      //     .update({'type': 'free'});
                                      openCheckout();
                                    },
                              style: ElevatedButton.styleFrom(
                                elevation: 1,
                                primary: Colors.white,
                                textStyle: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontFamily: "Ubuntu",
                                  letterSpacing: 0.4,
                                  height: 1,
                                ),
                              ),
                              child: widget.bookType == 'free' ||
                                      (widget.bookType != 'free' &&
                                          _forumContreller
                                              .sessionUserInfo.value['books']
                                              .contains(widget.bookName))
                                  ? Text('View Full Book')
                                  : Text('Proceed to pay')),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        height: 1.6,
                        fontWeight: FontWeight.w600,
                        // fontStyle: FontStyle.italic,
                        fontFamily: "Ubuntu",
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Scrollbar(
                    radius: Radius.circular(1),
                    thickness: 1,
                    interactive: true,
                    child: ListView(
                      children: [
                        Text(
                          widget.description,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                            height: 1.6,
                            fontWeight: FontWeight.normal,
                            // fontStyle: FontStyle.italic,
                            fontFamily: "Ubuntu",
                            letterSpacing: 0.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
