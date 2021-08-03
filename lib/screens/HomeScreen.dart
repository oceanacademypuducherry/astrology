import 'package:astrology_app/screens/ArticleDescription.dart';
import 'package:astrology_app/screens/QueryScreen.dart';
import 'package:astrology_app/screens/SeeAllArticle.dart';
import 'package:astrology_app/screens/loginscreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            expandedHeight: 220,
            // automaticallyImplyLeading: true,
            // toolbarHeight: 100,
            // stretch: true,
            // pinned: true,
            collapsedHeight: 180,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage("images/background_image.png"),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: double.infinity,
              child: Container(
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.white, width: 4),
                        borderRadius: BorderRadius.circular(45),
                        boxShadow: [
                          new BoxShadow(
                              color: Colors.white70,
                              blurRadius: 40.0,
                              spreadRadius: 4),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 28,
                        // backgroundColor: Colors.blue,
                        child: CircleAvatar(
                          radius: 34,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person_rounded,
                            color: Colors.grey[300],
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Text(
                        'GOOD MORNING, IJASS',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Ubuntu"),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Text(
                        'Free Article are available explore for the Day',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: "Ubuntu"),
                      ),
                    ),
                  ],
                ),
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
                                  "Article",
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
                          // Row(
                          //   children: [
                          //     StreamBuilder<QuerySnapshot>(
                          //       stream: _firestore
                          //           .collection('articles')
                          //           .snapshots(),
                          //       // ignore: missing_return
                          //       builder: (context, snapshot) {
                          //         if (!snapshot.hasData) {
                          //           return Text("Loading...");
                          //         } else {
                          //           print('db enter');
                          //           final messages = snapshot.data;
                          //           print(messages);
                          //           List<ArticleFromDb> articleList = [];
                          //
                          //           for (var message in messages!.docs) {
                          //             final articleImage =
                          //                 message['articleImage'];
                          //
                          //             final articleName =
                          //                 message['articleName'];
                          //             final articleDescription =
                          //                 message['content'];
                          //             final articles = ArticleFromDb(
                          //               articleDescription: articleDescription,
                          //               articleImage: articleImage,
                          //               articleName: articleName,
                          //               onpress: () {},
                          //             );
                          //             articleList.add(articles);
                          //           }
                          //           return Row(children: articleList);
                          //         }
                          //       },
                          //     ),
                          //   ],
                          // ),
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
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 310,
                      child: Column(
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
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/anyquestion.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      color: Colors.grey[200],
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Article",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu'),
                                ),
                                TextButton(
                                    onPressed: () {},
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
                          CarouselSlider(
                            items: [
                              GestureDetector(
                                onTap: () {
                                  print('ontap');
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: AssetImage("images/article1.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('ontap');
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: AssetImage("images/article2.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('ontap');
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: AssetImage("images/article3.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('ontap');
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: AssetImage("images/article4.jpeg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('ontap');
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: AssetImage("images/article5.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            //Slider Container properties
                            options: CarouselOptions(
                              height: 310.0,
                              enlargeCenterPage: true,
                              autoPlay: false,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              viewportFraction: 0.8,
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
