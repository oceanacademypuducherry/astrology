// ignore: file_names
// ignore_for_file: file_names

import 'package:astrology_app/screens/PdfView.dart';
import 'package:astrology_app/screens/htmlpage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class QueryScreen extends StatefulWidget {
  const QueryScreen({Key? key}) : super(key: key);

  @override
  _QueryScreenState createState() => _QueryScreenState();
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _QueryScreenState extends State<QueryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.asset(
                  'images/faq.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    // color: Colors.grey,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                              stream:
                                  _firestore.collection('queries').snapshots(),
                              // ignore: missing_return
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                } else {
                                  final messages = snapshot.data!.docs;
                                  List<QueryDb> queryDetails = [];

                                  for (var message in messages) {
                                    final queryImage = message['queryImage'];
                                    final question = message['question'];
                                    final answerLink = message['pdfLink'];
                                    final postId = message['postId'];
                                    final queries = QueryDb(
                                      question: question,
                                      image: queryImage,
                                      pdfLink: answerLink,
                                      onpress: () {
                                        Get.to(
                                            () => HtmlPageArticle(
                                                appBarName: 'View Answer',
                                                postId: postId),
                                            transition: Transition.rightToLeft,
                                            curve: Curves.easeInToLinear,
                                            duration:
                                                Duration(milliseconds: 600));
                                      },
                                    );
                                    // Text('$messageText from $messageSender');
                                    queryDetails.add(queries);
                                  }
                                  return Column(
                                    children: queryDetails,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QueryDb extends StatelessWidget {
  String image;
  String question;
  String pdfLink;
  VoidCallback onpress;

  QueryDb(
      {required this.pdfLink,
      required this.onpress,
      required this.image,
      required this.question});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    child: VerticalDivider(
                      width: 4.8,
                      color: Colors.blue,
                      thickness: 5,
                    ),
                  ),
                  Container(
                    height: 120,
                    width: 100,
                    child: CachedNetworkImage(
                      imageUrl: image,
                      placeholder: (context, url) => Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                          height: 50,
                          width: 50,
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 200,
                    child: Text(
                      question,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        fontFamily: 'Ubuntu',
                        height: 1.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
