import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(body: Query())));
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Query extends StatefulWidget {
  @override
  _QueryState createState() => _QueryState();
}

class _QueryState extends State<Query> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('queries').snapshots(),
          // ignore: missing_return
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading...");
            } else {
              final messages = snapshot.data!.docs;
              List<Dbquery> courseDetails = [];
              String messageContent;
              //List<String> subjects = [];
              for (var message in messages) {
                List<Widget> questionList = [];
                List<Widget> answerList = [];

                for (var i = 0; i < message["query"].length; i++) {
                  if ((questionList == null)) {
                    return Container(
                      height: 700,
                      width: 500,
                      color: Colors.pinkAccent,
                    );
                  } else {
                    messageContent = message["query"][i]['answer'];
                    questionList.add(
                      Container(
                        color: Colors.grey[100],
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                messageContent,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }

                print('%%%%%%%%%%%%%%%');
                for (var i = 0; i < message["query"].length; i++) {
                  if ((questionList == null)) {
                    return Container(
                      height: 700,
                      width: 500,
                      color: Colors.pinkAccent,
                    );
                  } else {
                    messageContent = message["query"][i]['question'];
                    questionList.add(
                      Container(
                        color: Colors.grey[100],
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                messageContent,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }

                final messageDubble = Dbquery(

                    // chapterWidget: chapterWidget,
                    );
                courseDetails.add(messageDubble);
              }
              return Column(
                children: courseDetails,
              );
            }
          },
        ),
      ],
    );
  }
}

class Dbquery extends StatelessWidget {
  List<Widget> questionWidget = [];
  List<Widget> answerWidget = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: questionWidget,
    );
  }
}
