import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/screens/AppointmentTimeScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  void getFree(String date) async {
    print("---------------------------");
    await for (var snapshot in firestore
        .collection('availableTime')
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        print('available time');
        String getTime = message['time'];
        print(getTime);
        print('+++++++++++++');
        freeTime.add(DateTime.parse('${date} ${getTime}'));
        print(freeTime);
      }

      print('++++++++++++++++++');

      print("---------------------------");
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none_sharp,
              color: Colors.blue,
            ),
          ),
        ],
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
                  color: Colors.black54.withOpacity(0.9),
                  fontSize: 15,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.normal,
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.black54.withOpacity(0.9),
                  fontSize: 15,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.normal,
                ),
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
                // 2020-01-02 03:04:05.000

                print(focusedDay);
                print(formattedTime);
                print('^^^^^^^^^^^^^^');
                print(dbList);

                getFree(formattedTime.toString());
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
              color: Colors.blue[50],
              padding: EdgeInsets.only(bottom: 10),
              // color: Colors.blue,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Booking Details",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
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
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: CarouselSlider(
                            items: [
                              for (var book in bookings)
                                if (book['phoneNumber'] ==
                                    _forumContreller.userSession.value)
                                  GestureDetector(
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 9,
                                              child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.2),
                                                            blurRadius: 5)
                                                      ]),
                                                  margin: EdgeInsets.all(10),
                                                  height: 50,
                                                  width: 300,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          DateFormat.yMd()
                                                              .format(
                                                                  book['time']
                                                                      .toDate())
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: book['time']
                                                                            .toDate()
                                                                            .difference(DateTime
                                                                                .now())
                                                                            .inSeconds <
                                                                        600 &&
                                                                    book['time']
                                                                            .toDate()
                                                                            .difference(DateTime
                                                                                .now())
                                                                            .inSeconds >
                                                                        -60 * 60
                                                                ? Colors
                                                                    .pinkAccent
                                                                : book['time']
                                                                            .toDate()
                                                                            .difference(DateTime
                                                                                .now())
                                                                            .inSeconds >
                                                                        0
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .green,
                                                          )),
                                                      Text(
                                                        DateFormat.jm()
                                                            .format(book['time']
                                                                .toDate())
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: book['time']
                                                                          .toDate()
                                                                          .difference(DateTime
                                                                              .now())
                                                                          .inSeconds <
                                                                      600 &&
                                                                  book['time']
                                                                          .toDate()
                                                                          .difference(DateTime
                                                                              .now())
                                                                          .inSeconds >
                                                                      -60 * 60
                                                              ? Colors
                                                                  .pinkAccent
                                                              : book['time']
                                                                          .toDate()
                                                                          .difference(DateTime
                                                                              .now())
                                                                          .inSeconds >
                                                                      0
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .green,
                                                        ),
                                                      ),
                                                      book['time']
                                                                      .toDate()
                                                                      .difference(
                                                                          DateTime
                                                                              .now())
                                                                      .inSeconds <
                                                                  600 &&
                                                              book['time']
                                                                      .toDate()
                                                                      .difference(
                                                                          DateTime
                                                                              .now())
                                                                      .inSeconds >
                                                                  -60 * 60
                                                          ? Text(
                                                              "JOIN NOW",
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                color: book['time'].toDate().difference(DateTime.now()).inSeconds <
                                                                            600 &&
                                                                        book['time'].toDate().difference(DateTime.now()).inSeconds >
                                                                            -60 *
                                                                                60
                                                                    ? Colors
                                                                        .pinkAccent
                                                                    : book['time'].toDate().difference(DateTime.now()).inSeconds >
                                                                            0
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .green,
                                                              ),
                                                            )
                                                          : book['time']
                                                                      .toDate()
                                                                      .difference(
                                                                          DateTime
                                                                              .now())
                                                                      .inSeconds >
                                                                  0
                                                              ? Text(
                                                                  "NOT SCHEDULE",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: book['time'].toDate().difference(DateTime.now()).inSeconds <
                                                                                600 &&
                                                                            book['time'].toDate().difference(DateTime.now()).inSeconds >
                                                                                -60 *
                                                                                    60
                                                                        ? Colors
                                                                            .pinkAccent
                                                                        : book['time'].toDate().difference(DateTime.now()).inSeconds >
                                                                                0
                                                                            ? Colors.black
                                                                            : Colors.green,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "MEETING COMPLETED",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: book['time'].toDate().difference(DateTime.now()).inSeconds <
                                                                                600 &&
                                                                            book['time'].toDate().difference(DateTime.now()).inSeconds >
                                                                                -60 *
                                                                                    60
                                                                        ? Colors
                                                                            .pinkAccent
                                                                        : book['time'].toDate().difference(DateTime.now()).inSeconds >
                                                                                0
                                                                            ? Colors.black
                                                                            : Colors.green,
                                                                  ),
                                                                ),
                                                    ],
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: book['time']
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
                                          ? () {
                                              _launchURL(book['link']);
                                            }
                                          : book['time']
                                                      .toDate()
                                                      .difference(
                                                          DateTime.now())
                                                      .inSeconds >
                                                  0
                                              ? null
                                              : null),
                            ],
                            //Slider Container properties
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              // height: 300.0,
                              enlargeCenterPage: true,
                              autoPlay: false,
                              aspectRatio: 30 / 15,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              viewportFraction: 0.7,
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

class TimeButton extends StatelessWidget {
  String? dayTime;
  int? minuteFormat;
  int? hourFormat;
  VoidCallback? onpress;

  TimeButton({this.minuteFormat, this.hourFormat, this.dayTime, this.onpress});
  @override
  Widget build(BuildContext context) {
    print('$minuteFormat 000000000000000000000');
    return ElevatedButton(
        child: Container(
          child: Text(
              '${hourFormat! <= 9 ? '0${hourFormat}' : hourFormat}:${minuteFormat! <= 9 ? '0${minuteFormat}' : minuteFormat} ${dayTime}'),
          margin: EdgeInsets.all(12.0),
          padding: EdgeInsets.all(15.0),
          // decoration:
          //     BoxDecoration(border: Border.all(color: Colors.grey)),
        ),
        onPressed: onpress);
  }
}
