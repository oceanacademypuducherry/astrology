import 'package:astrology_app/controller/otp_controller.dart';
import 'package:astrology_app/screens/ProfileScreen.dart';
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
  Get.put(OtpController());
  Get.put(ForumContreller());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userNumber = prefs.getString('user').toString();
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
  // route = MyApp.session != null ? HomeScreen() : Login();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('.......................');
    print(_forumContreller.userSession.value);
    print(_forumContreller.sessionUserInfo.value);

    print('.......................');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.blue,
        resizeToAvoidBottomInset: false,
        body: _forumContreller.userSession.value.isNotEmpty
            ? ProfileScreen()
            : ProfileScreen(),
      ),
    );
  }
}
