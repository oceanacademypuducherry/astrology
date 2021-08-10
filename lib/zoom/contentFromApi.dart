import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<GetData> fetchLink() async {
  final response = await http.get(Uri.parse('http://192.168.0.21:5000'));

  if (response.statusCode == 200) {
    print(response.statusCode);
    print('************************************');
    return GetData.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    print('errorrjnhkjxhbgkjzxgbnhkdfjnhkgjd');
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
      title: json['agenda'],
    );
  }
}

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  late Future<GetData> futureLink;

  @override
  void initState() {
    super.initState();
    futureLink = fetchLink();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<GetData>(
            future: futureLink,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                print('error${snapshot.error}');
                return Text('error${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
