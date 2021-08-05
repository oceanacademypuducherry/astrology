import 'package:astrology_app/screens/BookingDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentTimeScreen extends StatelessWidget {
  const AppointmentTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff045de9),
        centerTitle: true,
        title: Text(
          'Select Time',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontFamily: 'Ubuntu',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
                child: Column(
                  children: [
                    ///morning
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          // color: Colors.blue,
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            'images/morning.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: Text(
                            'Morning',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(60, 40),
                              fixedSize: Size(80, 35),
                              shadowColor: Colors.grey.shade400,
                              textStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              elevation: 2,
                              onPrimary: Colors.grey,
                              primary: Colors.white,
                            ),
                            child: Text(
                              '9 AM',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(60, 40),
                              fixedSize: Size(80, 35),
                              shadowColor: Colors.grey.shade400,
                              textStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              elevation: 2,
                              onPrimary: Colors.grey,
                              primary: Colors.white,
                            ),
                            child: Text(
                              '9 AM',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(60, 40),
                              fixedSize: Size(80, 35),
                              shadowColor: Colors.grey.shade400,
                              textStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              elevation: 2,
                              onPrimary: Colors.grey,
                              primary: Colors.white,
                            ),
                            child: Text(
                              '9 AM',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),

                    ///afternoon
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          // color: Colors.blue,
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            'images/afternoon.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: Text(
                            'Afternoon',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(60, 40),
                              fixedSize: Size(80, 35),
                              shadowColor: Colors.grey.shade400,
                              textStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              elevation: 2,
                              onPrimary: Colors.grey,
                              primary: Colors.white,
                            ),
                            child: Text(
                              '9 AM',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(60, 40),
                              fixedSize: Size(80, 35),
                              shadowColor: Colors.grey.shade400,
                              textStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              elevation: 2,
                              onPrimary: Colors.grey,
                              primary: Colors.white,
                            ),
                            child: Text(
                              '9 AM',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(60, 40),
                              fixedSize: Size(80, 35),
                              shadowColor: Colors.grey.shade400,
                              textStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              elevation: 2,
                              onPrimary: Colors.grey,
                              primary: Colors.white,
                            ),
                            child: Text(
                              '9 AM',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),

                    ///evening
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          // color: Colors.blue,
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            'images/morning.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: Text(
                            'Evening',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(60, 40),
                              fixedSize: Size(80, 35),
                              shadowColor: Colors.grey.shade400,
                              textStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              elevation: 2,
                              onPrimary: Colors.grey,
                              primary: Colors.white,
                            ),
                            child: Text(
                              '9 AM',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(60, 40),
                              fixedSize: Size(80, 35),
                              shadowColor: Colors.grey.shade400,
                              textStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              elevation: 2,
                              onPrimary: Colors.grey,
                              primary: Colors.white,
                            ),
                            child: Text(
                              '9 AM',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(60, 40),
                              fixedSize: Size(80, 35),
                              shadowColor: Colors.grey.shade400,
                              textStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              elevation: 2,
                              onPrimary: Colors.grey,
                              primary: Colors.white,
                            ),
                            child: Text(
                              '9 AM',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => BookingDetails(),
                          transition: Transition.topLevel,
                          // curve: Curves.ease,
                          duration: Duration(milliseconds: 600));
                    },
                    child: Text('Continue'),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(double.infinity, 50),
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 25,
                        ),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Ubuntu',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
