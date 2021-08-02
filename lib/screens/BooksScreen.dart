import 'package:astrology_app/screens/BooksDescription.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

Widget? BottomSheet() {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 30,
      ),
      width: double.infinity,
      height: 170,
      color: Colors.white,
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.only(
      //   topLeft: Radius.circular(30),
      //   topRight: Radius.circular(30),
      // )),
      child: Row(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 120,
                  width: 100,
                  child: Image.asset(
                    'images/books/book2.jpg',
                    fit: BoxFit.cover,

                    // alignment: Alignment.center,
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 55,
                width: 140,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'The Broken Circle ',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 14,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Ubuntu",
                          letterSpacing: 0.6,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'BY GURUJI',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 10,
                          fontFamily: "Ubuntu",
                          letterSpacing: 0.4,
                          height: 1,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Free',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 10,
                          fontFamily: "Ubuntu",
                          letterSpacing: 0.4,
                          height: 1,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    Get.to(BooksDescription());
                  },
                  child: Text('PreView'))
            ],
          )
        ],
      ),
    ),
    barrierColor: Colors.black.withOpacity(0.7),
    isDismissible: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      side: BorderSide(
        width: 0.1,
        color: Colors.black,
      ),
    ),
    enableDrag: true,
  );
}

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  Widget build(BuildContext context) {
    // final title = 'Grid List';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          flexibleSpace: Image.asset(
            'images/background_image.png',
            fit: BoxFit.cover,
          ),
          title: Text(
            'Books',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "Ubuntu",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconSample(),
                            Text(
                              'Books Collection',
                              style: TextStyle(
                                color: Colors.blue.withOpacity(0.8),
                                fontSize: 18,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 6),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                          child: Column(
                            // mainAxisAlignment:
                            //     MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 10,
                                child: Icon(
                                  Icons.arrow_drop_up_outlined,
                                  size: 15,
                                  color: Colors.blue.withOpacity(0.8),
                                ),
                              ),
                              Container(
                                height: 15,
                                child: Icon(
                                  Icons.arrow_drop_down_outlined,
                                  size: 12,
                                  color: Colors.blue.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Wrap(
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.center,
                      runSpacing: 10,
                      spacing: 40,
                      children: [
                        //books
                        GestureDetector(
                          onTap: () {
                            BottomSheet();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 180,
                                    width: 135,
                                    child: Image.asset(
                                      'images/books/book2.jpg',
                                      fit: BoxFit.cover,

                                      // alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 55,
                                  width: 135,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'The Broken Circle',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 13,
                                            height: 1.3,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'BY GURUJI',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 10,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                            height: 1,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                  height: 150,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 20,
                                            child: Image.asset(
                                              'images/razorpay.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                color: Colors.blue,
                                                width: 120,
                                                height: 50,
                                                child: Text('Payment Amount')),
                                            Container(
                                              alignment: Alignment.center,
                                              color: Colors.blue,
                                              width: 120,
                                              height: 50,
                                              child: Text('₹ 12,000'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              barrierColor: Colors.transparent,
                              isDismissible: true,
                              shape: RoundedRectangleBorder(
                                // borderRadius: BorderRadius.only(topLeft: 1),
                                side: BorderSide(
                                  width: 0.1,
                                  color: Colors.black,
                                ),
                              ),
                              enableDrag: true,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    height: 180,
                                    width: 135,
                                    child: Image.asset(
                                      'images/books/book5.jpg',
                                      fit: BoxFit.cover,

                                      // alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 55,
                                  width: 135,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Astrology Crystal Shadow',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 13,
                                            height: 1.3,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'BY GURUJI',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 10,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                            height: 1,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                  height: 150,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 20,
                                            child: Image.asset(
                                              'images/razorpay.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                color: Colors.blue,
                                                width: 120,
                                                height: 50,
                                                child: Text('Payment Amount')),
                                            Container(
                                              alignment: Alignment.center,
                                              color: Colors.blue,
                                              width: 120,
                                              height: 50,
                                              child: Text('₹ 12,000'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              barrierColor: Colors.transparent,
                              isDismissible: true,
                              shape: RoundedRectangleBorder(
                                // borderRadius: BorderRadius.only(topLeft: 1),
                                side: BorderSide(
                                  width: 0.1,
                                  color: Colors.black,
                                ),
                              ),
                              enableDrag: true,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 180,
                                    width: 135,
                                    child: Image.asset(
                                      'images/books/book6.jpg',
                                      fit: BoxFit.cover,

                                      // alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 55,
                                  width: 135,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Your Personal Horoscopes',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 13,
                                            height: 1.3,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'BY GURUJI',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 10,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                            height: 1,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                  height: 150,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 20,
                                            child: Image.asset(
                                              'images/razorpay.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                color: Colors.blue,
                                                width: 120,
                                                height: 50,
                                                child: Text('Payment Amount')),
                                            Container(
                                              alignment: Alignment.center,
                                              color: Colors.blue,
                                              width: 120,
                                              height: 50,
                                              child: Text('₹ 12,000'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              barrierColor: Colors.transparent,
                              isDismissible: true,
                              shape: RoundedRectangleBorder(
                                // borderRadius: BorderRadius.only(topLeft: 1),
                                side: BorderSide(
                                  width: 0.1,
                                  color: Colors.black,
                                ),
                              ),
                              enableDrag: true,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 180,
                                    width: 135,
                                    child: Image.asset(
                                      'images/books/book7.jpg',
                                      fit: BoxFit.cover,

                                      // alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 55,
                                  width: 135,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Know My Name Chanel Miller',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 13,
                                            height: 1.3,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'BY GURUJI',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 10,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                            height: 1,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                  height: 150,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 20,
                                            child: Image.asset(
                                              'images/razorpay.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                color: Colors.blue,
                                                width: 120,
                                                height: 50,
                                                child: Text('Payment Amount')),
                                            Container(
                                              alignment: Alignment.center,
                                              color: Colors.blue,
                                              width: 120,
                                              height: 50,
                                              child: Text('₹ 12,000'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              barrierColor: Colors.transparent,
                              isDismissible: true,
                              shape: RoundedRectangleBorder(
                                // borderRadius: BorderRadius.only(topLeft: 1),
                                side: BorderSide(
                                  width: 0.1,
                                  color: Colors.black,
                                ),
                              ),
                              enableDrag: true,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 180,
                                    width: 135,
                                    child: Image.asset(
                                      'images/books/book8.jpg',
                                      fit: BoxFit.cover,

                                      // alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 55,
                                  width: 135,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'After Life',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 13,
                                            height: 1.3,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'BY GURUJI',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 10,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                            height: 1,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                  height: 150,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 20,
                                            child: Image.asset(
                                              'images/razorpay.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                color: Colors.blue,
                                                width: 120,
                                                height: 50,
                                                child: Text('Payment Amount')),
                                            Container(
                                              alignment: Alignment.center,
                                              color: Colors.blue,
                                              width: 120,
                                              height: 50,
                                              child: Text('₹ 12,000'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              barrierColor: Colors.transparent,
                              isDismissible: true,
                              shape: RoundedRectangleBorder(
                                // borderRadius: BorderRadius.only(topLeft: 1),
                                side: BorderSide(
                                  width: 0.1,
                                  color: Colors.black,
                                ),
                              ),
                              enableDrag: true,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 180,
                                    width: 135,
                                    child: Image.asset(
                                      'images/books/book10.jpg',
                                      fit: BoxFit.cover,

                                      // alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 55,
                                  width: 135,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Love Your Life',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 13,
                                            height: 1.3,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'BY GURUJI',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 10,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                            height: 1,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                  height: 150,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 20,
                                            child: Image.asset(
                                              'images/razorpay.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                color: Colors.blue,
                                                width: 120,
                                                height: 50,
                                                child: Text('Payment Amount')),
                                            Container(
                                              alignment: Alignment.center,
                                              color: Colors.blue,
                                              width: 120,
                                              height: 50,
                                              child: Text('₹ 12,000'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              barrierColor: Colors.transparent,
                              isDismissible: true,
                              shape: RoundedRectangleBorder(
                                // borderRadius: BorderRadius.only(topLeft: 1),
                                side: BorderSide(
                                  width: 0.1,
                                  color: Colors.black,
                                ),
                              ),
                              enableDrag: true,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 180,
                                    width: 135,
                                    child: Image.asset(
                                      'images/books/book11.jpg',
                                      fit: BoxFit.cover,

                                      // alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 55,
                                  width: 135,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'The 7 Key To Success',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 13,
                                            height: 1.3,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'BY GURUJI',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 10,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                            height: 1,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                  height: 150,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 20,
                                            child: Image.asset(
                                              'images/razorpay.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                color: Colors.blue,
                                                width: 120,
                                                height: 50,
                                                child: Text('Payment Amount')),
                                            Container(
                                              alignment: Alignment.center,
                                              color: Colors.blue,
                                              width: 120,
                                              height: 50,
                                              child: Text('₹ 12,000'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              barrierColor: Colors.transparent,
                              isDismissible: true,
                              shape: RoundedRectangleBorder(
                                // borderRadius: BorderRadius.only(topLeft: 1),
                                side: BorderSide(
                                  width: 0.1,
                                  color: Colors.black,
                                ),
                              ),
                              enableDrag: true,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 180,
                                    width: 135,
                                    child: Image.asset(
                                      'images/books/book12.jpg',
                                      fit: BoxFit.cover,

                                      // alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 55,
                                  width: 135,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'The Art Success',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 13,
                                            height: 1.3,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'BY GURUJI',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 10,
                                            fontFamily: "Ubuntu",
                                            letterSpacing: 0.4,
                                            height: 1,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}

class IconSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientIcon(
      Icons.book,
      22.0,
      LinearGradient(
        colors: <Color>[
          Colors.lightBlueAccent,
          Colors.blueAccent,
          Colors.blue,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }
}

// Get.bottomSheet(
// Container(
// height: 150,
// color: Colors.white,
// child: Column(
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Container(
// height: 20,
// child: Image.asset(
// 'images/razorpay.png',
// fit: BoxFit.cover,
// ),
// ),
// ],
// ),
// Container(
// margin: EdgeInsets.symmetric(horizontal: 15),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Container(
// alignment: Alignment.center,
// color: Colors.blue,
// width: 120,
// height: 50,
// child: Text('Payment Amount')),
// Container(
// alignment: Alignment.center,
// color: Colors.blue,
// width: 120,
// height: 50,
// child: Text('₹ 12,000'),
// )
// ],
// ),
// ),
// ],
// )),
// barrierColor: Colors.transparent,
// isDismissible: true,
// shape: RoundedRectangleBorder(
// // borderRadius: BorderRadius.only(topLeft: 1),
// side: BorderSide(
// width: 0.1,
// color: Colors.black,
// ),
// ),
// enableDrag: true,
// );
