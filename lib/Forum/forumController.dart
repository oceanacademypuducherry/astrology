import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ForumContreller extends GetxController {
  final userSession = ''.obs;
  final sessionUserInfo = {}.obs;
  final userDocumentId = ''.obs;
  final isShow = false.obs;
  final joinUrl = ''.obs;
  final startUrl = ''.obs;
  final startDate = ''.obs;
  final freeTime = [].obs;

  ///matchs
  final htmlContent = ''.obs;
  final htmlTitle = ''.obs;

  setHtmlContent(content) {
    htmlContent(content);
  }

  setFreeTime(listValue) {
    freeTime(listValue);
  }

  setStartUrl(url) {
    startUrl(url);
  }

  setHtmlTitle(title) {
    htmlTitle(title);
  }

  setJoinUrl(url) {
    joinUrl(url);
  }

  final matchingToken = ''.obs;

  final maximunPoint = 0.0.obs;
  setMaximumPoint(token) {
    maximunPoint(token);
  }

  setMatchingToken(token) {
    matchingToken(token);
  }

  ///

  setIsShow(show) {
    isShow(show);
  }

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
