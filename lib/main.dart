import 'package:astrology_app/AstroEcom/astro_ecom.dart';
import 'package:astrology_app/AstroEcom/orderController.dart';
import 'package:astrology_app/AstroEcom/productController.dart';
import 'package:astrology_app/AstroEcom/yourOrderController.dart';
import 'package:astrology_app/atentication/login.dart';
import 'package:astrology_app/atentication/otp_controller.dart';
import 'package:astrology_app/atentication/otp_page.dart';
import 'package:astrology_app/controller/article_controller.dart';
import 'package:astrology_app/controller/otp_controller.dart';
import 'package:astrology_app/screens/htmlpage.dart';

import 'package:astrology_app/widgets/BottomNavigation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:astrology_app/Forum/forumController.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();

  Get.put(ArticleController());
  Get.put(ForumContreller());
  Get.put(OTPController());
  Get.put(YourOrderController());
  Get.put(ProductController());
  Get.put(OrderController());

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String userNumber = prefs.getString('user').toString();
  // String userNumber = '+91 8015122373';

  var userDatas = await _firestore.collection('newusers').get();
  for (var i in userDatas.docs) {
    if (i['phoneNumber'] == userNumber) {
      Get.find<ForumContreller>().setUserSession(userNumber.toString());

      Get.find<ForumContreller>().setUserInfo(i.data());
      Get.find<ForumContreller>().setUserDocumentId(i.id.toString());
    }
  }

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Ubuntu'),
      home: Scaffold(body: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  static String? session;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ForumContreller _forumContreller = Get.find<ForumContreller>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscribeEnd();

    print('.......................');
    print(_forumContreller.userSession.value);
    print(_forumContreller.sessionUserInfo.value);

    print('.......................');
  }

  var checking;
  subscribeEnd() async {
    try {
      var subscribeDatas = await _firestore.collection('subscribeList').get();
      for (var i in subscribeDatas.docs) {
        if (i['phoneNumber'] == _forumContreller.userSession.value) {
          checking = i['time'].toDate().difference(DateTime.now()).inSeconds;
          print(
              '${checking} iiiiiiiiiiiiiiiiiiiiiiiiiiissssssuuuubbbbbbbbbbbbiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
          if (i["plan"] != "Life Time Subscription") {
            if (checking < 0) {
              _firestore
                  .collection('newusers')
                  .doc(_forumContreller.userDocumentId.value)
                  .update({'subscribe': false});
              print('added successfully');

              var userDatas = await _firestore.collection('newusers').get();
              for (var i in userDatas.docs) {
                if (i['phoneNumber'] == _forumContreller.userSession.value) {
                  print(
                      '88888888888888888888888888888888888888888888888888888888888888888');
                  print(i.data());

                  Get.find<ForumContreller>().setUserInfo(i.data());
                  Get.find<ForumContreller>()
                      .setUserDocumentId(i.id.toString());
                }
              }
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.blue,
        resizeToAvoidBottomInset: false,
        body: _forumContreller.userSession.value.isNotEmpty
            ? BottomNavigation()
            : Login(),
        // ? AstroEcom()
        // : AstroEcom(),
      ),
    );
  }
}
