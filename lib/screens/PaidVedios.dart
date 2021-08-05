import 'package:astrology_app/screens/NativeVedioScreen.dart';
import 'package:astrology_app/screens/vedioPlayer/youtubeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaidVedios extends StatelessWidget {
  // FreeVideos({Key? key}) : super(key: key);
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.indigo,
              pinned: true,
              floating: false,
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.asset(
                  'images/unlockedvideo.jpg',
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
                        StreamBuilder<QuerySnapshot>(
                          stream:
                              _firestore.collection('PaidVedios').snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("Loading...");
                            } else {
                              final messages = snapshot.data!.docs;
                              List<PaidVediosDb> vedioList = [];

                              for (var message in messages) {
                                final vedioImage = message['vedioImage'];
                                final vedioUrl = message['vedioUrl'];
                                final title = message['title'];

                                final freeVedios = PaidVediosDb(
                                  vedioImage: vedioImage,
                                  vediolink: vedioUrl,
                                  vedioTitle: title,
                                  onpress: () {
                                    Get.to(
                                        () =>
                                            NativeVedioUrl(vedioUrl: vedioUrl),
                                        transition: Transition.topLevel,
                                        // fullscreenDialog: true,
                                        curve: Curves.easeInToLinear,
                                        duration: Duration(milliseconds: 600));
                                  },
                                );
                                // Text('$messageText from $messageSender');
                                vedioList.add(freeVedios);
                              }
                              return Column(
                                children: vedioList,
                              );
                            }
                          },
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

class PaidVediosDb extends StatelessWidget {
  String vedioImage;
  String vediolink;
  String vedioTitle;
  VoidCallback onpress;

  PaidVediosDb(
      {required this.onpress,
      required this.vedioImage,
      required this.vediolink,
      required this.vedioTitle});
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image(
                image: NetworkImage('$vedioImage'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 200,
              child: Text(
                vedioTitle,
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
      ),
    );
  }
}
