import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

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
                            Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: 10, right: 10),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          child: Image(
                                            image:
                                                AssetImage('images/rose.jpg'),
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
                                            "Lorem Ipsum is simply dummy text of the printing and "
                                            "Lorem Ipsum has been the industry's standard"
                                            " specimen book ?",
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
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          child: Image(
                                            image:
                                                AssetImage('images/rose.jpg'),
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
                                            "Lorem Ipsum is simply dummy text of the printing and "
                                            "Lorem Ipsum has been the industry's standard"
                                            " specimen book ?",
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
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          child: Image(
                                            image:
                                                AssetImage('images/rose.jpg'),
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
                                            "Lorem Ipsum is simply dummy text of the printing and "
                                            "Lorem Ipsum has been the industry's standard"
                                            " specimen book ?",
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
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          child: Image(
                                            image:
                                                AssetImage('images/rose.jpg'),
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
                                            "Lorem Ipsum is simply dummy text of the printing and "
                                            "Lorem Ipsum has been the industry's standard"
                                            " specimen book ?",
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
