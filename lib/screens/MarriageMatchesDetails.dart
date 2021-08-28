import 'package:astrology_app/Forum/forumController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

ForumContreller _forumContreller = Get.find<ForumContreller>();
Future<GetDataForPorutham> fetchLink(String boyNatchathiram,
    String girlNatchathiram, String boyPada, String girlPada) async {
  print(_forumContreller.matchingToken.value.toString());
  final response = await http.get(
    Uri.parse(
        'https://api.prokerala.com/v2/astrology/thirumana-porutham?girl_nakshatra=${girlNatchathiram}&girl_nakshatra_pada=${girlPada}&boy_nakshatra=${boyNatchathiram}&boy_nakshatra_pada=${boyPada}'),
    // Send authorization headers to the backend.

    headers: {
      // Authorization:
      HttpHeaders.authorizationHeader:
          'Bearer ${_forumContreller.matchingToken.value.toString().trim()}',
    },
  );

  if (response.statusCode == 200) {
    print(response.statusCode);
    print('************************************');
    Map valueMap = json.decode(response.body);
    print(valueMap);
    _forumContreller.setMaximumPoint(valueMap['data']['obtained_points']);
    return GetDataForPorutham.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    throw Exception('Failed to load data');
  }
}

class GetDataForPorutham {
  List matches = [];
  double maximumPoints;
  double obtainPointrs;

  GetDataForPorutham({
    required this.matches,
    required this.maximumPoints,
    required this.obtainPointrs,
  });

  factory GetDataForPorutham.fromJson(Map<String, dynamic> json) {
    print('^^^^^^^^^^^^^^^^^^^^^^^^^^');
    return GetDataForPorutham(
        matches: json['data']['matches'] as List,
        maximumPoints: json['data']['maximum_points'],
        obtainPointrs: json['data']['obtained_points']);
  }
}

class MarriageMatchesDetails extends StatefulWidget {
  String boyName;
  String girlName;
  String boyNatchathiram;
  String natchathiramBoyValue;
  String natchathiramGirlValue;

  String girlNatchathiram;
  String boyPada;
  String girlPada;

  MarriageMatchesDetails(
      {required this.girlPada,
      required this.natchathiramBoyValue,
      required this.natchathiramGirlValue,
      required this.girlName,
      required this.boyPada,
      required this.boyName,
      required this.girlNatchathiram,
      required this.boyNatchathiram});

  @override
  _MarriageMatchesDetailsState createState() => _MarriageMatchesDetailsState();
}

class _MarriageMatchesDetailsState extends State<MarriageMatchesDetails> {
  late Future<GetDataForPorutham> futureLink;
  var total;
  var score;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureLink = fetchLink(widget.boyNatchathiram, widget.girlNatchathiram,
        widget.boyPada, widget.girlPada);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(children: [
            ///First content astrologer details
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.blue.shade900,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                          ),
                        ],
                        image: DecorationImage(
                            image: AssetImage("images/client.jpg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 35),
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Harichanran",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        Text(
                          "Astrologer",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        Text(
                          "Tamilnadu, India",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        Text(
                          "9876543210",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Divider(
              thickness: 0.2,
              color: Colors.grey,
            ),

            ///second content marriage matches
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Marriage Matches",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.boyName}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      Text(
                        "${widget.girlName}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.natchathiramBoyValue}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      Text(
                        "${widget.natchathiramGirlValue}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.boyPada}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      Text(
                        "${widget.girlPada}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 0.2,
              color: Colors.grey,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 750,
                  // width: double.infinity,
                  child: FutureBuilder<GetDataForPorutham>(
                    future: futureLink,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print('jjjjjjjjjjjjjjjjjjjjjj');
                        total = snapshot.data!.maximumPoints;
                        score = snapshot.data!.obtainPointrs;

                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.matches.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(snapshot.data!.matches[index]['name']),
                                    snapshot.data!.matches[index]
                                            ['has_porutham']
                                        ? Icon(
                                            Icons.done_all_outlined,
                                            color: Colors.green[300],
                                          )
                                        : Icon(
                                            Icons.close_outlined,
                                            color: Colors.red[300],
                                          )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        print('error${snapshot.error}');
                        return Text('error${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),

            ///Result of marriage matches
            Divider(
              thickness: 0.2,
              color: Colors.grey,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  Obx(
                    () => Text(
                      "(${_forumContreller.maximunPoint.value.toString().substring(0, 1)}/12)",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 0.2,
              color: Colors.grey,
            ),

            ///last content
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: score >= 8
                  ? Text(
                      "இருவருக்கும் திருமண பொருத்தம் இருக்கு",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: 'Ubuntu',
                      ),
                    )
                  : Text(
                      "இருவருக்கும் திருமண பொருத்தம் இல்லை",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Text(
                "** திருமணம் என்பது ஒரு ஆண், ஒரு பெண் சேர்ந்து வாழ்ந்து அனைத்து சுக, துக்கங்களைப் பகிர்ந்து கொண்டு வாழ்வதாகும். **",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontFamily: 'Ubuntu',
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
