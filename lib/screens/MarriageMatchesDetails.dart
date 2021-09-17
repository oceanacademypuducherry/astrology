// ignore_for_file: file_names

import 'package:astrology_app/Forum/forumController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ForumContreller _forumContreller = Get.find<ForumContreller>();

class MarriageMatchesDetails extends StatefulWidget {
  String boyName;
  String girlName;

  String natchathiramBoyValue;
  String natchathiramGirlValue;

  String boyRasi;
  String girlRasi;

  MarriageMatchesDetails({
    required this.girlRasi,
    required this.natchathiramBoyValue,
    required this.natchathiramGirlValue,
    required this.girlName,
    required this.boyRasi,
    required this.boyName,
  });

  @override
  _MarriageMatchesDetailsState createState() => _MarriageMatchesDetailsState();
}

class _MarriageMatchesDetailsState extends State<MarriageMatchesDetails> {
  // late Future<GetDataForPorutham> futureLink;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCount();
    getmukiyaPorutham();
    print(';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;${_forumContreller.jadhagamDetail.value}');
  }

  int count = 0;
  int mukiyaPoruthamCount = 0;
  getCount() {
    for (var i in _forumContreller.jadhagamDetail.value.entries) {
      if (i.value == 'YES') {
        count++;
      }
    }
    print(count);
  }

  getmukiyaPorutham() {
    for (var i in _forumContreller.jadhagamDetail.value.entries) {
      print("${i.key} ////////////i.keys");
      print("${i.value} ////////////i.keys");
      if (i.key == "ஸ்திரி தீர்க்கம் பொருத்தம்" ||
          i.key == "யோனி பொருத்தம்" ||
          i.key == "வசியம் பொருத்தம்" ||
          i.key == "ரஜ்ஜி  பொருத்தம்" ||
          i.key == "ராசி பொருத்தம்") {
        print("${i.key} ☻ i.key");
        if (i.value == "YES") {
          mukiyaPoruthamCount++;
          print("${i.value} ☻ i.value");
        }
      }
    }
    print("${mukiyaPoruthamCount} ///////mukiyaPorutham");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                // color: Colors.grey,
                child: Image.asset(
                  "images/c.png",
                  width: 30,
                  height: 30,
                ),
              ),

              ///First content astrologer details
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
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
                          image: DecorationImage(image: AssetImage("images/admin.jpg"), fit: BoxFit.cover),
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
                            "Harichandiran",
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
                    "திருமணப் பொருத்தங்கள்",
                    style: TextStyle(
                      color: Colors.blue.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Ubuntu',
                    ),
                  ).marginOnly(bottom: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "மணமகன்",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        Text(
                          "மணமகள்",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
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
                          "${widget.boyName.toString().substring(0, 1).toUpperCase()}${widget.boyName.toString().substring(1, widget.boyName.length).toLowerCase()}",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        Text(
                          "${widget.girlName.toString().substring(0, 1).toUpperCase()}${widget.girlName.toString().substring(1, widget.girlName.length).toLowerCase()}",
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
                          "${widget.boyRasi}",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        Text(
                          "${widget.girlRasi}",
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
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // height: 750,
                    // width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Colors.grey[200],
                          alignment: Alignment.center,
                          child: Text(
                            "பொருத்தங்கள்",
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ).marginSymmetric(vertical: 15),
                        for (var porutham in _forumContreller.jadhagamDetail.value.entries)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${porutham.key}",
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54,
                                    ),
                                  ).marginOnly(left: 30),
                                  porutham.value == "YES"
                                      ? Icon(
                                          Icons.done_all_outlined,
                                          color: Colors.green,
                                        ).marginOnly(right: 30)
                                      : Icon(
                                          Icons.clear,
                                          color: Colors.red,
                                        ).marginOnly(right: 30)
                                ],
                              ).marginSymmetric(vertical: 10),
                              Divider(
                                thickness: 0.9,
                                color: Colors.grey,
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              ///Result of marriage matches
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                    Text(
                      "(${count}/10)",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.9,
                color: Colors.grey,
              ),

              ///last content
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "மேலே கொடுக்கப்பட்ட 5 முக்கிய பொருத்தத்தில் $mukiyaPoruthamCount பொருத்தம் உள்ளது",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: _forumContreller.jadhagamDetail.value["ராசி பொருத்தம்"] == 'YES' &&
                        _forumContreller.jadhagamDetail.value["ஸ்திரி தீர்க்கம் பொருத்தம்"] == 'YES' &&
                        _forumContreller.jadhagamDetail.value["யோனி பொருத்தம்"] == 'YES' &&
                        _forumContreller.jadhagamDetail.value["ரஜ்ஜி  பொருத்தம்"] == 'YES' &&
                        _forumContreller.jadhagamDetail.value["வசியம் பொருத்தம்"] == 'YES'
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
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "* மேலும் தகவல்களுக்கு உங்கள் குடும்ப ஜோதிடரை அணுகவும் *",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "* மேலே கொடுக்கப்பட்ட பத்துப் பொருத்த தகவல்கள் நட்சத்திர அடிப்படையில் மட்டுமே கொடுக்க ப் பட்டுள்ளது.இதில் செவ்வாய் தோஷம், கால சர்ப்ப தோஷம், போன்றவை கணக்கில் எடுத்துக் கொள்ள வில்லை.இதில் மணமக்களின் ஆயுள், புத்திரம், தாம்பத்யம், வருமானம் போன்றவைகள் தெரியாது.மேற்கண்ட தகவலின் படி திருமணம் செய்வது அவரவர் விருப்பத்திற்கு ட் பட்டது.அனுகூலப்பொருத்தம் பார்ப்பதே நல்லது. *",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 8,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
