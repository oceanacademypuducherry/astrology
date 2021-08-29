// ignore: file_names
// ignore_for_file: file_names

import 'dart:convert';

import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/screens/BookingDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppointmentTimeScreen extends StatefulWidget {
  String focusedDate;

  List dbList;
  List freeList;
  AppointmentTimeScreen({
    required this.focusedDate,
    required this.dbList,
    required this.freeList,
  });

  @override
  _AppointmentTimeScreenState createState() => _AppointmentTimeScreenState();
}

class _AppointmentTimeScreenState extends State<AppointmentTimeScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DateTime? orderTime;

  List minuteSlot = [];
  bool? isCheck;

  String? value;
  bool isOpen = false;

  Map colorChange = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
    7: false,
    8: false,
    9: false,
  };
  List timing = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  bool _hasBeenPressed = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.dbList);
  }

  ///zoom link
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  createZoomToken(startTime) async {
    final http.Response response = await http.post(
      Uri.parse(
          'https://api.zoom.us/v2/users/brindaspringnet@gmail.com/meetings'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOm51bGwsImlzcyI6IlFFMlNaTGhCUUhLX1BwUDI1dEl6ZnciLCJleHAiOjE2MzA4MjU5NzAsImlhdCI6MTYzMDIyMTE3MH0.Q1m0yG52SMRXBBxQSUp7Njr1gqf9r88dcnR82WwAh8U'
      },
      body: jsonEncode(
        <String, dynamic>{
          "topic": "The title of your zoom meeting",
          "type": 2,
          "start_time": "${startTime}",
          "duration": 45,
          "timezone": "Asia/Calcutta",
          "agenda": "test",
          "recurrence": {
            "type": "1",
            "repeat_interval": "1",
            // "end_date_time": "2021-08-29T01:21:57Z"
            "end_date_time": ""
          }
        },

        //     headers: {
        //       'Authorization':
        //           'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOm51bGwsImlzcyI6IlFFMlNaTGhCUUhLX1BwUDI1dEl6ZnciLCJleHAiOjE2MzAxNjEzNDQsImlhdCI6MTYzMDE1NTk0NH0.S2SIOi9D34YOUUKJ5COyp0Pj0uRsiqSiEzT_ducS7UY'
        //     }
      ),
    );

    if (response.statusCode == 201) {
      print(response.statusCode);
      print('0000000000000000000000000000000000000000000000');
      Map valueMap = json.decode(response.body);
      // print(valueMap);
      _forumContreller.setJoinUrl(valueMap['join_url']);
      _forumContreller.setStartUrl(valueMap['start_url']);

      print("///////////////////////joinurl ${_forumContreller.joinUrl.value}");
      print(
          "///////////////////////starturl ${_forumContreller.startUrl.value}");
      print('0000000000000000000000000000000000000000000000');
    } else {
      print(response.statusCode);
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  ///zoom

  @override
  Widget build(BuildContext context) {
    // getAvailable(widget.focusedDate);
    print(widget.freeList);
    print(
        '@@@@@@@@@@@@@@@@@@@@@@@@@@@${widget.focusedDate}@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    List time_slot = [
      DateTime.parse('${widget.focusedDate} 09:00'),
      DateTime.parse('${widget.focusedDate} 10:00'),
      DateTime.parse('${widget.focusedDate} 11:00'),
      DateTime.parse('${widget.focusedDate} 12:00'),
      DateTime.parse('${widget.focusedDate} 13:00'),
      DateTime.parse('${widget.focusedDate} 14:00'),
      DateTime.parse('${widget.focusedDate} 15:00'),
      DateTime.parse('${widget.focusedDate} 16:00'),
      DateTime.parse('${widget.focusedDate} 17:00'),
      DateTime.parse('${widget.focusedDate} 18:00'),
    ];
    // print(widget.dbList);
    // print(freeTime);

    // minTime(time_slot);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff045de9),
        centerTitle: true,
        title: Text(
          'Select Time',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontFamily: 'Ubuntu',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 20, left: 15, bottom: 20, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      child: Text('checking'),
                      onPressed: () async {
                        print(orderTime);
                        print('SSSSSSSSSSS');
                        await createZoomToken(orderTime);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                            'Selected Date',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Ubuntu',
                              fontSize: 17,
                              color: Colors.blue,
                            ),
                          ),
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                offset: Offset(2, 2),
                                blurRadius: 2),
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(-2, -2),
                                blurRadius: 2),
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                            '${widget.focusedDate}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Ubuntu',
                              fontSize: 17,
                              color: Colors.blue,
                            ),
                          ),
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                offset: Offset(2, 2),
                                blurRadius: 1),
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        Image.asset(
                          'images/morning.png',
                          width: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Morning',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Ubuntu',
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Wrap(
                      spacing: 7,
                      runSpacing: 10,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        for (var i = 0; i < time_slot.length; i++)
                          if (DateFormat.jm().format(time_slot[i]).substring(
                                  DateFormat.jm().format(time_slot[i]).length -
                                      2) ==
                              'AM')
                            GestureDetector(
                              onTap: widget.dbList.contains(time_slot[i])
                                  ? null
                                  : () {
                                      setState(() {
                                        print('$i 000000000000');
                                        colorChange.updateAll((key, value) =>
                                            colorChange[key] = false);
                                        colorChange[i] = true;
                                        isOpen = true;
                                      });
                                      orderTime = time_slot[i];
                                      print(orderTime);
                                    },
                              child: Card(
                                shadowColor: Colors.grey[100],
                                color: widget.dbList.contains(time_slot[i])
                                    ? Colors.black.withOpacity(0.05)
                                    : colorChange[i]
                                        ? Colors.green[100]
                                        : Colors.grey[200],
                                elevation: widget.dbList.contains(time_slot[i])
                                    ? 0
                                    : 13,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${DateFormat.jm().format(time_slot[i])}',
                                        style:
                                            widget.dbList.contains(time_slot[i])
                                                ? TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: 'Ubuntu',
                                                    fontSize: 16,
                                                    color: Colors.pink[200],
                                                  )
                                                : TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: 'Ubuntu',
                                                    fontSize: 16,
                                                    color: Colors.black54,
                                                  ),
                                      ),
                                      SizedBox(height: 2),
                                      widget.dbList.contains(time_slot[i])
                                          ? Text(
                                              'Unavailable',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Ubuntu',
                                                fontSize: 13,
                                                color: Colors.pink[200],
                                              ),
                                            )
                                          : Text(
                                              'Available',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Ubuntu',
                                                fontSize: 13,
                                                color: Colors.black38,
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'images/afternoon.png',
                          width: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'AfterNoon',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Ubuntu',
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      child: Wrap(
                        spacing: 7,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          for (var i = 0; i < time_slot.length; i++)
                            if ((DateFormat.jm().format(time_slot[i]).substring(
                                        DateFormat.jm()
                                                .format(time_slot[i])
                                                .length -
                                            2) ==
                                    'PM') &&
                                time_slot[i].hour > 12 &&
                                time_slot[i].hour < 16)
                              GestureDetector(
                                onTap: widget.dbList.contains(i)
                                    ? null
                                    : () {
                                        setState(() {
                                          print('$i 000000000000');
                                          colorChange.updateAll((key, value) =>
                                              colorChange[key] = false);
                                          colorChange[i] = true;
                                          isOpen = true;
                                        });
                                        orderTime = time_slot[i];
                                        print(orderTime);
                                      },
                                child: Card(
                                  shadowColor: Colors.grey[100],
                                  color: widget.dbList.contains(time_slot[i])
                                      ? Colors.black.withOpacity(0.05)
                                      : colorChange[i]
                                          ? Colors.green[100]
                                          : Colors.grey[200],
                                  elevation:
                                      widget.dbList.contains(time_slot[i])
                                          ? 0
                                          : 13,
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${DateFormat.jm().format(time_slot[i])}',
                                          style: widget.dbList
                                                  .contains(time_slot[i])
                                              ? TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: 'Ubuntu',
                                                  fontSize: 16,
                                                  color: Colors.pink[200],
                                                )
                                              : TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: 'Ubuntu',
                                                  fontSize: 16,
                                                  color: Colors.black54,
                                                ),
                                        ),
                                        SizedBox(height: 2),
                                        widget.dbList.contains(time_slot[i])
                                            ? Text(
                                                'Unavailable',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Ubuntu',
                                                  fontSize: 13,
                                                  color: Colors.pink[200],
                                                ),
                                              )
                                            : Text(
                                                'Available',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Ubuntu',
                                                  fontSize: 13,
                                                  color: Colors.black38,
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'images/night.png',
                          width: 35,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Evenings',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Ubuntu',
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Wrap(
                      spacing: 7,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        for (var i = 0; i < time_slot.length; i++)
                          if ((DateFormat.jm().format(time_slot[i]).substring(
                                      DateFormat.jm()
                                              .format(time_slot[i])
                                              .length -
                                          2) ==
                                  'PM') &&
                              time_slot[i].hour > 15 &&
                              time_slot[i].hour < 21)
                            GestureDetector(
                              onTap: widget.dbList.contains(time_slot[i])
                                  ? null
                                  : () {
                                      orderTime = time_slot[i];
                                      print(orderTime);
                                      setState(() {
                                        print('$i 000000000000');
                                        colorChange.updateAll((key, value) =>
                                            colorChange[key] = false);
                                        colorChange[i] = true;
                                        isOpen = true;
                                      });
                                    },
                              child: Card(
                                shadowColor: Colors.grey[100],
                                color: widget.dbList.contains(time_slot[i])
                                    ? Colors.black.withOpacity(0.05)
                                    : colorChange[i]
                                        ? Colors.green[100]
                                        : Colors.grey[200],
                                elevation: widget.dbList.contains(time_slot[i])
                                    ? 0
                                    : 13,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${DateFormat.jm().format(time_slot[i])}',
                                        style:
                                            widget.dbList.contains(time_slot[i])
                                                ? TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: 'Ubuntu',
                                                    fontSize: 16,
                                                    color: Colors.pink[200],
                                                  )
                                                : TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: 'Ubuntu',
                                                    fontSize: 16,
                                                    color: Colors.black54,
                                                  ),
                                      ),
                                      SizedBox(height: 2),
                                      widget.dbList.contains(time_slot[i])
                                          ? Text(
                                              'Unavailable',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Ubuntu',
                                                fontSize: 13,
                                                color: Colors.pink[200],
                                              ),
                                            )
                                          : Text(
                                              'Available',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Ubuntu',
                                                fontSize: 13,
                                                color: Colors.black38,
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 50,
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Ubuntu',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff045de9),
                      ),
                      onPressed: isOpen
                          ? () async {
                              print(orderTime);
                              print('>>>>>>>>>>>>>>>>>>>>>>>');
                              await createZoomToken(orderTime);

                              setState(() {
                                colorChange.updateAll(
                                    (key, value) => colorChange[key] = false);
                                isOpen = false;
                              });

                              Get.to(() => BookingDetails(),
                                  arguments: orderTime,
                                  transition: Transition.rightToLeft,
                                  curve: Curves.easeInToLinear,
                                  duration: Duration(milliseconds: 600));
                            }
                          : null,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
