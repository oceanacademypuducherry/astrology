import 'package:astrology_app/screens/ArticleDescription.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeeAllArticle extends StatelessWidget {
  // const SeeAllArticle({Key? key}) : super(key: key);
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
                expandedHeight: 150,
                // automaticallyImplyLeading: true,
                toolbarHeight: 50,
                // stretch: true,
                pinned: true,
                collapsedHeight: 50,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'See all Article',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  background: Image.asset(
                    'images/background_image.png',
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
                                final articles = SeeAllArticlesDb(
                                  articleImage: articleImage,
                                  articleName: articleName,
                                  description: articleDescription,
                                  onpress: () {
                                    Get.to(
                                        () => ArticleDescription(
                                              articleTitle: articleName,
                                              description: articleDescription,
                                            ),
                                        transition: Transition.rightToLeft,
                                        curve: Curves.easeInToLinear,
                                        duration: Duration(milliseconds: 600));
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
      {required this.articleImage, required this.onpress, required this.articleName, required this.description});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: const Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ), //BoxShadow
          ],
          color: Colors.black45,
        ),
        child: Image.network(
          articleImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

//flexible space => sliver

// Container(
// decoration: BoxDecoration(
// color: Colors.blue,
// image: DecorationImage(
// image: AssetImage("images/background_image.png"),
// fit: BoxFit.cover,
// ),
// ),
// width: double.infinity,
// height: double.infinity,
// child: Center(
// child: Text(
// 'See all Article',
// style: TextStyle(
// color: Colors.white.withOpacity(0.9),
// fontSize: 22,
// fontFamily: 'Ubuntu',
// fontWeight: FontWeight.w600,
// ),
// ),
// ),
// ),
