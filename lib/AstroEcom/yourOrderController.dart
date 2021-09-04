import 'package:astrology_app/AstroEcom/productController.dart';
import 'package:astrology_app/Forum/forumController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

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
    printWarning(userAuth.toString());
    String authNember = userAuth.value.toString().trim();
    final getOrderData = await _firestore
        .collection('buyer')

        ///TODO Product userNumber
        .where('userAuth', isEqualTo: authNember)
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
    getMyOrderDetails();
    // TODO: implement onInit
    super.onInit();
  }
}
