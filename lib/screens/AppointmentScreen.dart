import 'package:astrology_app/screens/AppointmentTimeScreen.dart';
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
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List dbList = [];

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
      body: Column(
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

              // setState(() {
              //   openBottomSheet(context);
              // });

              formattedTime = DateFormat("yyyy-MM-dd").format(focusedDay);
              // 2020-01-02 03:04:05.000

              print(focusedDay);
              print(formattedTime.runtimeType);
              Get.to(
                  () => AppointmentTimeScreen(
                        focusedDate: formattedTime.toString(),
                        dbList: dbList,
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
