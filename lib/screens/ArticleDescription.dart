import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleDescription extends StatelessWidget {
  const ArticleDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                // automaticallyImplyLeading: true,
                toolbarHeight: 70,
                // stretch: true,
                pinned: true,
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
                    'Article Description',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 18,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.8),
                            offset: const Offset(
                              1.0,
                              1.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 0.1,
                          ), //BoxShadow
                        ],
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      // height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Text(
                              'The Article',
                              style: TextStyle(
                                color: Colors.blue.withOpacity(0.9),
                                fontSize: 20,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. software like Aldus PageMaker including versions of Lorem Ipsum. software like Aldus PageMaker including versions of Lorem Ipsum. software like Aldus PageMaker including versions of Lorem Ipsum.",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                height: 1.5,
                                fontSize: 15,
                                letterSpacing: 0.1,
                                wordSpacing: 1,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
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
