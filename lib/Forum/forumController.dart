import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ForumContreller extends GetxController {
  final userSession = ''.obs;
  final sessionUserInfo = {}.obs;
  final userDocumentId = ''.obs;

  setUserDocumentId(documentId) {
    userDocumentId(documentId);
  }

  setUserInfo(userInfo) {
    sessionUserInfo(userInfo);
  }

  setUserSession(String userNumber) {
    userSession(userNumber);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    // getSession();
    super.onInit();
  }
}
