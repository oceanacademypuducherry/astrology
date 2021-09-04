import 'dart:convert';
import 'package:astrology_app/AstroEcom/YourOrders.dart';
import 'package:astrology_app/AstroEcom/astro_ecom.dart';
import 'package:astrology_app/Forum/forumController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:astrology_app/AstroEcom/orderController.dart';
import 'package:astrology_app/AstroEcom/productController.dart';
import 'package:astrology_app/AstroEcom/yourOrderController.dart';

class CheckoutDetails extends StatefulWidget {
  @override
  _CheckoutDetailsState createState() => _CheckoutDetailsState();
}

class _CheckoutDetailsState extends State<CheckoutDetails> {
  late Razorpay _razorpay;
  late FlutterLocalNotificationsPlugin localNotification;
  OrderController _orderController = Get.find<OrderController>();
  ProductController _productController = Get.find<ProductController>();
  YourOrderController _yourOrderController = Get.find<YourOrderController>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
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

  void openCheckout() async {
    var options = {
      'key': 'rzp_live_yI4lHyiI5FRJWt',
      'amount': 100,
      'name': 'OceanAcademy',
      'description': 'Booking Appointment',
      'prefill': {
        'contact': _orderController.orderDelivery.value['number'],
        'email': 'test@gmail.com'
      },
      'external': {
        'wallets': ['paytm', 'phonepe']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "channelName", "Your Order Confirmed",
        importance: Importance.max);
    ForumContreller _forumContreller = Get.find<ForumContreller>();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails);
    await localNotification.show(
        0,
        'Hi ${_forumContreller.sessionUserInfo.value['name']}',
        'We received your order, let you know once packed!',
        generalNotificationDetails);
  }

  Future notificationSelected(String? payload) async {
    Get.to(
      () => YourOrder(),
      transition: Transition.rightToLeft,
      curve: Curves.easeInToLinear,
      duration: Duration(milliseconds: 600),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    VxToast.show(
      context,
      msg: 'Success',
      position: VxToastPosition.bottom,
      bgColor: Colors.green,
      textColor: Vx.white,
      textSize: 15,
    );
    _orderController.updateOrderDelivery(
        'paymentId', response.paymentId.toString());
    printWarning(response.paymentId.toString());

    Map<String, dynamic> firebaseData = {};
    for (var data in _orderController.orderDelivery.value.entries) {
      firebaseData[data.key.toString()] = data.value;
    }
    _firestore.collection('buyer').add(firebaseData);
    _productController.clearCartProductList();
    _yourOrderController.getMyOrderDetails();
    Get.offAll(AstroEcom());
    showNotification();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    printWarning(response.message.toString());
    // var test = json.decode([response]);
    var test = jsonDecode(response.message.toString());
    print(response.message);
    print(test.runtimeType);
    print(test['error']['description']);

    VxDialog.showConfirmation(context,
        content: "${test['error']['description']}",
        confirm: "Retry",
        cancel: "Back To Home",
        title: "Payment Failed", onCancelPress: () {
      Get.offAll(AstroEcom());
    }, onConfirmPress: openCheckout);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    VxToast.show(
      context,
      msg: 'Wallet pay',
      position: VxToastPosition.bottom,
      bgColor: Colors.yellow[900],
      textColor: Vx.white,
      textSize: 15,
    );
    printWarning(response.walletName.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Container(
          color: Vx.white,
          // padding: EdgeInsets.symmetric(horizontal: 20),

          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.close))
                      ],
                    ),
                    Text('Check Your Order Info')
                        .text
                        .xl2
                        .make()
                        .marginOnly(top: 20, bottom: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var userInfo
                                in _orderController.orderDelivery.value.entries)
                              if (userInfo.key != 'cartList' &&
                                  userInfo.key != "orderTime" &&
                                  userInfo.key != "userAuth" &&
                                  userInfo != 'orderStatus')
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Text(userInfo.key)
                                          .text
                                          .size(20)
                                          .make()
                                          .box
                                          .width(context.screenWidth / 3)
                                          .make(),
                                      Text(userInfo.value.toString())
                                          .text
                                          .size(20)
                                          .make()
                                          .box
                                          // .alignCenter
                                          .width(context.screenWidth / 2)
                                          .make(),
                                    ],
                                  ),
                                )
                          ],
                        ).scrollVertical(),
                      ),
                    ),
                  ],
                ),
                MaterialButton(
                  minWidth: context.screenWidth,
                  height: 50,
                  color: Colors.blueAccent,
                  child: Text('Okay').text.white.xl2.make(),
                  onPressed: () {
                    VxDialog.showTicker(
                      context,
                      barrierDismissible: true,
                      confirm: 'Proceed',
                      showClose: true,
                      // title:
                      //     'Rs. ${_productController.checkoutPrice.value.toString()}',
                      content:
                          'Proceed to pay Rs. ${_productController.checkoutPrice.value.toString()}',
                      onConfirmPress: openCheckout,
                    );
                    // Get.to(TrackOrder());
                  },
                ).cornerRadius(5),
              ],
            ),
          ),
        ).cornerRadius(15),
      ),
    );
  }
}
