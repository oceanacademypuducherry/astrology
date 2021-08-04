import 'package:astrology_app/screens/BooksDescription.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

Widget? BottomSheet(String imageLink, String description, String bookName,
    String pdfLink, String type) {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 30,
      ),
      width: double.infinity,
      height: 170,
      color: Colors.white,
      child: Row(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 120,
                  width: 100,
                  child: Image.network(
                    imageLink,
                    fit: BoxFit.cover,
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
                        bookName,
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
                        type,
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
                    Get.to(BooksDescription(
                      description: description,
                      bookImage: imageLink,
                      bookType: type,
                      bookName: bookName,
                      pdfLink: pdfLink,
                    ));
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
                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore.collection('books').snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("Loading...");
                            } else {
                              final messages = snapshot.data!.docs;
                              List<BooksDb> Books = [];

                              for (var message in messages) {
                                final booksLink = message['bookLink'];
                                final bookType = message['type'];
                                final bookName = message['bookName'];
                                final bookDescription = message['description'];
                                final pdfLink = message['link'];
                                print(bookName);
                                print(pdfLink);
                                final items = BooksDb(
                                  bookImage: booksLink,
                                  bookName: bookName,
                                  bookType: bookType,
                                  description: bookDescription,
                                  pdfLink: pdfLink,

                                  // collegeLogoImage: logoImage,
                                );
                                Books.add(items);
                              }
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 70.0,
                                  runSpacing: 30,
                                  children: Books,
                                ),
                              );
                            }
                          },
                        ),
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

class BooksDb extends StatelessWidget {
  String bookImage;
  String bookName;
  String bookType;
  String description;
  String pdfLink;
  BooksDb(
      {required this.bookImage,
      required this.bookName,
      required this.description,
      required this.bookType,
      required this.pdfLink});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          BottomSheet(bookImage, description, bookName, pdfLink, bookType);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 180,
                      width: 135,
                      child: Image.network(
                        bookImage,
                        fit: BoxFit.fill,

                        // alignment: Alignment.center,
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    padding: EdgeInsets.all(5.0),
                    height: 23,
                    width: 40,
                    child: bookType == 'free'
                        ? Text(
                            'FREE',
                            style: TextStyle(color: Colors.white),
                          )
                        : Text(
                            'PAID',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ],
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
                        bookName,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
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
