import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final title = 'Grid List';

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          flexibleSpace: Image.asset(
            'images/background_image.png',
            fit: BoxFit.cover,
          ),
          title: Text(
            'Books',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: "Ubuntu"),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 2,
              // Generate 100 widgets that display their index in the List.
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: AssetImage('images/rose.jpg'),
                              fit: BoxFit.cover,
                              alignment: Alignment.center),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Rose',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13,
                            fontFamily: "Ubuntu"),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: AssetImage('images/nature1.jpg'),
                              fit: BoxFit.cover,
                              alignment: Alignment.center),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Little Tree',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13,
                            fontFamily: "Ubuntu"),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: AssetImage('images/nature2.jpg'),
                              fit: BoxFit.cover,
                              alignment: Alignment.center),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Nature',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13,
                            fontFamily: "Ubuntu"),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: AssetImage('images/nature3.jpg'),
                              fit: BoxFit.cover,
                              alignment: Alignment.center),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Life',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13,
                            fontFamily: "Ubuntu"),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: AssetImage('images/nature4.png'),
                              fit: BoxFit.cover,
                              alignment: Alignment.center),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Climate',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13,
                            fontFamily: "Ubuntu"),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: AssetImage('images/nature5.jpg'),
                              fit: BoxFit.cover,
                              alignment: Alignment.center),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Location',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13,
                            fontFamily: "Ubuntu"),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: AssetImage('images/nature6.png'),
                              fit: BoxFit.cover,
                              alignment: Alignment.center),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Growth',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13,
                            fontFamily: "Ubuntu"),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: AssetImage('images/rose.jpg'),
                              fit: BoxFit.cover,
                              alignment: Alignment.center),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Rose',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13,
                            fontFamily: "Ubuntu"),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
