import 'package:astrology_app/AstroEcom/orderController.dart';
import 'package:astrology_app/AstroEcom/productController.dart';
import 'package:astrology_app/AstroEcom/yourOrderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class TrackOrder extends StatelessWidget {
  ProductController _productController = Get.find<ProductController>();
  OrderController _orderController = Get.find<OrderController>();
  YourOrderController _yourOrderController = Get.find<YourOrderController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                ///image
                Stack(
                  children: [
                    Image.network(
                      _yourOrderController
                          .trackOrderDetails.value['productDisplayImage'],
                      fit: BoxFit.cover,
                    )
                        .box
                        .height(
                          context.screenWidth / 1.6,
                        )
                        .width(context.screenWidth)
                        .shadow2xl
                        .make(),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///title
                      _yourOrderController
                          .trackOrderDetails.value['productName']
                          .toString()
                          .text
                          .size(25)
                          .make()
                          .marginOnly(top: 20),

                      ///Row ratting price
                      HStack(
                        // children:
                        [
                          VxRating(
                            onRatingUpdate: (val) {
                              print(val);
                            },
                            isSelectable: false,
                            maxRating: 5,
                            value: _yourOrderController
                                .trackOrderDetails.value['productRating']
                                .toDouble(),
                            size: 25,
                            count: 5,
                            selectionColor: Colors.deepOrangeAccent,
                          ).py8(),
                          'Rs. ${int.parse(_yourOrderController.trackOrderDetails.value['productPrice'].toString()).numCurrency}'
                              .text
                              .xl3
                              .make(),
                        ],
                        alignment: MainAxisAlignment.spaceAround,
                        axisSize: MainAxisSize.max,
                      ).marginSymmetric(vertical: 20),
                      _yourOrderController
                          .trackOrderDetails.value['productDescription']
                          .toString()
                          .text
                          .xl
                          .make(),
                    ],
                  ),
                ),
              ],
            ),
            VxTimeline(
              timelineList: [
                VxTimelineModel(
                    id: 2,
                    heading: 'Confirmed',
                    description:
                        'We received your order, let you know once packed!'),
                if (_yourOrderController.trackOrderDetails.value['status'] ==
                        'Packed' ||
                    _yourOrderController.trackOrderDetails.value['status'] ==
                        'Delivered')
                  VxTimelineModel(
                      id: 2,
                      heading: 'Packed',
                      description:
                          'Your order is Packed! and on the way to delivery!'),
                if (_yourOrderController.trackOrderDetails.value['status'] ==
                    'Delivered')
                  VxTimelineModel(
                      id: 2,
                      heading: 'Delivered',
                      description:
                          'Your package is delivered to given Address.'),
              ],
              animationDuration: Duration(seconds: 1),
              showTrailing: false,
            ),
          ],
        ),
      ),
    ));
  }
}
