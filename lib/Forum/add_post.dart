import 'package:astrology_app/Forum/forumController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddPost extends StatelessWidget {
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  TextEditingController _postController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 250,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: TextField(
                controller: _postController,
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Ask Question")),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () async {
                    if (_postController.text.isNotEmpty &&
                        _postController.text.length > 10) {
                      _firestore.collection('forums').doc().set({
                        'question': _postController.text,
                        'auth': _forumContreller.sessionUserInfo['email'],
                        'likes': 0,
                        'postTime': DateTime.now(),
                        'answers': [],
                        'likesFlag': {}
                      });
                      Get.back();
                    } else {
                      Get.snackbar('Failed Post',
                          'Field wil be grater then 10 character',
                          backgroundColor: Colors.black,
                          colorText: Colors.white);
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
