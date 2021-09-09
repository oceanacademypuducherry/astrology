import 'package:astrology_app/AstroEcom/CheckoutDetails.dart';
import 'package:astrology_app/AstroEcom/orderController.dart';
import 'package:astrology_app/AstroEcom/productController.dart';
import 'package:astrology_app/Forum/forumController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderDetails extends StatelessWidget {
  OrderController _orderController = Get.find<OrderController>();
  ProductController _productController = Get.find<ProductController>();
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _adress = TextEditingController();
  TextEditingController _landMark = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  'Delivery Address'.text.xl2.make().py20(),

                  ///name
                  VxTextField(
                    controller: _name,
                    fillColor: Vx.white,
                    autofocus: false,
                    labelText: 'Full Name',
                    contentPaddingLeft: 20,
                    borderRadius: 5,
                    borderType: VxTextFieldBorderType.roundLine,
                    height: 60,
                  ).marginOnly(bottom: 20),

                  ///mobile
                  VxTextField(
                    controller: _mobile,
                    fillColor: Vx.white,
                    autofocus: false,
                    labelText: 'Mobile Number',
                    contentPaddingLeft: 20,
                    borderRadius: 5,
                    borderType: VxTextFieldBorderType.roundLine,
                    keyboardType: TextInputType.phone,
                    height: 60,
                  ).marginOnly(bottom: 20),

                  ///adress
                  VxTextField(
                    controller: _adress,
                    fillColor: Vx.white,
                    autofocus: false,
                    labelText: 'Address',
                    contentPaddingLeft: 20,
                    borderRadius: 5,
                    borderType: VxTextFieldBorderType.roundLine,
                    height: 60,
                  ).marginOnly(bottom: 20),

                  /// pincode
                  VxTextField(
                    fillColor: Vx.white,
                    autofocus: false,
                    controller: _pincode,
                    keyboardType: TextInputType.phone,
                    labelText: 'PinCode',
                    contentPaddingLeft: 20,
                    borderRadius: 5,
                    borderType: VxTextFieldBorderType.roundLine,
                    height: 60,
                    onChanged: (value) {
                      _orderController.setUserPinCode(value);
                      if (_orderController.wrongPinCode.value) {
                        VxToast.show(context,
                            msg: 'Check Your Pincode it Not valid',
                            position: VxToastPosition.top,
                            showTime: 2);
                      }
                    },
                  ).marginOnly(bottom: 20),

                  ///land mark
                  VxTextField(
                    controller: _landMark,
                    fillColor: Vx.white,
                    autofocus: false,
                    labelText: 'Landmark',
                    contentPaddingLeft: 20,
                    borderRadius: 5,
                    borderType: VxTextFieldBorderType.roundLine,
                    height: 60,
                    onChanged: (value) {},
                  ).marginOnly(bottom: 20),

                  ///city
                  Obx(() {
                    Color color =
                    _orderController.selectedCity.value == 'Select area'
                        ? Colors.grey
                        : Vx.gray700;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_orderController.selectedCity.value.toString())
                            .text
                            .color(color)
                            .size(18)
                            .make(),
                        if (_orderController.selectedCity.value !=
                            'Select area')
                          PopupMenuButton(
                            // icon: Icon(Icons.arrow_drop_down_rounded),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              size: 30,
                              color: color,
                            ),
                            itemBuilder: (context) {
                              return _orderController.cityList.value
                                  .map((value) {
                                return PopupMenuItem(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList();
                            },
                            onSelected: (value) {
                              print(value);
                              _orderController.selectedCity(value.toString());
                            },
                          ),
                      ],
                    )
                        .paddingOnly(left: 20)
                        .box
                        .width(context.screenWidth)
                        .height(60)
                        .customRounded(BorderRadius.circular(5))
                        .border(width: 2, color: Vx.blue300)
                        .make();
                  }).marginOnly(bottom: 20),

                  ///state
                  Obx(() {
                    Color color =
                    _orderController.selectedCity.value == 'Select area'
                        ? Colors.grey
                        : Vx.gray700;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_orderController.selectedState.value.toString())
                            .text
                            .color(color)
                            .size(18)
                            .make(),
                      ],
                    )
                        .paddingOnly(left: 20)
                        .box
                        .width(context.screenWidth)
                        .height(60)
                        .customRounded(BorderRadius.circular(5))
                        .border(width: 2, color: Vx.blue300)
                        .make();
                  }).marginOnly(bottom: 20),

                  ///submit button
                  MaterialButton(
                    minWidth: context.screenWidth,
                    height: 50,
                    color: Colors.blueAccent,
                    child: Text('Submit Details').text.white.xl2.make(),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      fieldValidation(context);
                      // Get.to(TrackOrder());
                    },
                  ).cornerRadius(5),
                ],
              ).scrollVertical(padding: EdgeInsets.all(25)),
            ),
          ),
        ),
      ),
    );
  }

  fieldValidation(context) {
    if ("${_name.text.toString}".isNotEmpty &&
        "${_mobile.text}".isNumericOnly &&
        _mobile.text.length > 9 &&
        _adress.text.length > 10 &&
        _landMark.text.length > 5 &&
        _orderController.wrongPinCode.value &&
        _orderController.selectedState.value != 'Select State' &&
        _orderController.selectedCity.value != 'Select area') {
      print('success');

      Map orderInfo = {
        "username": _name.text.toString(),
        "number": _mobile.text.toString(),
        "address": _adress.text.toString(),
        "landmark": _landMark.text.toString(),
        "pinCode": _pincode.text.toString(),
        "state": _orderController.selectedState.value.toString(),
        "area": _orderController.selectedCity.value.toString(),
        "cartList": _productController.cartProductList.value.toList(),
        "orderTime": DateTime.now(),
        "totalPrice": _productController.checkoutPrice.value,
        "orderStatus": 'Confirmed',

        ///TODO Product userNumber
        "userAuth":
        _forumContreller.sessionUserInfo.value['phoneNumber'].toString(),
      };
      _orderController.setOrderDelivery(orderInfo);
      Get.to(
        CheckoutDetails(),
        transition: Transition.cupertino,
        duration: Duration(milliseconds: 500),
      );
    } else {
      print('fails');
      VxToast.show(
        context,
        msg: 'Fill all the Fields',
        position: VxToastPosition.top,
        bgColor: Colors.red,
        textColor: Vx.white,
        textSize: 18,
      );
    }
  }
}
