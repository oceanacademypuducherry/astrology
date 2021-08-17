import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<GetDataForPorutham> fetchLink(String boyNatchathiram,
    String girlNatchathiram, String boyPada, String girlPada) async {
  final response = await http.get(
    Uri.parse(
        'https://api.prokerala.com/v2/astrology/thirumana-porutham?girl_nakshatra=2&girl_nakshatra_pada=3&boy_nakshatra=5&boy_nakshatra_pada=1'),
    // Send authorization headers to the backend.

    headers: {
      // Authorization:
      HttpHeaders.authorizationHeader:
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI3YTdhN2Y2NS1mZGQ1LTQ0OTktOWIwZi01YWZiMTc4Mjk1ZmYiLCJqdGkiOiIwMTBlZTQ3MGVlZDRlYTA0ZmYwYjQ4ODU0OWQzMmIwYzg0ZWZhNjY2YjI2NjY1OWMzYjE2MDdmODA1NDNiNTgyNTAxNWZlNjg0MGZkOWQ3OCIsImlhdCI6MTYyOTEyNjQxMCwibmJmIjoxNjI5MTI2NDEwLCJleHAiOjE2MjkxMzAwMTAsInN1YiI6ImRlZjk2Yjc0LWEwMWQtNDk2NS1hYjhjLTQ2N2MxZTU4MGJhMiIsInNjb3BlcyI6W10sImNyZWRpdHNfcmVtYWluaW5nIjo0MjI5LCJyYXRlX2xpbWl0cyI6W3sicmF0ZSI6NSwiaW50ZXJ2YWwiOjYwfV19.jaQn5HbfRfMkBAzVaTu2fBaf7-zBJezsTcmceW-vrctbBO8M5rlKJPuh9ngeAg6IOIewcqpAv2Y1d7iZIax-Q3Bag0hURm-tNm4gavGOfE1F4I4H3TdUJoSrgoLiQGdP_An4sWfrXJAFz_nrdt1hXwTjn7QtWD3OyqWG_S6HbpXvuAoVC_3rEvYk7yb7JnlRAAXOfQcBCCMQaqQ313IZtIyj4hR7pHSzEiELD6QpzzBvnZQZNHr1i6eIP66hH-oo267olleW3JpDxxV-9mX8dC3UJl9gd84ewEj7o-gF4IcoQW4QLcjm4SIDfyxr0L89IGIbnCqu5H871xylOxZ5hQ',
    },
  );

  if (response.statusCode == 200) {
    print(response.statusCode);
    print('************************************');
    return GetDataForPorutham.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    throw Exception('Failed to load data');
  }
}

class GetDataForPorutham {
  List title = [];

  GetDataForPorutham({
    required this.title,
  });

  factory GetDataForPorutham.fromJson(Map<String, dynamic> json) {
    return GetDataForPorutham(
      title: json['data']['matches'] as List,
    );
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
  var count = 0;
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
          child: Column(
            children: [
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
                          print('++++++++++++++++++');
                          print(snapshot.data!.title[1]['name']);

                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.title.length,
                            itemBuilder: (context, index) {
                              count = snapshot.data!.title[index]
                                  .where((e) => e['has_porutham'] == true)
                                  .length;
                              return Card(
                                child: ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data!.title[index]['name']),
                                      snapshot.data!.title[index]
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
                    Text(
                      "(${count.toString()}/11)",
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
                child: Text(
                  "Wish You Happy Marriage Life",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
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
                  "** நாம் மேலே காண்பது ஞானபானு பாம்பன் சுவாமிகள் இயற்றிய துவிதநாக பந்தம் ஆகும். இதை நம்மில் பலர் பார்த்திருக்கலாம். துவிதம் என்பதன் பொருள் இரண்டு ஆகும் **",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
