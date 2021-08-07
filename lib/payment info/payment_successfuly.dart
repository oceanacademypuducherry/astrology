import 'package:flutter/material.dart';

class PaymentSuccessfully extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.network('images/payment_success.png')],
        ),
      ),
    );
  }
}
