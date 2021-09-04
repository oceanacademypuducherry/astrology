import 'package:astrology_app/AstroEcom/productController.dart';
import 'package:astrology_app/Forum/forumController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YourOrderController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  final myOrders = [].obs;
  final trackOrderDetails = {}.obs;
  final userAuth = ''.obs;

  setUserAuth(user) {
    userAuth(user);
  }

  setTrackOrderDetails(track) {
    trackOrderDetails(track);
  }

  setMyOrders(orders) {
    myOrders(orders);
    print(myOrders.length);
  }

  getMyOrderDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userNumber = prefs.getString('user').toString();

    final getOrderData = await _firestore
        .collection('buyer')

        ///TODO Product userNumber
        .where('userAuth', isEqualTo: userNumber.toString())
        .get();
    var allProducts = [];
    for (var i in getOrderData.docs) {
      for (var j in i['cartList']) {
        j['status'] = i['orderStatus'];
        allProducts.add(j);
      }
    }
    setMyOrders(allProducts);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyOrderDetails();
  }
}
