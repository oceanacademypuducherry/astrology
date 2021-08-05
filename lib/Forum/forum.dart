import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/Forum/add_post.dart';
import 'package:astrology_app/Forum/my_forum.dart';

class Forum extends StatefulWidget {
  const Forum({Key? key}) : super(key: key);

  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String timestampToDate(timestamp) {
    var year = int.parse(DateFormat('y').format(timestamp.toDate()));
    var month = int.parse(DateFormat('MM').format(timestamp.toDate()));
    var date = int.parse(DateFormat('d').format(timestamp.toDate()));
    var hours = int.parse(DateFormat('hh').format(timestamp.toDate()));
    var minutes = int.parse(DateFormat('mm').format(timestamp.toDate()));
    var seconds = int.parse(DateFormat('s').format(timestamp.toDate()));

    //datetime converting
    var postTime = DateTime(year, month, date, hours, minutes, seconds);

    int mySeconds = postTime.difference(DateTime.now()).inSeconds;

    mySeconds = ~mySeconds;
    print(mySeconds);
    // return mySeconds.toString();
    if (mySeconds > 0 && mySeconds < 60) {
      return 'Few Second ago';
    } else if (mySeconds > 60 && mySeconds < 3600) {
      return '${mySeconds ~/ 60} Minute ago';
    } else if (mySeconds > 3600 && mySeconds < 86400) {
      return '${mySeconds ~/ (60 * 60)} Hours ago';
    } else if (mySeconds > 86400 && mySeconds < 2073601) {
      return '${mySeconds ~/ (60 * 60 * 24)} Day ago';
    } else {
      var dateformatString = DateFormat('MMMM d y').format(DateTime(
        year,
        month,
        date,
      ));
      return '${dateformatString}';
    }
  }

  likesToggle(forum) async {
    var isLikes = await _firestore.collection('forums').doc(forum.id).get();
    var localLikesList = isLikes['likesFlag'];
    print(localLikesList[_forumContreller.sessionUserInfo.value['email']]);
    if (_forumContreller.userSession.value.isNotEmpty) {
      if (localLikesList[_forumContreller.sessionUserInfo.value['email']] ==
          null) {
        _firestore
            .collection('forums')
            .doc(forum.id)
            .update({'likes': forum['likes'] + 1});
        localLikesList[_forumContreller.sessionUserInfo.value['email']] = true;
        // localLikesList.addAll({
        //   _forumContreller
        //       .sessionUserInfo
        //       .value['email']: true
        // });

        print(localLikesList);

        _firestore
            .collection('forums')
            .doc(forum.id)
            .update({'likesFlag': localLikesList});
      } else if (localLikesList[
          _forumContreller.sessionUserInfo.value['email']]) {
        _firestore
            .collection('forums')
            .doc(forum.id)
            .update({'likes': forum['likes'] - 1});
        localLikesList[_forumContreller.sessionUserInfo.value['email']] = false;
        print(localLikesList);

        _firestore
            .collection('forums')
            .doc(forum.id)
            .update({'likesFlag': localLikesList});
      } else if (!localLikesList[
          _forumContreller.sessionUserInfo.value['email']]) {
        _firestore
            .collection('forums')
            .doc(forum.id)
            .update({'likes': forum['likes'] + 1});
        localLikesList[_forumContreller.sessionUserInfo.value['email']] = true;
        print(localLikesList);

        _firestore
            .collection('forums')
            .doc(forum.id)
            .update({'likesFlag': localLikesList});
      }
    } else {
      Get.snackbar('title', 'message');
    }

    ///TODO likes function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Forum'),
        actions: [
          IconButton(
              onPressed: () {
                if (_forumContreller.userSession.value.isNotEmpty) {
                  Get.to(MyForums());
                } else {
                  Get.snackbar('Failed', 'Log In Please',
                      backgroundColor: Colors.black, colorText: Colors.white);
                }
              },
              icon: Icon(Icons.delete))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: Container(
          height: 65.0,
          width: 65.0,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                if (_forumContreller.userSession.value.isNotEmpty) {
                  Get.bottomSheet(AddPost());
                } else {
                  Get.snackbar('Failed', 'Log In Please',
                      backgroundColor: Colors.black, colorText: Colors.white);
                }
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              // elevation: 5.0,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        elevation: 20,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 40,
          padding: EdgeInsets.all(20),
        ),
      ),
      body: Container(
        // child: TextButton(
        //   onPressed: () {
        //     addData();
        //   },
        //   child: Text('add data'),
        // ),
        child: allForums(),
      ),
    );
  }

  Widget allForums() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('forums').snapshots(),
      builder: (context, forumsSnapshot) {
        if (!forumsSnapshot.hasData) {
          return Text('Loading...');
        } else {
          final forumData = forumsSnapshot.data!.docs;

          return ListView.builder(
            itemCount: forumData.length,
            itemBuilder: (context, index) {
              final forum = forumData[index];
              TextEditingController answerController = TextEditingController();
              TextEditingController answerEditingController =
                  TextEditingController();
              TextEditingController questionController =
                  TextEditingController(text: forum['question']);
              FocusNode questionFieldFocus = FocusNode();

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(color: Colors.grey[50], boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 5)
                ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        margin: EdgeInsets.all(5),
                        color: Colors.white,
                        child: ExpansionTile(
                          onExpansionChanged: (val) {},
                          trailing: _forumContreller
                                      .sessionUserInfo.value['email'] ==
                                  forum['auth']
                              ? GestureDetector(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      color: Colors.blue,
                                      padding: EdgeInsets.all(5),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: 'Edit Your Qusetion',
                                      titleStyle: TextStyle(fontSize: 20),
                                      content: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextField(
                                          autofocus: true,
                                          controller: questionController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          child: Text('Close'),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                        ElevatedButton(
                                          child: Text('Save'),
                                          onPressed: () {
                                            if (_forumContreller
                                                .userSession.value.isNotEmpty) {
                                              _firestore
                                                  .collection('forums')
                                                  .doc(forum.id)
                                                  .update({
                                                'question':
                                                    questionController.text
                                              });
                                              Get.back();
                                            } else {
                                              Get.snackbar(
                                                  'Failed', 'Login First');
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                )
                              : Icon(Icons.keyboard_arrow_down_sharp),
                          title: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    FutureBuilder(
                                      future: _firestore
                                          .collection('newusers')
                                          .get(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot userSnapshot) {
                                        if (!userSnapshot.hasData) {
                                          return Text('loading...');
                                        } else {
                                          var username = 'username';
                                          var userProfile = 'userProfile';

                                          for (var user
                                              in userSnapshot.data!.docs) {
                                            if (forum['auth'] ==
                                                user['email']) {
                                              username = user['name'];
                                              userProfile = user['profile'];
                                            }
                                          }
                                          return Row(
                                            children: [
                                              CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.grey,
                                                  backgroundImage:
                                                      NetworkImage(userProfile)
                                                  // AssetImage(
                                                  //     'images/auth.png'),
                                                  ),
                                              SizedBox(width: 15),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    username,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            Colors.grey[800]),
                                                  ),
                                                  Text(
                                                    timestampToDate(
                                                        forum['postTime']),
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    forum['question'],
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey[800]),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(5),
                                                    color: Color(0xff90C8E8),
                                                    child: Icon(
                                                      forum['likesFlag'][
                                                                  _forumContreller
                                                                          .sessionUserInfo[
                                                                      'email']] ==
                                                              true
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border,
                                                      color: Color(0xff057EC2),
                                                      size: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                likesToggle(forum);
                                              }),
                                          Text(
                                            '${forum['likes']} Likes',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        '${forum['answers'].length} Answers',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width: MediaQuery.of(context).size.width - 80,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      border: Border.all(color: Colors.blue)),
                                  child: TextField(
                                    minLines: 1,
                                    style: TextStyle(fontSize: 18),
                                    keyboardType: TextInputType.multiline,
                                    controller: answerController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Submit Your Answer',
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      border: Border.all(color: Colors.blue)),
                                  child: IconButton(
                                    icon: Icon(Icons.send_rounded),
                                    color: Colors.white,
                                    onPressed: () {
                                      if (answerController.text.isNotEmpty) {
                                        _firestore
                                            .collection('forums')
                                            .doc(forum.id)
                                            .update({
                                          'answers': FieldValue.arrayUnion([
                                            {
                                              'answer': answerController.text,
                                              'email': _forumContreller
                                                  .sessionUserInfo['email'],
                                              'likes': 0,
                                              'answerTime': DateTime.now(),
                                              'likesFlag': {}
                                            }
                                          ])
                                        });
                                        answerController.clear();
                                      } else {
                                        Get.snackbar(
                                            'Exception', 'Field is Empty',
                                            backgroundColor: Colors.black,
                                            colorText: Colors.white);
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                for (var answerIndex = 0;
                                    answerIndex < forum['answers'].length;
                                    answerIndex++)
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FutureBuilder(
                                            future: _firestore
                                                .collection('newusers')
                                                .get(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot userSnapshot) {
                                              if (!userSnapshot.hasData) {
                                                return Text('loading...');
                                              } else {
                                                var userProfile = 'userProfile';
                                                var username = 'username';
                                                var likesIcon = false;

                                                for (var user in userSnapshot
                                                    .data!.docs) {
                                                  if (forum['answers']
                                                              [answerIndex]
                                                          ['email'] ==
                                                      user['email']) {
                                                    try {
                                                      // userProfile =
                                                      //     user['profile'];
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                    username = user['name'];
                                                  }
                                                }
                                                print(forum['answers']
                                                            [answerIndex]
                                                        ['likesFlag']
                                                    .length);

                                                return Row(
                                                  children: [
                                                    CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            Colors.grey,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                userProfile)),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          username,
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: Colors
                                                                  .grey[800]),
                                                        ),
                                                        Text(timestampToDate(
                                                            forum['answers'][
                                                                    answerIndex]
                                                                [
                                                                'answerTime'])),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    color: Color(
                                                                        0xff90C8E8),
                                                                    child: Icon(
                                                                      forum['answers'][answerIndex]['likesFlag'][_forumContreller.sessionUserInfo.value['email']] ==
                                                                              false
                                                                          ? Icons
                                                                              .favorite
                                                                          : Icons
                                                                              .favorite_border,
                                                                      color: Color(
                                                                          0xff057EC2),
                                                                      size: 15,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                final forumAnswerList =
                                                                    forum[
                                                                        'answers'];
                                                                dynamic currentuser = forumAnswerList[
                                                                        answerIndex]
                                                                    [
                                                                    'likesFlag'][_forumContreller
                                                                        .sessionUserInfo
                                                                        .value[
                                                                    'email']];
                                                                if (currentuser ==
                                                                    null) {
                                                                  forumAnswerList[
                                                                          answerIndex]
                                                                      [
                                                                      'likesFlag'][_forumContreller
                                                                          .sessionUserInfo
                                                                          .value[
                                                                      'email']] = false;
                                                                  forumAnswerList[
                                                                          answerIndex]
                                                                      [
                                                                      'likes'] = forumAnswerList[
                                                                              answerIndex]
                                                                          [
                                                                          'likes'] +
                                                                      1;
                                                                }
                                                                if (currentuser ==
                                                                    true) {
                                                                  forumAnswerList[
                                                                          answerIndex]
                                                                      [
                                                                      'likesFlag'][_forumContreller
                                                                          .sessionUserInfo
                                                                          .value[
                                                                      'email']] = false;
                                                                  forumAnswerList[
                                                                          answerIndex]
                                                                      [
                                                                      'likes'] = forumAnswerList[
                                                                              answerIndex]
                                                                          [
                                                                          'likes'] +
                                                                      1;
                                                                } else if (currentuser ==
                                                                    false) {
                                                                  forumAnswerList[
                                                                          answerIndex]
                                                                      [
                                                                      'likesFlag'][_forumContreller
                                                                          .sessionUserInfo
                                                                          .value[
                                                                      'email']] = true;
                                                                  forumAnswerList[
                                                                          answerIndex]
                                                                      [
                                                                      'likes'] = forumAnswerList[
                                                                              answerIndex]
                                                                          [
                                                                          'likes'] -
                                                                      1;
                                                                }

                                                                _firestore
                                                                    .collection(
                                                                        'forums')
                                                                    .doc(forum
                                                                        .id)
                                                                    .update({
                                                                  'answers':
                                                                      forumAnswerList
                                                                });
                                                              },
                                                            ),
                                                            Text(
                                                                '${forum['answers'][answerIndex]['likes'].toString()} Likes'),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              child: Row(
                                                                children: [
                                                                  _forumContreller.sessionUserInfo.value[
                                                                              'email'] ==
                                                                          forum['answers'][answerIndex]
                                                                              [
                                                                              'email']
                                                                      ? GestureDetector(
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(50),
                                                                            child: Container(
                                                                                padding: EdgeInsets.all(8),
                                                                                alignment: Alignment.center,
                                                                                color: Colors.blue,
                                                                                child: Icon(
                                                                                  Icons.edit,
                                                                                  size: 20,
                                                                                  color: Colors.white,
                                                                                )),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            dynamic
                                                                                forumAnswerList =
                                                                                forum['answers'];
                                                                            dynamic
                                                                                currentuser =
                                                                                forumAnswerList[answerIndex]['answer'];
                                                                            answerEditingController.text =
                                                                                currentuser.toString();
                                                                            Get.bottomSheet(
                                                                              Container(
                                                                                // height: 200,
                                                                                padding: EdgeInsets.symmetric(vertical: 20),
                                                                                color: Colors.white,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Container(
                                                                                      padding: EdgeInsets.only(left: 10),
                                                                                      width: MediaQuery.of(context).size.width - 80,
                                                                                      decoration: BoxDecoration(color: Colors.grey[100], border: Border.all(color: Colors.blue)),
                                                                                      child: TextField(
                                                                                        minLines: 1,
                                                                                        style: TextStyle(fontSize: 18),
                                                                                        keyboardType: TextInputType.multiline,
                                                                                        controller: answerEditingController,
                                                                                        decoration: InputDecoration(
                                                                                          border: InputBorder.none,
                                                                                          hintText: 'Submit Your Answer',
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      decoration: BoxDecoration(color: Colors.blue, border: Border.all(color: Colors.blue)),
                                                                                      child: IconButton(
                                                                                        icon: Icon(Icons.send_rounded),
                                                                                        color: Colors.white,
                                                                                        onPressed: () {
                                                                                          forumAnswerList[answerIndex]['answer'] = answerEditingController.text;
                                                                                          _firestore.collection('forums').doc(forum.id).update({
                                                                                            'answers': forumAnswerList
                                                                                          });
                                                                                          Get.back();
                                                                                        },
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        )
                                                                      : SizedBox(),

                                                                  /// answer deleteing
                                                                  _forumContreller.sessionUserInfo.value[
                                                                              'email'] ==
                                                                          forum['answers'][answerIndex]
                                                                              [
                                                                              'email']
                                                                      ? Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(50),
                                                                              child: Container(
                                                                                padding: EdgeInsets.all(8),
                                                                                color: Colors.redAccent,
                                                                                child: Icon(
                                                                                  Icons.delete,
                                                                                  size: 20,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              dynamic forumAnswerList = forum['answers'];

                                                                              forumAnswerList.removeAt(answerIndex);

                                                                              _firestore.collection('forums').doc(forum.id).update({
                                                                                'answers': forumAnswerList
                                                                              });
                                                                            },
                                                                          ),
                                                                        )
                                                                      : SizedBox(),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }
                                            }),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Text(forum['answers']
                                              [answerIndex]['answer']),
                                        )
                                      ],
                                    ),
                                  )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
