import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final firestore = FirebaseFirestore.instance;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContent();
  }

  List available = [
    '10:00',
    '11:00',
    '12:00',
    '01:00',
    '02:00',
  ];

  String? value;
  String? formattedTime;
  int count = 0;
  List timing = [];

  void getContent() async {
    var data = await firestore.collection('demo').get();
    for (var i in data.docs) {
      var name = i['map'][0]['q2'];
      print('$name 88888888888');
    }
  }

  TextEditingController _eventController = TextEditingController();
  void openBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('demo').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading...");
                  } else {
                    final messages = snapshot.data!.docs;

                    List<TimeButton> data = [];
                    for (var message in messages) {
                      final timestamp = message['map'];
                      // for (var i)
                      print('$timestamp yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');

                      int yearFormat;
                      int monthFormat;
                      int dayFormat;
                      int hourFormat;
                      int minuteFormat;
                      String dayTime;

                      var year = DateFormat('yyyy');
                      var month = DateFormat('M');
                      var day = DateFormat('dd');
                      var hour = DateFormat('hh');
                      var minute = DateFormat('mm');
                      var daytime = DateFormat('a');

                      yearFormat = int.parse(year.format(timestamp.toDate()));
                      monthFormat = int.parse(month.format(timestamp.toDate()));
                      dayFormat = int.parse(day.format(timestamp.toDate()));
                      hourFormat = int.parse(hour.format(timestamp.toDate()));
                      minuteFormat =
                          int.parse(minute.format(timestamp.toDate()));
                      dayTime = daytime.format(timestamp.toDate());
                      for (var i in available) {
                        String result =
                            '${hourFormat <= 9 ? '0${hourFormat}' : hourFormat}:${minuteFormat <= 9 ? '0${minuteFormat}' : minuteFormat}';
                        print('$result reeeeeeeeeeeeeeeeeeeeeeee');

                        timing.add(result);

                        print('timeeeeeeeeeee${i}');
                        if ((yearFormat == focusedDay.year.toInt()) &&
                            (monthFormat == focusedDay.month.toInt()) &&
                            (dayFormat == focusedDay.day.toInt()) &&
                            timing.contains(i)) {
                          print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

                          final sample = TimeButton(
                            dayTime: dayTime,
                            minuteFormat: minuteFormat,
                            hourFormat: hourFormat,
                            onpress: null,
                          );

                          data.add(sample);
                        } else if (!timing.contains(i)) {
                          print('$count =====Before==========');

                          if (count < available.length - 1) {
                            count = count + 1;
                            print('$count =====After==========');
                            String dbhr = i.substring(0, 2);
                            print('$dbhr dbhrrrrr');
                            String dbmin = i.substring(i.length - 2);
                            print('$dbmin dbmin');
                            print("${i}else if work");

                            final sample = TimeButton(
                                dayTime: dayTime,
                                minuteFormat: int.parse(dbmin),
                                hourFormat: int.parse(dbhr),
                                onpress: () {
                                  value = '${dbhr}:${dbmin}';
                                  print(dbmin);
                                  print(dbhr);
                                });
                            data.add(sample);
                          }
                        }
                      }
                    }
                    count = 0;

                    return Wrap(
                      // spacing: 50,
                      // runSpacing: 30,
                      children: data,
                    );
                  }
                },
              ),
              ElevatedButton(
                child: Text('continue'),
                onPressed: () {
                  // int startIndex = 0;
                  // int endIndex = 2;
                  // int startmin = 3;
                  // int endmin = 5;
                  // String year = (focusedDay.year).toString();
                  // String month = (focusedDay.month).toString();
                  // String day = (focusedDay.day).toString();
                  //
                  // String resulthr = value!.substring(startIndex, endIndex);
                  // String resultmin = value!.substring(startmin, endmin);
                  // print(resulthr);
                  // print(resultmin);
                  // print(year);
                  // print(month);
                  // print(day);
                  // DateTime dt = DateTime.parse(
                  //     '${formattedTime} ${resulthr}:${resultmin}:00');
                  // print(dt);
                  // firestore.collection("book").add({
                  //   'name': 'sarah',
                  //   'date': dt,
                  // });
                  firestore.collection('demo').add({
                    'name': 'jaya',
                    'map': FieldValue.arrayUnion([
                      {'1': ''}
                    ])
                  });
                  print('added');
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Calendar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime.now(),
            lastDay: DateTime(2050),
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
              getContent();
              setState(() {
                openBottomSheet(context);
              });

              formattedTime = DateFormat("yyyy-MM-dd").format(focusedDay);
              // 2020-01-02 03:04:05.000

              print(focusedDay);
              print(formattedTime);
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
        ],
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
