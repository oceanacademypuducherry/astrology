import 'package:astrology_app/controller/article_controller.dart';
import 'package:astrology_app/screens/ArticleDescription.dart';
import 'package:astrology_app/screens/articleView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:html/dom.dart';

class SeeAllArticle extends StatelessWidget {
  // const SeeAllArticle({Key? key}) : super(key: key);
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ArticleController _articleController = Get.find<ArticleController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: false,
                expandedHeight: 140,
                toolbarHeight: 50,
                pinned: true,
                collapsedHeight: 50,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  centerTitle: true,
                  title: Text(
                    'Articles',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  background: Image.asset(
                    'images/see_all_article.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore.collection('articles').snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            } else {
                              final messages = snapshot.data!.docs;
                              List<SeeAllArticlesDb> seeArticles = [];

                              for (var message in messages) {
                                final articleImage = message['articleImage'];
                                final articleName = message['articleName'];
                                final articleDescription = message['content'];
                                final postId = message['postId'];
                                final articles = SeeAllArticlesDb(
                                  articleImage: articleImage,
                                  articleName: articleName,
                                  description: articleDescription,
                                  onpress: () {
                                    _articleController.setPostId(postId);
                                    Get.to(() => ArticleView(),
                                        transition: Transition.rightToLeft,
                                        curve: Curves.easeInToLinear,
                                        duration: Duration(milliseconds: 400));
                                  },
                                );
                                // Text('$messageText from $messageSender');
                                seeArticles.add(articles);
                              }
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  children: seeArticles,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SeeAllArticlesDb extends StatelessWidget {
  String articleImage;
  String articleName;
  VoidCallback onpress;
  String description;
  SeeAllArticlesDb(
      {required this.articleImage,
      required this.onpress,
      required this.articleName,
      required this.description});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          // height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(
                  2.0,
                  2.0,
                ),
                blurRadius: 20.0,
                spreadRadius: 2.0,
              ), //BoxShadow
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 80,
                child: Column(
                  children: [
                    Container(
                      child: CachedNetworkImage(
                        imageUrl: articleImage,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, error, url) =>
                            Icon(Icons.wifi_off_rounded),
                        fit: BoxFit.cover,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 280,
                    ).marginSymmetric(vertical: 13),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Text(
                        articleName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Ubuntu',
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
