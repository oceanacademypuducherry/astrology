import 'package:astrology_app/screens/PdfView.dart';
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
                                  return Text("Loading...");
                                } else {
                                  final messages = snapshot.data!.docs;
                                  List<QueryDb> queryDetails = [];

                                  for (var message in messages) {
                                    final queryImage = message['queryImage'];
                                    final question = message['question'];
                                    final answerLink = message['pdfLink'];
                                    final queries = QueryDb(
                                      question: question,
                                      image: queryImage,
                                      pdfLink: answerLink,
                                      onpress: () {
                                        Get.to(
                                            () => PdfView(
                                                  pdfLink: answerLink,
                                                  appBarName: 'VIEW ANSWER',
                                                ),
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
    var newString = question.substring(0, 150);
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
                    child: Image.network(
                      image,
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
                      newString,
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
