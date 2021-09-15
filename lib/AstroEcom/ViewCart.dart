import 'dart:ui';

import 'package:astrology_app/AstroEcom/CartEdit.dart';
import 'package:astrology_app/AstroEcom/OrderDetails.dart';
import 'package:astrology_app/AstroEcom/productController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:convert';

// ignore: must_be_immutable
class ViewCart extends StatelessWidget {
  ProductController _productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Obx(() => Text(
              'Total Items ${_productController.cartProductList.value.length}'))),
      bottomSheet: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        child: MaterialButton(
          color: Colors.lightBlueAccent,
          minWidth: context.screenWidth,
          splashColor: Colors.blueAccent,
          height: 50,
          highlightColor: Colors.blue,
          child: Obx(() => ' Pay Rs. ${_productController.checkoutPrice.value}'
              .text
              .white
              .size(20)
              .bold
              .make()),
          onPressed: () {
            if (_productController.checkoutPrice.value != 0) {
              Get.to(
                OrderDetails(),
                transition: Transition.cupertino,
                duration: Duration(milliseconds: 500),
              );
            } else {
              VxDialog.showAlert(context, content: "Cart is Empty");
            }
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 50),
        child: Obx(() => ListView.builder(
            // ignore: invalid_use_of_protected_member
            itemCount: _productController.cartProductList.value.length,
            itemBuilder: (context, index) {
              // ignore: invalid_use_of_protected_member
              final cartItem = _productController.cartProductList.value[index];
              return CartEdit(
                title: cartItem['productName'],
                image: cartItem['productDisplayImage'],
                price: cartItem['productPrice'],
                productId: index,
              );
            })),
      ),
    );
  }
}
