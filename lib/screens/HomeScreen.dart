import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/main.dart';
import 'package:astrology_app/screens/ArticleDescription.dart';
import 'package:astrology_app/screens/FreeVideos.dart';
import 'package:astrology_app/screens/PaidVedios.dart';
import 'package:astrology_app/screens/QueryScreen.dart';
import 'package:astrology_app/screens/SeeAllArticle.dart';
import 'package:astrology_app/screens/SubscribeVideo.dart';
import 'package:astrology_app/screens/loginscreen.dart';
import 'package:astrology_app/screens/vedioPlayer/Network_vedio_player.dart';
import 'package:astrology_app/screens/vedioPlayer/youtubeScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ForumContreller _forumContreller = Get.find<ForumContreller>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            expandedHeight: 200,
            toolbarHeight: 50,
            // pinned: true,
            collapsedHeight: 60,
            flexibleSpace: FlexibleSpaceBar(
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
                    //Article
                    Container(
                      color: Colors.blue[50],
                      padding: EdgeInsets.only(bottom: 10),
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();

                                      pref.clear();

                                      Get.to(
                                        () => Login(),
                                        transition: Transition.rightToLeft,
                                        curve: Curves.easeInToLinear,
                                        duration: Duration(milliseconds: 600),
                                      );
                                      print('logout');
                                    },
                                    child: Text('log out')),
                                Text(
                                  "Article Collection",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu'),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.to(
                                        () => SeeAllArticle(),
                                        transition: Transition.rightToLeft,
                                        curve: Curves.easeInToLinear,
                                        duration: Duration(milliseconds: 600),
                                      );
                                    },
                                    child: Text(
                                      'See All',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 15,
                                          fontFamily: 'Ubuntu'),
                                    ))
                              ],
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream:
                                _firestore.collection('articles').snapshots(),
                            // ignore: missing_return
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("Loading...");
                              } else {
                                final articles = snapshot.data!.docs;
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: CarouselSlider(
                                    items: [
                                      for (var article in articles)
                                        GestureDetector(
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 10,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.2),
                                                                blurRadius: 5)
                                                          ]),
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      height: 50,
                                                      width: 300,
                                                      child: Image.network(
                                                        article['articleImage'],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      article['articleName'],
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.blue),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Get.to(
                                                  () => ArticleDescription(
                                                        description:
                                                            article['content'],
                                                        articleTitle: article[
                                                            'articleName'],
                                                      ),
                                                  transition:
                                                      Transition.rightToLeft,
                                                  curve: Curves.easeInToLinear,
                                                  duration: Duration(
                                                      milliseconds: 400));
                                            }),
                                    ],
                                    //Slider Container properties
                                    options: CarouselOptions(
                                      enableInfiniteScroll: false,
                                      // height: 300.0,
                                      enlargeCenterPage: true,
                                      autoPlay: true,
                                      aspectRatio: 30 / 15,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 800),
                                      viewportFraction: 0.7,
                                    ),
                                  ),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    //Query
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      height: 300,
                      // color: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Query",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: 'Ubuntu'),
                              ),
                              TextButton(
                                  onPressed: () async {
                                    Get.to(QueryScreen());
                                  },
                                  child: Text(
                                    'See All',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15,
                                        fontFamily: 'Ubuntu'),
                                  ))
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(QueryScreen());
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/askquery.jpg"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Video
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.only(bottom: 10),
                      color: Colors.grey[200],
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Videos Collection",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu'),
                                ),
                              ],
                            ),
                          ),
                          CarouselSlider(
                            items: [
                              GestureDetector(
                                onTap: () {
                                  print('ontap');

                                  _forumContreller
                                          .sessionUserInfo.value['subscribe']
                                      ? Get.to(() => PaidVedios(),
                                          // transition: Transition.cupertinoDialog,
                                          fullscreenDialog: true,
                                          curve: Curves.easeInToLinear,
                                          duration: Duration(milliseconds: 600))
                                      : Get.to(() => SubscribeVideoScreen(),
                                          // transition: Transition.cupertinoDialog,
                                          fullscreenDialog: true,
                                          curve: Curves.easeInToLinear,
                                          duration:
                                              Duration(milliseconds: 600));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image:
                                          AssetImage("images/premiumlock.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('ontap');
                                  Get.to(() => FreeVideos(),
                                      transition: Transition.topLevel,
                                      // fullscreenDialog: true,
                                      curve: Curves.easeInToLinear,
                                      duration: Duration(milliseconds: 600));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "images/freevideo.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            //Slider Container properties
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              // height: 230.0,
                              enlargeCenterPage: true,
                              autoPlay: false,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              viewportFraction: 0.7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              childCount: 1, // 1000 list items
            ),
          ),
        ],
      )),
    );
  }
}

class ArticleFromDb extends StatelessWidget {
  List<Widget> articleImage = [];

  ArticleFromDb({required this.articleImage});
  @override
  Widget build(BuildContext context) {
    // print(articleName);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff045de9),
            Colors.grey.shade300,
          ],
        ),
      ),
      height: 400,
      width: 350,
      child: CarouselSlider(
        items: articleImage,
        options: CarouselOptions(
          height: 280.0,
          // enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          pageSnapping: false,
          autoPlay: false,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: false,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.7,
        ),
      ),
    );
  }
}

// GestureDetector(
// child: Container(
// margin: EdgeInsets.all(10.0),
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius.circular(8.0),
// image: DecorationImage(
// image: NetworkImage(images),
// fit: BoxFit.cover,
// ),
// ),
// ),
// onTap: () {
// Get.to(
// () => ArticleDescription(
// description:
// articleDescription,
// ),
// transition:
// Transition.rightToLeft,
// curve: Curves.easeInToLinear,
// duration: Duration(
// milliseconds: 600));
// });
