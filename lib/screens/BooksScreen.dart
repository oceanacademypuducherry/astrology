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
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: AssetImage('images/rose.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
                Text('')
              ]),
        ),
      ),
    );
  }
}
