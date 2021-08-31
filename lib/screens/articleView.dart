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
  ArticleController _articleController = Get.find<ArticleController>();
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        endDrawer: Drawer(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
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
                      ),
                      Divider()
                    ],
                  ),
              ],
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
                            ),
                            Html(
                              data: i['content'].toString().trim(),
                              style: {
                                'p': Style(
                                  textAlign: TextAlign.start,
                                  margin: EdgeInsets.only(bottom: 20.0),
                                  fontFamily: 'st_137',
                                )
                              },
                            ),
                          ],
                        )
                  ],
                ),
              ),
            )));
  }
}
