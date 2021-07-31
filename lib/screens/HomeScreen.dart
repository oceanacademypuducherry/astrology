import 'package:astrology_app/screens/SeeAllArticle.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            expandedHeight: 250,
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
                      height: 420,
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
                                  Get.to(SeeAllArticle());
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
                              height: 320.0,
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
