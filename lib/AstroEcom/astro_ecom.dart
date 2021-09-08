import 'package:astrology_app/AstroEcom/ProductCard.dart';
import 'package:astrology_app/AstroEcom/ViewCart.dart';
import 'package:astrology_app/AstroEcom/ViewProduct.dart';
import 'package:astrology_app/AstroEcom/YourOrders.dart';
import 'package:astrology_app/AstroEcom/productController.dart';
import 'package:astrology_app/AstroEcom/yourOrderController.dart';

import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/widgets/BottomNavigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:badges/badges.dart';

class AstroEcom extends StatefulWidget {
  @override
  _AstroEcomState createState() => _AstroEcomState();
}

class _AstroEcomState extends State<AstroEcom> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ProductController _productController = Get.find<ProductController>();
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  YourOrderController _yourOrderController = Get.find<YourOrderController>();

  setProductSession(List<dynamic> cartList) async {
    final encodeData = json.encode(cartList);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cartList', encodeData);

    final cartSession = await prefs.getString('cartList');
    final decodeData = json.decode(cartSession!);

    _productController.cartProductList.value = decodeData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        centerTitle: true,
        actions: [
          Obx(
            () => Badge(
              badgeColor: Vx.red600,
              // ignore: invalid_use_of_protected_member
              showBadge: _productController.cartProductList.value.length == 0
                  ? false
                  : true,
              badgeContent:
                  // ignore: invalid_use_of_protected_member
                  _productController.cartProductList.value.length
                      .toString()
                      .text
                      .white
                      .make(),
              position: BadgePosition(top: 5, end: -10),
              child: Icon(Icons.shopping_cart),
              animationType: BadgeAnimationType.slide,
            ),
          ).onInkTap(() {
            _productController.setCheckoutPrice();
            Get.to(
              // CheckoutDetails(),
              ViewCart(),
              transition: Transition.cupertino,
              duration: Duration(milliseconds: 500),
            );
          }),
          SizedBox(
            width: 30,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: () {
          Get.offAll(BottomNavigation());
        },
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Container(
            color: Colors.transparent,
            height: 600,
            child: Column(
              children: [
                Container(
                  height: 150,
                  color: Colors.grey[200],
                  child: Row(
                    children: [
                      ///TODO Product userProfile
                      Image.network(
                        _forumContreller.sessionUserInfo.value['profile'],
                        fit: BoxFit.cover,
                      )
                          .box
                          .height(100)
                          .width(100)
                          .make()
                          .cornerRadius(200)
                          .p8(),
                      VStack(
                        [
                          ///TODO Product userName
                          _forumContreller.sessionUserInfo.value['name']
                              .toString()
                              .text
                              .size(20)
                              .make()
                              .box
                              .width(context.screenWidth / 2.3)
                              .make(),

                          ///TODO Product userNumber
                          _forumContreller.sessionUserInfo.value['phoneNumber']
                              .toString()
                              .text
                              .size(10)
                              .make()
                              .box
                              .width(context.screenWidth / 2.3)
                              .make()
                              .marginOnly(top: 5),
                        ],
                        alignment: MainAxisAlignment.center,
                      )
                    ],
                  ),
                ),
                ListTile(
                  minVerticalPadding: 10,
                  leading: Icon(Icons.shopping_cart_outlined),
                  title: Text("My Order").text.xl.coolGray500.make(),
                  onTap: () {
                    Get.back();
                    _yourOrderController.getMyOrderDetails();
                    Get.to(YourOrder(),
                        transition: Transition.cupertino,
                        duration: Duration(milliseconds: 500));
                  },
                  tileColor: Colors.grey[300],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('Products').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('No product datas');
              } else {
                final productDatas = snapshot.data!.docs;
                final productDatasList = [];
                for (var i in productDatas) {
                  Map convertData = {
                    'productRating': i['productRating'],
                    'productPrice': i['productPrice'],
                    'productName': i['productName'],
                    'productDisplayImage': i['productDisplayImage'],
                    'productDescription': i['productDescription'],
                    'totalPrice': i['productPrice'],
                    'docId': i.id
                  };

                  productDatasList.add(convertData);
                }
                _productController.setProductList(productDatasList);
                var size = context.screenWidth;
                printWarning(context.screenWidth.toString());
                printWarning((context.screenWidth / context.screenWidth * 0.4)
                    .toString());
                return GridView.count(
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  physics: ScrollPhysics(),
                  // shrinkWrap: true,
                  controller: new ScrollController(keepScrollOffset: true),
                  childAspectRatio: size < 360 ? 49 : 0.56,
                  children: [
                    // ignore: invalid_use_of_protected_member
                    for (var i in _productController.productList.value)
                      ProductCard(
                        title: i['productName'],
                        price: i['productPrice'],
                        image: i['productDisplayImage'],
                        rating: i['productRating'],
                        addTocart: () async {
                          // ignore: invalid_use_of_protected_member
                          if (_productController.checkingCart(i['docId'])) {
                            VxToast.show(context,
                                msg:
                                    'you already added this product in you cart');
                          } else {
                            _productController.setCartProductList(i);
                            VxToast.show(context,
                                msg: 'This product added in your cart');
                          }
                        },
                        productView: () {
                          _productController.setProductView(i);
                          print(i);
                          Get.to(ViewProduct(),
                              transition: Transition.cupertino,
                              duration: Duration(milliseconds: 500));
                        },
                      ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
