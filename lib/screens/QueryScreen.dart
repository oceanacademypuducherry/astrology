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
  void initState() {
    // TODO: implement initState
    super.initState();
    user_id();
  }

  var docId;

  final queryController = TextEditingController();
  var query;

  List userNumber = [];
  var previous;
  bool? isCheck;

  void user_id() async {
    print("---------------------------");
    await for (var snapshot in _firestore
        .collection('query')
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        var getNumber = message.data()['number'];
        userNumber.add(getNumber);
      }
      print(userNumber);
      print('000000000000000000000000000000000000');
      isCheck = userNumber.contains('+91 1234567890');
      if (isCheck == true) {
        for (var message in snapshot.docs) {
          print('1111111111111111');
          var getNumber = message.data()['queries'];
          previous = getNumber;
          print('22222222222222222222');
          print(previous);
          getDocId('+91 1234567890');
        }
      }
    }

    print("------------finishhhhh---------------");
  }

  void getDocId(String user) async {
    print("------------getDocId---------------");
    print(user);
    await for (var snapshot in _firestore
        .collection('query')
        .where("number", isEqualTo: user)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        docId = message.id;
        print('${docId} testingggggggggggggggggggggggggggggggggggg');
      }
    }

    print("---------------------------");
  }

  Widget _buildQuery() {
    return TextFormField(
      // ignore: deprecated_member_use
      // autovalidate: validation,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
        LengthLimitingTextInputFormatter(40),
      ],
      // autovalidate: _autoValidate,
      validator: (value) {
        if (value!.isEmpty) {
          return 'name is required';
        } else if (value.length < 3) {
          return 'character should be morethan 2';
        }
        return null;
      },
      decoration: const InputDecoration(
          // prefixIcon: Icon(Icons.drive_file_rename_outline),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
          border: InputBorder.none,
          hintText: 'Enter Your Name',
          hintStyle: TextStyle(fontSize: 12)
          // labelText: 'Name',
          ),
      controller: queryController,
      onChanged: (value) {
        query = value;
      },
    );
  }

  List logic = [];
  Map ques = {};

  @override
  Widget build(BuildContext context) {
    print('inside $previous');
    print('docid $docId');
    var m = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: Colors.grey[100],
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 200,
                  // color: Colors.red,
                  child: _buildQuery(),
                ),
                Container(
                  // color: Colors.pinkAccent,
                  child: ElevatedButton(
                    onPressed: () {
                      print(docId);
                      if (isCheck == true) {
                        previous.add(
                            {'question': queryController.text, 'answer': ''});
                        _firestore.collection('query').doc(docId).update({
                          'number': '+91 1234567890',
                          'queries': FieldValue.arrayUnion([
                            {'question': queryController.text, 'answer': ''}
                          ])
                        });
                      } else {
                        _firestore.collection('query').add({
                          'number': '+91 1234567890',
                          'queries': FieldValue.arrayUnion([
                            {'question': queryController.text, 'answer': ''}
                          ])
                        });
                      }
                    },
                    child: Text('SEND'),
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),
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
                    // height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(15),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.grey,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Joe Smith',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Ubuntu",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '1m ago',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 9,
                                          fontFamily: "Ubuntu",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream:
                                  _firestore.collection('query').snapshots(),
                              // ignore: missing_return
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text("Loading...");
                                } else {
                                  final messages = snapshot.data!.docs;
                                  List<Dbquery> courseDetails = [];
                                  String messageAnswer;
                                  String messageQuestion;
                                  //List<String> subjects = [];
                                  for (var message in messages) {
                                    List<Widget> questionList = [];
                                    List<Widget> answerList = [];

                                    for (var i = 0;
                                        i < message["queries"].length;
                                        i++) {
                                      if (message['queries'].length != null) {
                                        messageQuestion =
                                            message["queries"][i]['question'];
                                        messageAnswer =
                                            message["queries"][i]['answer'];
                                        print('++++++++++++++++++');
                                        print(messageAnswer);
                                        print(messageQuestion);
                                        answerList.add(
                                          Container(
                                            color: Colors.pinkAccent,
                                            padding: EdgeInsets.all(5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(15),
                                                  padding: EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft: Radius.zero,
                                                      topRight:
                                                          Radius.circular(15),
                                                      bottomLeft:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    messageQuestion,
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontSize: 15,
                                                      fontFamily: "Ubuntu",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                        answerList.add(
                                          Container(
                                            color: Colors.red,
                                            padding: EdgeInsets.all(5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(15),
                                                  padding: EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft: Radius.zero,
                                                      topRight:
                                                          Radius.circular(15),
                                                      bottomLeft:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    messageAnswer,
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontSize: 15,
                                                      fontFamily: "Ubuntu",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                    print(answerList);

                                    print('%%%%%%%%%%%%%%%');

                                    final messageDubble = Dbquery(
                                      questionWidget: questionList,
                                      answerWidget: answerList,

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

class Dbquery extends StatelessWidget {
  List<Widget> questionWidget = [];
  List<Widget> answerWidget = [];
  Dbquery({required this.answerWidget, required this.questionWidget});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('staring'),
        Column(
          children: [
            for (var q in questionWidget) q,
          ],
        ),
        Column(
          children: [
            for (var a in answerWidget) a,
          ],
        ),
      ],
    );
  }
}
