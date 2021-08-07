import 'package:flutter/material.dart';

class PaymentSuccessfully extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [Image.network('images/payment_success.svg')],
        ),
      ),
    );
  }
}
