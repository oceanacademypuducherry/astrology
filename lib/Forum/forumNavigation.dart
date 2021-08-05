// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:forum/Forum/forum.dart';
// import 'package:forum/Forum/forumController.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ForumNavigation extends StatelessWidget {
//   ForumContreller _forumContreller = Get.find<ForumContreller>();
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Obx(() => Text(_forumContreller.userSession.value)),
//               TextButton(
//                 child: Text('Go to Forum'),
//                 onPressed: () async {
//                   await _forumContreller.getSession();
//
//                   final userData =
//                       await _firestore.collection('newusers').get();
//                   for (var user in userData.docs) {
//                     if (_forumContreller.userSession.value ==
//                         user['PhoneNumber']) {
//                       _forumContreller.setUserInfo(user.data());
//                     }
//                   }
//
//                   print(_forumContreller.sessionUserInfo.value);
//                   Get.to(() => Forum());
//                 },
//               ),
//               TextButton(
//                   onPressed: () async {
//                     SharedPreferences _preferences =
//                         await SharedPreferences.getInstance();
//                     _preferences.setString('user', '+91 1234567890');
//                     _forumContreller.getSession();
//                     // _firestore.collection('newusers').add({
//                     //   "name": 'ijass',
//                     //   "email": 'ij@gmail.com',
//                     //   "jadhagam": 'jadhagamLink',
//                     //   'profile': 'profilePictureLink',
//                     //   'PhoneNumber': '+91 9876543210',
//                     // });
//                   },
//                   child: Text('add user data')),
//               TextButton(
//                   onPressed: () async {
//                     SharedPreferences _preferences =
//                         await SharedPreferences.getInstance();
//                     _preferences.setString('user', '');
//                     _forumContreller.getSession();
//                   },
//                   child: Text('remove session')),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
