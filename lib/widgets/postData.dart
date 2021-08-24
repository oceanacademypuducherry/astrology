import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum() async {
  final http.Response response = await http.post(
    Uri.parse('https://api.prokerala.com/token'),
    headers: <String, String>{
      //'Content-Type': 'application/json',
    },
    body: {
      'client_id': '7a7a7f65-fdd5-4499-9b0f-5afb178295ff',
      'client_secret': 'oGTDRcX1sXNCSC0KovUMeWru4cTcY15YS63KVbAH',
      'grant_type': 'client_credentials',
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print('0000000000000000000000000000000000000000000000');
    print(response.statusCode);
    Map valueMap = json.decode(response.body);
    print(valueMap.runtimeType);
    print(valueMap['access_token']);
    //Map test = Map(response.body.toString());
    // for (var i in response.bodyBytes) {}
    print('0000000000000000000000000000000000000000000000');
    return Album.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;

  Album({required this.id});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
    );
  }
}

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  _PostState createState() {
    return _PostState();
  }
}

class _PostState extends State<Post> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum = createAlbum();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: buildFutureBuilder(),
        ),
      ),
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.id.toString());
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
