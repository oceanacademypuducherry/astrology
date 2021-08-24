import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/atentication/login.dart';
import 'package:astrology_app/screens/ArticleDescription.dart';
import 'package:astrology_app/screens/BooksScreen.dart';
import 'package:astrology_app/screens/FreeVideos.dart';
import 'package:astrology_app/screens/MarriageMatches.dart';
import 'package:astrology_app/screens/PaidVedios.dart';
import 'package:astrology_app/screens/QueryScreen.dart';
import 'package:astrology_app/screens/SeeAllArticle.dart';
import 'package:astrology_app/screens/SubscribeVideo.dart';
import 'package:astrology_app/widgets/notification_api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ForumContreller _forumContreller = Get.find<ForumContreller>();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var androidInitialize =
    //     new AndroidInitializationSettings("@mipmap/ic_launcher_foreground");
    // var initialzationSetting =
    //     new InitializationSettings(android: androidInitialize);
    // localNotification = new FlutterLocalNotificationsPlugin();
    // localNotification.initialize(initialzationSetting,
    //     onSelectNotification: notificationSelected);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    setSessionDatas();

    print('==============================');
  }

  // Future _showNotification() async {
  //   var androidDetails = new AndroidNotificationDetails(
  //       "channelId", "channelName", "you booked",
  //       importance: Importance.max);
  //
  //   var generalNotificationDetails =
  //       new NotificationDetails(android: androidDetails);
  //   await localNotification.show(
  //       0, 'Hi User', 'body of the notification', generalNotificationDetails);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            expandedHeight: 170,
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
                    // TextButton(
                    //     onPressed: () async {
                    //       SharedPreferences pref =
                    //           await SharedPreferences.getInstance();
                    //
                    //       pref.clear();
                    //
                    //       Get.to(
                    //         () => Login(),
                    //         transition: Transition.rightToLeft,
                    //         curve: Curves.easeInToLinear,
                    //         duration: Duration(milliseconds: 600),
                    //       );
                    //       print('logout');
                    //     },
                    //     child: Text('log out')),
                    // TextButton(
                    //   child: Text('notification'),
                    //   onPressed: _showNotification,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 4,
                                                              horizontal: 4),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.1),
                                                                blurRadius: 5)
                                                          ]),
                                                      // margin: EdgeInsets.symmetric(horizontal: 10),
                                                      child: Image.network(
                                                        article['articleImage'],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      // margin: EdgeInsets.symmetric(horizontal: 10),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4),
                                                      width: double.infinity,

                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.1),
                                                                blurRadius: 10)
                                                          ]),
                                                      child: Text(
                                                        article['articleName']
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          height: 1.3,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                          fontFamily: 'Ubuntu',
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
                                              Get.to(
                                                  () => ArticleDescription(
                                                        articleFile:
                                                            article['link'],
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
                                child: Stack(
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(
                                        "images/thumbnail_.png",
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
                                            "images/thumbnail_2.png",
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
                );
              },
              childCount: 1, // 1000 list items
            ),
          ),
        ],
      )),
    );
  }

  // Future notificationSelected(String? payload) async {
  //   Get.to(
  //     () => BooksScreen(),
  //     transition: Transition.rightToLeft,
  //     curve: Curves.easeInToLinear,
  //     duration: Duration(milliseconds: 600),
  //   );
  // }
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
