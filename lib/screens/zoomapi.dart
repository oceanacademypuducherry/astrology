import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future createToken() async {
  final http.Response response = await http.post(
    Uri.parse(
        'https://api.zoom.us/v2/users/brindaspringnet@gmail.com/meetings'),
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
    Map valueMap = json.decode(response.body);
    print(valueMap);
    // _forumContreller.setMatchingToken(valueMap['access_token']);
    // print(
    //     "///////////////////////token${_forumContreller.matchingToken.value}");
    print('0000000000000000000000000000000000000000000000');
  } else {
    print(response.statusCode);
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class ZoomApi extends StatefulWidget {
  @override
  _ZoomApiState createState() => _ZoomApiState();
}

class _ZoomApiState extends State<ZoomApi> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
