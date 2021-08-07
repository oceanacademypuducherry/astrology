import 'package:flutter/material.dart';

class PaymentSuccessfully extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/payment_success.png'),
              SizedBox(
                height: 60,
              ),
              Text(
                'Payment Successfully',
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff5AC4F9),
                    fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                child: Text('Okay'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff5AC4F9),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
