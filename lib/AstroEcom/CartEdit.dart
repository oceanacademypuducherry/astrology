import 'package:astrology_app/AstroEcom/productController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class CartEdit extends StatefulWidget {
  CartEdit({this.image, this.title, this.price, this.productId});
  String? image;
  String? title;
  int? price = 0;
  int? productId = 0;
  double? rating = 2.5;

  @override
  _CartEditState createState() => _CartEditState();
}

class _CartEditState extends State<CartEdit> {
  ProductController _productController = Get.find<ProductController>();

  int quantity = 1;

  @override
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.title.toString()),
      // key: Key(widget.productId.toString()),
      onDismissed: (val) {
        _productController.removeCartProductList(widget.productId);
        _productController.setCheckoutPrice();
        print(val);
      },
      child: Container(
        // height: 180,
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        child: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      '${widget.image}',
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width / 3,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      '${widget.title!}'
                          .text
                          .ellipsis
                          .maxLines(3)
                          .size(20)
                          .make()
                          .box
                          .width(MediaQuery.of(context).size.width / 1.65)
                          .make()
                          .px8(),
                      Row(
                        children: [
                          VxRating(
                            onRatingUpdate: (val) {
                              print(val);
                            },
                            isSelectable: false,
                            maxRating: 5,
                            value: widget.rating!.toDouble(),
                            size: 25,
                            count: 5,
                            selectionColor: Colors.deepOrangeAccent,
                          ).py8(),
                          '(${widget.rating!.toDouble()})'.text.size(18).make()
                        ],
                      ).px8(),
                    ],
                  ),
                ],
              ),
              Container(
                // width: MediaQuery.of(context).size.width / 1.65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    'Rs. ${(widget.price! * quantity).numCurrency}'
                        .text
                        .size(18)
                        .coolGray500
                        .make()
                        .px8(),
                    VxStepper(
                      defaultValue: 1,
                      min: 1,
                      onChange: (val) {
                        _productController.updateCartProductList(
                            index: widget.productId,
                            key: "totalPrice",
                            value: widget.price! * val);
                        _productController.setCheckoutPrice();
                        setState(() {
                          quantity = val;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _productController
                            .removeCartProductList(widget.productId);
                        _productController.setCheckoutPrice();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
