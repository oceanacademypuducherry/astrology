import 'package:cached_network_image/cached_network_image.dart';

import 'youtubeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreeVideos extends StatelessWidget {
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
                  'images/freevideo.jpg',
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
                          stream: _firestore
                              .collection('youtubeVedios')
                              .snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("Loading...");
                            } else {
                              final messages = snapshot.data!.docs;
                              List<FreeVedioDb> vedioList = [];

                              for (var message in messages) {
                                final vedioImage = message['videoImage'];
                                final vedioUrl = message['videoUrl'];
                                final title = message['title'];
                                final description = message['description'];

                                final freeVedios = FreeVedioDb(
                                  vedioImage: vedioImage,
                                  vediolink: vedioUrl,
                                  vedioTitle: title,
                                  onpress: () {
                                    Get.to(
                                        () => YoutubeScreen(
                                              vedioLink: vedioUrl,
                                              vedioDescription: description,
                                              vedioName: title,
                                            ),
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

class FreeVedioDb extends StatelessWidget {
  String vedioImage;
  String vediolink;
  String vedioTitle;
  VoidCallback onpress;

  FreeVedioDb(
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
              height: 80,
              width: 130,
              child: CachedNetworkImage(
                imageUrl: vedioImage,
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
