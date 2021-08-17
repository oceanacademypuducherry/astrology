import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<GetData> fetchLink(int boyNatchathiram, int girlNatchathiram,
    int boyPada, int girlPada) async {
  final response = await http.get(
    Uri.parse(
        'https://api.prokerala.com/v2/astrology/thirumana-porutham?girl_nakshatra=5&girl_nakshatra_pada=2&boy_nakshatra=7&boy_nakshatra_pada=4'),
    // Send authorization headers to the backend.

    headers: {
      // Authorization:
      HttpHeaders.authorizationHeader:
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI3YTdhN2Y2NS1mZGQ1LTQ0OTktOWIwZi01YWZiMTc4Mjk1ZmYiLCJqdGkiOiJkZTAzNzMwNTZmMWIyMzYzZWQzYjQ0NTAyOTIwNDQ1MTk1MmZiMjI3YzAwYTI1MWI5ODRkYzY1ZjY1NTNhNmEwNGZhODI0ZDk0ODI3NWM3MSIsImlhdCI6MTYyODk0Mjc1MCwibmJmIjoxNjI4OTQyNzUwLCJleHAiOjE2Mjg5NDYzNTAsInN1YiI6ImRlZjk2Yjc0LWEwMWQtNDk2NS1hYjhjLTQ2N2MxZTU4MGJhMiIsInNjb3BlcyI6W10sImNyZWRpdHNfcmVtYWluaW5nIjo0ODc5LCJyYXRlX2xpbWl0cyI6W3sicmF0ZSI6NSwiaW50ZXJ2YWwiOjYwfV19.9B4LrP9SPBWpcwExjGR8VFOz-pqvlH-3kbJzmYgZcuNlPRTQlm6h31O1YR94vXbK0_0HOQC2HctDqGXewVbaErJZ1jpg_2BnKcFBcI55deYpGBM7H3NL_uPyOMtmAvDMdxEWtR5kfTdRaZlIu_C-umUo0KuHAgIR5pz-GILJf-3Ks6eNQx0Sn3JtPS3y_diEauF2x_DkGi0xY-Icu6yNbiIN4GebYmmcDy4TUmFF5v8vAx0t_X-DAmLV1hW8eQlphi8vCtFsLldZuuUShUEXqF3aU5CTph0cGs512Z9I1YtVORucTqk4Lj6OXqYUMhsBvHxDnZ4E2ns5JxK68UK28g',
    },
  );

  if (response.statusCode == 200) {
    print(response.statusCode);
    print('************************************');
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
      title: json['status'],
    );
  }
}

class Testing extends StatefulWidget {
  int boyNatchathiram;
  int girlNatchathiram;
  int boyPada;
  int girlPada;

  Testing(
      {required this.boyNatchathiram,
      required this.boyPada,
      required this.girlNatchathiram,
      required this.girlPada});
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  late Future<GetData> futureLink;

  @override
  void initState() {
    super.initState();
    futureLink = fetchLink(widget.boyNatchathiram, widget.girlNatchathiram,
        widget.boyPada, widget.girlPada);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
