import 'dart:io';
import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/controller/article_controller.dart';
import 'package:astrology_app/screens/FreeVideos.dart';
import 'package:astrology_app/screens/MarriageMatches.dart';
import 'package:astrology_app/screens/PaidVedios.dart';
import 'package:astrology_app/screens/PdfView.dart';
import 'package:astrology_app/screens/QueryScreen.dart';
import 'package:astrology_app/screens/SeeAllArticle.dart';
import 'package:astrology_app/screens/SubscribeVideo.dart';
import 'package:astrology_app/screens/articleView.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:cached_network_image/cached_network_image.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  ArticleController _articleController = Get.find<ArticleController>();

  late FlutterLocalNotificationsPlugin localNotification;

  setSessionDatas() async {
    var userDatas = await _firestore.collection('newusers').get();
    print('${_forumContreller.userSession}gggggggggggggggggggg');
    for (var i in userDatas.docs) {
      print('coming inside for');
      if (i['phoneNumber'] == _forumContreller.userSession.value) {
        print('coming inside');
        print('${i.data}');
        print('${i.id}');
        Get.find<ForumContreller>().setUserInfo(i.data());
        Get.find<ForumContreller>().setUserDocumentId(i.id.toString());
      }
    }
    print('☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻');
    print(_forumContreller.sessionUserInfo.value);
    print(_forumContreller.sessionUserInfo.value);
    print('☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻');
  }

  String urlPDFPath = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    setSessionDatas();

    print('==============================');
  }

  var hour = DateTime.now().hour;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Text(
              "Makarajothi",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Ubuntu'),
            ),
            floating: false,
            expandedHeight: 160,
            toolbarHeight: 40,
            // pinned: true,
            collapsedHeight: 50,
            backwardsCompatibility: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              titlePadding: EdgeInsets.symmetric(vertical: 45),
              title: Obx(() => Text(
                    "${hour < 12 ? "Hi ${_forumContreller.sessionUserInfo['name']}, Good Morning !" : hour < 17 ? "Hi ${_forumContreller.sessionUserInfo['name']}, Good Afternoon !" : "Hi ${_forumContreller.sessionUserInfo['name']}, Good Evening !"}",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      fontFamily: 'Ubuntu',
                    ),
                  )),
              stretchModes: [
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              background: Image.asset(
                'images/background_image.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return KeyboardDismisser(
                  child: Column(
                    children: [
                      // TextButton(
                      //     onPressed: () async {
                      //       Get.to(ArticleView());
                      //       // print('checking');
                      //       // // print(_articleController.allBlog.value);
                      //       // for (var i in _articleController.allBlog.value) {
                      //       //   print(i['kind']);
                      //       //   print(i);
                      //       //   print('%%%%%%%%%%%%(((((((((((((((');
                      //       // }
                      //     },
                      //     child: Text('checking')),
                      // TextButton(
                      //   child: Text('pdf'),
                      //   onPressed: () {
                      //     Get.to(
                      //       () => PdfViewerPage2(),
                      //       transition: Transition.rightToLeft,
                      //       curve: Curves.easeInToLinear,
                      //       duration: Duration(milliseconds: 600),
                      //     );
                      //   },
                      //   // onPressed: () async {
                      //   //   final url =
                      //   //       'https://firebasestorage.googleapis.com/v0/b/astrology-7cec1.appspot.com/o/profile%2FHow%20to%20get%20started%20with%20Drive?alt=media&token=8c551e99-3d93-4960-882b-56f5b91e16db';
                      //   //   final file = await PdfApi.loadNetwork(url);
                      //   //
                      //   //   openPDF(context, file);
                      //   // },
                      // ),

                      ///Article
                      Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                                  return CircularProgressIndicator();
                                } else {
                                  final articles = snapshot.data!.docs;
                                  _forumContreller.setArticleData(articles);
                                  print(
                                      '-----------------------------------------');
                                  print(articles[0]['articleName']);
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
                                                      flex: 4,
                                                      child: Container(
                                                        width: 500,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 4,
                                                                horizontal: 4),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.1),
                                                                  blurRadius: 5)
                                                            ]),
                                                        // margin: EdgeInsets.symmetric(horizontal: 10),
                                                        // child: Image.network(
                                                        //   article[
                                                        //       'articleImage'],
                                                        //   fit: BoxFit.cover,
                                                        // ),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: article[
                                                              'articleImage'],
                                                          placeholder:
                                                              (context, url) =>
                                                                  Center(
                                                            child: Container(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                              height: 50,
                                                              width: 50,
                                                            ),
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        // margin: EdgeInsets.symmetric(horizontal: 10),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 4),
                                                        width: double.infinity,

                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.1),
                                                                  blurRadius:
                                                                      10)
                                                            ]),
                                                        child: Text(
                                                          article['articleName']
                                                              .toUpperCase(),
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            // height: 2,

                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15,
                                                            fontFamily:
                                                                'Ubuntu',
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                _articleController.setPostId(
                                                    article['postId']);
                                                Get.to(() => ArticleView(),
                                                    transition:
                                                        Transition.rightToLeft,
                                                    curve:
                                                        Curves.easeInToLinear,
                                                    duration: Duration(
                                                        milliseconds: 400));
                                              }),
                                      ],
                                      //Slider Container properties
                                      options: CarouselOptions(
                                        enableInfiniteScroll: false,
                                        // height: 300.0,
                                        enlargeCenterPage: true,
                                        // autoPlay: true,
                                        aspectRatio: 17 / 15,
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

                      ///marriage matches
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            MarriageMatches(),
                            transition: Transition.downToUp,
                            duration: Duration(milliseconds: 500),
                            fullscreenDialog: true,
                          );
                        },
                        child: Hero(
                          tag: "animation",
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/marriage.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),

                      ///Query
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: 300,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Query",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        fontFamily: 'Ubuntu'),
                                  ),
                                  // TextButton(
                                  //     onPressed: () async {
                                  //       Get.to(QueryScreen());
                                  //     },
                                  //     child: Text(
                                  //       'See All',
                                  //       style: TextStyle(color: Colors.blue, fontSize: 15, fontFamily: 'Ubuntu'),
                                  //     ))
                                ],
                              ),
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
                                    image: AssetImage("images/questions.jpg"),
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

                      ///Video
                      Container(
                        // padding: EdgeInsets.only(bottom: 10),
                        // color: Colors.blue,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 20),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    print(_forumContreller
                                        .sessionUserInfo.value['subscribe']);
                                    _forumContreller
                                            .sessionUserInfo.value['subscribe']
                                        ? Get.to(() => PaidVedios(),
                                            // transition: Transition.cupertinoDialog,
                                            fullscreenDialog: true,
                                            curve: Curves.easeInToLinear,
                                            duration:
                                                Duration(milliseconds: 600))
                                        : Get.to(() => SubscribeVideoScreen(),
                                            // transition: Transition.cupertinoDialog,
                                            fullscreenDialog: true,
                                            curve: Curves.easeInToLinear,
                                            duration:
                                                Duration(milliseconds: 600));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(
                                          "images/paid video.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                          left: 20,
                                          top: 20,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              child: Icon(
                                                Icons.lock,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          )),
                                    ],
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
                                  child: Stack(
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          // color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "images/freevideo.jpg",
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          left: 10,
                                          top: 25,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              color: Colors.white,
                                              child: Text(
                                                'FREE',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                    fontFamily: 'Ubuntu'),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                              //Slider Container properties
                              options: CarouselOptions(
                                enableInfiniteScroll: false,

                                // height: 230.0,
                                enlargeCenterPage: true,
                                autoPlay: false,
                                aspectRatio: 16 / 8,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                viewportFraction: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///last image
                      Container(
                        height: 210,
                        width: double.infinity,

                        // height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/unlock.png"),
                            fit: BoxFit.fitHeight,
                          ),
                          // borderRadius: BorderRadius.circular(10),
                          // border: Border.all(
                          //   width: 2,
                          //   color: Colors.blue,
                          // ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: 1, // 1000 list items
            ),
          ),
        ],
      )),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
}

class ArticleFromDb extends StatelessWidget {
  List<Widget> articleImage = [];

  ArticleFromDb({required this.articleImage});
  @override
  Widget build(BuildContext context) {
    // print(articleName);
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff045de9),
            Colors.grey.shade300,
          ],
        ),
      ),
      height: 500,
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
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}
