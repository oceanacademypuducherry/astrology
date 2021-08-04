import 'package:astrology_app/screens/ArticleDescription.dart';
import 'package:astrology_app/screens/FreeVideos.dart';
import 'package:astrology_app/screens/QueryScreen.dart';
import 'package:astrology_app/screens/SeeAllArticle.dart';
import 'package:astrology_app/screens/SubscribeVideo.dart';
import 'package:astrology_app/screens/loginscreen.dart';
import 'package:astrology_app/screens/vedioPlayer/Network_vedio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      height: 600,
                      color: Colors.grey[200],
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: _firestore
                                    .collection('articles')
                                    .snapshots(),
                                // ignore: missing_return
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text("Loading...");
                                  } else {
                                    final messages = snapshot.data!.docs;
                                    // ignore: non_constant_identifier_names
                                    List<GestureDetector> DBUpcoming = [];
                                    for (var message in messages) {
                                      final images = message['articleImage'];
                                      final articleName =
                                          message['articleName'];
                                      final articleDescription =
                                          message['content'];

                                      GestureDetector messageContent =
                                          GestureDetector(
                                              child: Container(
                                                margin: EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  image: DecorationImage(
                                                    image: NetworkImage(images),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                print('jaya');
                                                Get.to(
                                                    () => ArticleDescription(
                                                          description:
                                                              articleDescription,
                                                        ),
                                                    transition:
                                                        Transition.rightToLeft,
                                                    curve:
                                                        Curves.easeInToLinear,
                                                    duration: Duration(
                                                        milliseconds: 600));
                                              });

                                      DBUpcoming.add(messageContent);
                                    }
                                    return Row(
                                      children: [
                                        ArticleFromDb(
                                          articleImage: DBUpcoming,
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                                    // SharedPreferences prefs =
                                    //     await SharedPreferences.getInstance();
                                    // await prefs.clear();
                                    // Get.to(() => Login(),
                                    //     transition: Transition.rightToLeft,
                                    //     curve: Curves.easeInToLinear,
                                    //     duration: Duration(milliseconds: 600));
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
                                  Get.to(() => PortraitLandscapePlayerPage(),
                                      // transition: Transition.cupertinoDialog,
                                      fullscreenDialog: true,
                                      curve: Curves.easeInToLinear,
                                      duration: Duration(milliseconds: 600));
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
                              height: 230.0,
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
      color: Colors.grey[100],
      height: 400,
      width: 350,
      child: CarouselSlider(
        items: articleImage,
        options: CarouselOptions(
          height: 280.0,
          enlargeCenterPage: true,
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
