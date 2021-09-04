import 'package:astrology_app/AstroEcom/MyOderWidget.dart';
import 'package:astrology_app/AstroEcom/TrackOrder.dart';
import 'package:astrology_app/AstroEcom/yourOrderController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourOrder extends StatelessWidget {
  int girdCount = 2;
  YourOrderController _yourOrderController = Get.find<YourOrderController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
          actions: [
            IconButton(
                onPressed: () {
                  _yourOrderController.getMyOrderDetails();
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        body: Container(
          child: Container(
              child: Obx(() => GridView.count(
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.58,
                    crossAxisCount: 2,
                    children: [
                      // ignore: invalid_use_of_protected_member
                      for (var orderData in _yourOrderController.myOrders.value)
                        MyOrderWidget(
                          status: orderData['status'],
                          image: orderData['productDisplayImage'],
                          title: orderData['productName'],
                          onTap: () {
                            _yourOrderController
                                .setTrackOrderDetails(orderData);
                            print(orderData);
                            Get.to(TrackOrder(),
                                transition: Transition.cupertino,
                                duration: Duration(milliseconds: 500));
                          },
                        )
                    ],
                  ))),
        ));
  }
}
