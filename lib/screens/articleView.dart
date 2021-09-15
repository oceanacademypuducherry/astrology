import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/controller/article_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ArticleView extends StatefulWidget {
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('path/to/header_background.png'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Flutter Step-by-Step",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  ArticleController _articleController = Get.find<ArticleController>();
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('View Article')),
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Get.back();
            },
          ),
        ),
        endDrawer: SafeArea(
          child: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.blue,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Text(
                      "Related Articles",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: 'Ubuntu'),
                    )),
                  ),
                  for (var article in _forumContreller.articleData.value)
                    Column(
                      children: [
                        ListTile(
                          onTap: () {
                            print(article['postId']);
                            _articleController.setPostId(article['postId']);
                            Get.back();
                          },
                          title: Text(
                            article['articleName'],
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.grey,
                              // height: 2,

                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              fontFamily: 'Ubuntu',
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: Container(
                            width: 50,
                            height: 50,
                            child: CachedNetworkImage(
                              imageUrl: article['articleImage'],
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ).marginSymmetric(vertical: 5),
                        Divider(
                          color: Colors.grey,
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        body: Obx(() => Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var i in _articleController.allBlog.value)
                      if (i['id'] == _articleController.postId.value.toString())
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                i['title'],
                                style: TextStyle(
                                    fontFamily: 'st_137',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.blueAccent),
                              ),
                            ).marginSymmetric(horizontal: 10),
                            Html(
                              data: i['content'].toString().trim(),
                              style: {
                                'p': Style(
                                  textAlign: TextAlign.start,
                                  margin: EdgeInsets.only(bottom: 20.0),
                                  fontFamily: 'st_137',
                                )
                              },
                            ).marginSymmetric(horizontal: 10),
                          ],
                        )
                  ],
                ),
              ),
            )));
  }
}
