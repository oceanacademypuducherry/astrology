import 'package:astrology_app/screens/ArticleDescription.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeeAllArticle extends StatelessWidget {
  const SeeAllArticle({Key? key}) : super(key: key);

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
                floating: true,
                expandedHeight: 200,
                // automaticallyImplyLeading: true,
                // toolbarHeight: 100,
                // stretch: true,
                pinned: true,
                collapsedHeight: 70,
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
                  child: Center(
                    child: Text(
                      'See all Article',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 22,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(ArticleDescription());
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
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
                            child: Image.asset(
                              "images/article2.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
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
                          child: Image.asset(
                            "images/article5.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 50),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
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
                          child: Image.asset(
                            "images/article5.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 50),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
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
                          child: Image.asset(
                            "images/article5.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 50),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
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
                          child: Image.asset(
                            "images/article5.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 50),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
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
                          child: Image.asset(
                            "images/article5.jpg",
                            fit: BoxFit.cover,
                          ),
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

// GridView.count(
// // Create a grid with 2 columns. If you change the scrollDirection to
// // horizontal, this produces 2 rows.
// crossAxisCount: 1,
// children: [
// Container(
// margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
// height: 30,
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// color: Colors.black45,
// offset: const Offset(
// 5.0,
// 5.0,
// ),
// blurRadius: 10.0,
// spreadRadius: 2.0,
// ), //BoxShadow
// BoxShadow(
// color: Colors.white,
// offset: const Offset(0.0, 0.0),
// blurRadius: 0.0,
// spreadRadius: 0.0,
// ), //BoxShadow
// ],
// color: Colors.black45,
// ),
// child: Image.asset(
// "images/article5.jpg",
// fit: BoxFit.cover,
// ),
// ),
// Container(
// margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
// height: 30,
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// color: Colors.black45,
// offset: const Offset(
// 5.0,
// 5.0,
// ),
// blurRadius: 10.0,
// spreadRadius: 2.0,
// ), //BoxShadow
// BoxShadow(
// color: Colors.white,
// offset: const Offset(0.0, 0.0),
// blurRadius: 0.0,
// spreadRadius: 0.0,
// ), //BoxShadow
// ],
// color: Colors.black45,
// ),
// child: Image.asset(
// "images/article5.jpg",
// fit: BoxFit.cover,
// ),
// ),
// ],
// ),
