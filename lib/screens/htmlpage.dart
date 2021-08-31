import 'package:astrology_app/Forum/forumController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

ForumContreller _forumContreller = Get.find<ForumContreller>();
Future<GetData> fetchLink(String postId) async {
  print('gggggggggggggggggggggg${postId}');
  final response = await http.get(
    Uri.parse(
        'https://www.googleapis.com/blogger/v3/blogs/1887870844984411174/posts/${postId}?key=AIzaSyCQ9jLjt8Ekd1Eq08LXHnycX8deR-heco0'),
  );

  if (response.statusCode == 200) {
    print(response.statusCode);
    print('************************************');
    Map valueMap = json.decode(response.body);
    print(valueMap);
    _forumContreller.setHtmlContent(valueMap['content']);
    _forumContreller.setHtmlTitle(valueMap['title']);

    return GetData.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    throw Exception('Failed to load data');
  }
}

class GetData {
  final String title;

  GetData({
    required this.title,
  });

  factory GetData.fromJson(Map<String, dynamic> json) {
    return GetData(
      title: json['content'],
    );
  }
}

class HtmlPageArticle extends StatefulWidget {
  String postId;
  String appBarName;
  HtmlPageArticle({required this.postId, required this.appBarName});
  @override
  _HtmlPageArticleState createState() => _HtmlPageArticleState();
}

class _HtmlPageArticleState extends State<HtmlPageArticle> {
  late Future<GetData> futureLink;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    futureLink = fetchLink(widget.postId);
    // const String htmlData = "${_forumContreller.htmlContent.value.toString().trim()}";
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarName),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder<GetData>(
            future: futureLink,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        _forumContreller.htmlTitle.value.toString().trim(),
                        style: TextStyle(
                            fontFamily: 'st_137',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blueAccent),
                      ),
                    ),
                    Html(
                      data:
                          _forumContreller.htmlContent.value.toString().trim(),
                      style: {
                        'p': Style(
                          textAlign: TextAlign.start,
                          margin: EdgeInsets.only(bottom: 20.0),
                          fontFamily: 'st_137',
                        )
                      },
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                print('error${snapshot.error}');
                return Text('error${snapshot.error}');
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
