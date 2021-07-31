import 'package:get/get.dart';

class OtpController extends GetxController {
  final timing = 0.obs;
  final userNumber = ''.obs;

  setTiming(int count) {
    timing(count);
  }

  setUserNumber(String phoneNumber) {
    userNumber(phoneNumber);
  }
}
