import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

class MyOrderWidget extends StatelessWidget {
  MyOrderWidget({this.image, this.title, this.status, this.onTap});
  String? image;
  String? title;
  String? status;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // width: context.screenWidth ),
            // height: context.screenWidth / (screenSize! * 1.5),
            child: Image.network(
              image!,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          title!.text
              .size(18)
              .overflow(TextOverflow.clip)
              .make()
              .box
              .height(70)
              .px4
              .make(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              'status'
                  .text
                  .white
                  .bold
                  .center
                  .make()
                  .p8()
                  .box
                  .width(context.screenWidth / 2.3)
                  .green700
                  .customRounded(BorderRadius.circular(5))
                  .make()
                  .onInkTap(onTap!)
            ],
          )
        ],
      ),
    ).p4();
  }
}
