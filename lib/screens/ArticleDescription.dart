import 'package:flutter/material.dart';

class ArticleDescription extends StatelessWidget {
  const ArticleDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                offset: const Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
            ], //Box]
          ),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
