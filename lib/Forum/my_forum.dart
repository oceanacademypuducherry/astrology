import 'package:astrology_app/Forum/forumController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MyForums extends StatelessWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Questions'),
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('forums')
                .where('auth',
                    isEqualTo: _forumContreller.userSession.value.isNotEmpty
                        ? _forumContreller.sessionUserInfo.value['email']
                        : null)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('loading...');
              } else {
                for (var i in snapshot.data!.docs) {
                  print(i.data());
                  print('jjjjjjjjjjjjjjjj');
                }

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final forumData = snapshot.data!.docs[index];
                      // return Text(forumData['likes'].toString());

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: ListTile(
                          tileColor: Colors.grey[600],
                          title: Text(
                            forumData['question'],
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.white,
                            onPressed: () {
                              print(forumData.id);
                              VxDialog.showConfirmation(context,
                                  title: 'Are you sure?',
                                  content:
                                      'Once deleted, you will not recover this question',
                                  confirm: 'Delete It',
                                  confirmBgColor: Colors.redAccent,
                                  cancel: 'No', onConfirmPress: () {
                                _firestore
                                    .collection('forums')
                                    .doc(forumData.id)
                                    .delete();
                              });
                            },
                          ),
                        ),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}
