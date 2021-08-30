// ignore_for_file: file_names

import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/screens/AppointmentTimeScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocity_x/velocity_x.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final firestore = FirebaseFirestore.instance;
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _launchURL(String link) async {
    String url = '$link';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List dbList = [];
  List freeTime = [];

  getFree(String date) async {
    print("---------------------------");
    await for (var snapshot in firestore
        .collection('availableTime')
        .snapshots(includeMetadataChanges: true)) {
      print(snapshot.docs);
      print('sowthri');
      for (var message in snapshot.docs) {
        String getTime = message['time'];
        freeTime.add(DateTime.parse('${date} ${getTime}'));
        // freeTime.add(message['time']);
      }
      print(freeTime);
      print('&&&&&&&&&&&&&&&&&');
      await _forumContreller.setFreeTime(freeTime);
      Get.to(
          () => AppointmentTimeScreen(
                focusedDate: formattedTime.toString(),
                dbList: dbList,
                freeList: freeTime,
              ),
          // transition: Transition.cupertinoDialog,
          fullscreenDialog: true,
          curve: Curves.easeInToLinear,
          duration: Duration(milliseconds: 600));

      print('++++++++++++++++++');

      print("-----------end available----------------");
    }
  }

  void getAvailable() async {
    print("---------------------------");
    await for (var snapshot in firestore
        .collection('availableTime')
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        print('going');
        String getTime = message['time'];
      }

      print('++++++++++++++++++');

      print("---------------------------");
    }
  }

  void getItem() async {
    print("---------------------------");
    await for (var snapshot in firestore
        .collection('booking')
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        print('going');
        dynamic getTime = message['time'];
        int yearFormat;
        int monthFormat;
        int dayFormat;
        int hourFormat;
        int minuteFormat;
        String dayTime;

        var year = DateFormat('yyyy');
        var month = DateFormat('MM');
        var day = DateFormat('dd');
        var hour = DateFormat('hh');
        var minute = DateFormat('mm');
        var daytime = DateFormat('a');

        yearFormat = int.parse(year.format(getTime.toDate()));
        monthFormat = int.parse(month.format(getTime.toDate()));
        dayFormat = int.parse(day.format(getTime.toDate()));
        hourFormat = int.parse(hour.format(getTime.toDate()));
        minuteFormat = int.parse(minute.format(getTime.toDate()));
        dayTime = daytime.format(getTime.toDate());
        print(dayTime);
        //
        var dt = DateTime(yearFormat, monthFormat, dayFormat,
            dayTime == 'AM' ? hourFormat : hourFormat + 12, minuteFormat);
        dbList.add(dt);
        print(dt);
      }

      print('++++++++++++++++++');

      print("---------------------------");
    }
  }

  String? value;
  String? formattedTime;
  int count = 0;
  List timing = [];

  @override
  Widget build(BuildContext context) {
    getItem();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Schedule Appointment",
          style: TextStyle(
            color: Colors.blue.withOpacity(0.9),
            fontSize: 18,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              rowHeight: 40,
              daysOfWeekHeight: 40,

              ///Mon Tue Wed Thu Fri
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: Colors.blue.withOpacity(0.9),
                  fontSize: 15,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.normal,
                ),

                ///Sat Sun
                weekendStyle: TextStyle(
                  color: Colors.blue.withOpacity(0.9),
                  fontSize: 15,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.normal,
                ),
              ),

              ///Header 2 weeks Style
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(
                  color: Colors.blue.withOpacity(0.9),
                  fontSize: 15,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                ),
                formatButtonShowsNext: false,
                formatButtonVisible: false,
                titleCentered: true,

                // formatButtonTextStyle: TextStyle(
                //   color: Colors.black54.withOpacity(0.9),
                //   fontSize: 15,
                //   fontFamily: 'Ubuntu',
                //   fontWeight: FontWeight.normal,
                // ),
              ),
              headerVisible: true,
              focusedDay: selectedDay,
              firstDay: DateTime.now(),
              lastDay: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day + 60),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },
              // Day Changed
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
                formattedTime = DateFormat("yyyy-MM-dd").format(focusedDay);
                print('+++++++++++++++Start+++++++++++++++');
                // getFree(formattedTime.toString());
                Get.to(() => AppointmentTimeScreen(
                      focusedDate: formattedTime.toString(),
                      dbList: dbList,
                      freeList: freeTime,
                    ));
              },

              //To style the Calendar
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  // borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            Container(
              color: Colors.grey.shade100,
              padding: EdgeInsets.only(bottom: 70),
              // color: Colors.blue,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Booking Details",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'Ubuntu'),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: firestore.collection('booking').snapshots(),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else {
                        final bookings = snapshot.data!.docs;
                        return Container(
                          child: CarouselSlider(
                            items: [
                              for (var book in bookings)
                                if (book['phoneNumber'] ==
                                    _forumContreller.userSession.value)
                                  GestureDetector(
                                    onTap: book['time']
                                                    .toDate()
                                                    .difference(DateTime.now())
                                                    .inSeconds <
                                                600 &&
                                            book['time']
                                                    .toDate()
                                                    .difference(DateTime.now())
                                                    .inSeconds >
                                                -60 * 60
                                        ? () {
                                            _launchURL(book['userZoomLink']);
                                          }
                                        : book['time']
                                                    .toDate()
                                                    .difference(DateTime.now())
                                                    .inSeconds >
                                                0
                                            ? () => {
                                                  VxToast.show(context,
                                                      msg:
                                                          'Zoom link will be updated before 10 minutes of your booked time',
                                                      showTime: 5),
                                                }
                                            : () => {
                                                  VxToast.show(context,
                                                      msg:
                                                          'this meeting was completed')
                                                },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.blue.shade700,
                                              Colors.blue.shade600,
                                              Colors.blue.shade500,
                                              Colors.blue.shade200,
                                            ]),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade500,
                                            offset: Offset(0.4, 0.4),
                                            blurRadius: 5,
                                            spreadRadius: 0.8,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Text(
                                                  "Your Booking is Confirmed ",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      fontFamily: 'Ubuntu'),
                                                ),
                                              ),
                                              Icon(
                                                Icons.celebration,
                                                color: Colors.blue.shade900,
                                              )
                                            ],
                                          ),
                                          book['time']
                                                          .toDate()
                                                          .difference(
                                                              DateTime.now())
                                                          .inSeconds <
                                                      600 &&
                                                  book['time']
                                                          .toDate()
                                                          .difference(
                                                              DateTime.now())
                                                          .inSeconds >
                                                      -60 * 60
                                              ? Icon(
                                                  FontAwesomeIcons.video,
                                                  color: Colors.white,
                                                  size: 40,
                                                )
                                              : book['time']
                                                          .toDate()
                                                          .difference(
                                                              DateTime.now())
                                                          .inSeconds >
                                                      0
                                                  ? Icon(
                                                      FontAwesomeIcons.walking,
                                                      color: Colors.white,
                                                      size: 40,
                                                    )
                                                  : Icon(
                                                      Icons.done_all_outlined,
                                                      color: Colors.white,
                                                      size: 40,
                                                    ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.video_call_outlined,
                                                color: Colors.white,
                                                size: 28,
                                              ),
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: RichText(
                                                    text: TextSpan(
                                                        text:
                                                            " ${DateFormat.yMMMMd().format(book['time'].toDate()).toString()}",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Ubuntu'),
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                " ${DateFormat.jm().format(book['time'].toDate()).toString()}",
                                                          ),
                                                        ]),
                                                  )),
                                            ],
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 5),
                                              child: RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                    text: "Note : ",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 10,
                                                        fontFamily: 'Ubuntu'),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            " Zoom link will be updated before 10 minutes",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 10,
                                                            fontFamily:
                                                                'Ubuntu'),
                                                      ),
                                                    ]),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                            ],
                            //Slider Container properties
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              // height: 300.0,
                              enlargeCenterPage: false,
                              autoPlay: false,
                              aspectRatio: 35 / 15,
                              autoPlayCurve: Curves.fastOutSlowIn,

                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              viewportFraction: 0.8,
                            ),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
