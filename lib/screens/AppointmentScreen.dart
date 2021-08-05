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
  // void openBottomSheet(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Column(
  //           children: [
  //             Container(
  //               height: 500,
  //               margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  //               child: Wrap(
  //                 children: [
  //                   ///morning
  //                   Row(
  //                     children: [
  //                       Container(
  //                         margin: EdgeInsets.symmetric(horizontal: 10),
  //                         // color: Colors.blue,
  //                         width: 30,
  //                         height: 30,
  //                         child: Image.asset(
  //                           'images/morning.png',
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                       Container(
  //                         alignment: Alignment.center,
  //                         height: 30,
  //                         child: Text(
  //                           'Morning',
  //                           style: TextStyle(
  //                             color: Colors.blue,
  //                             fontSize: 15,
  //                             fontFamily: 'Ubuntu',
  //                             fontWeight: FontWeight.w700,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SingleChildScrollView(
  //                     scrollDirection: Axis.horizontal,
  //                     child: Container(
  //                       alignment: Alignment.centerLeft,
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         children: [
  //                           Container(
  //                             margin: EdgeInsets.symmetric(
  //                                 horizontal: 10, vertical: 20),
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: Colors.grey,
  //                                   offset: Offset(0.1, 0.2),
  //                                 )
  //                               ],
  //                               color: Colors.grey[100],
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             height: 40,
  //                             width: 100,
  //                             child: Text(
  //                               'Wed 1 Jul',
  //                               style: TextStyle(
  //                                 color: Colors.grey,
  //                                 fontSize: 13,
  //                                 fontFamily: 'Ubuntu',
  //                                 fontWeight: FontWeight.normal,
  //                               ),
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.symmetric(
  //                                 horizontal: 10, vertical: 20),
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: Colors.grey,
  //                                   offset: Offset(0.1, 0.2),
  //                                 )
  //                               ],
  //                               color: Colors.grey[100],
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             height: 40,
  //                             width: 100,
  //                             child: Text(
  //                               'Wed 1 Jul',
  //                               style: TextStyle(
  //                                 color: Colors.grey,
  //                                 fontSize: 13,
  //                                 fontFamily: 'Ubuntu',
  //                                 fontWeight: FontWeight.normal,
  //                               ),
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.symmetric(
  //                                 horizontal: 10, vertical: 20),
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: Colors.grey,
  //                                   offset: Offset(0.1, 0.2),
  //                                 )
  //                               ],
  //                               color: Colors.grey[100],
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             height: 40,
  //                             width: 100,
  //                             child: Text(
  //                               'Wed 1 Jul',
  //                               style: TextStyle(
  //                                 color: Colors.grey,
  //                                 fontSize: 13,
  //                                 fontFamily: 'Ubuntu',
  //                                 fontWeight: FontWeight.normal,
  //                               ),
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.symmetric(
  //                                 horizontal: 10, vertical: 20),
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: Colors.grey,
  //                                   offset: Offset(0.1, 0.2),
  //                                 )
  //                               ],
  //                               color: Colors.grey[100],
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             height: 40,
  //                             width: 100,
  //                             child: Text(
  //                               'Wed 1 Jul',
  //                               style: TextStyle(
  //                                 color: Colors.grey,
  //                                 fontSize: 13,
  //                                 fontFamily: 'Ubuntu',
  //                                 fontWeight: FontWeight.normal,
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //
  //                   ///afternoon
  //                   Row(
  //                     children: [
  //                       Container(
  //                         margin: EdgeInsets.symmetric(horizontal: 10),
  //                         // color: Colors.blue,
  //                         width: 30,
  //                         height: 30,
  //                         child: Image.asset(
  //                           'images/afternoon.png',
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                       Container(
  //                         alignment: Alignment.center,
  //                         height: 30,
  //                         child: Text(
  //                           'Afternoon',
  //                           style: TextStyle(
  //                             color: Colors.blue,
  //                             fontSize: 15,
  //                             fontFamily: 'Ubuntu',
  //                             fontWeight: FontWeight.w700,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SingleChildScrollView(
  //                     scrollDirection: Axis.horizontal,
  //                     child: Container(
  //                       alignment: Alignment.centerLeft,
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         children: [
  //                           Container(
  //                             margin: EdgeInsets.symmetric(
  //                                 horizontal: 10, vertical: 20),
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: Colors.grey,
  //                                   offset: Offset(0.1, 0.2),
  //                                 )
  //                               ],
  //                               color: Colors.grey[100],
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             height: 40,
  //                             width: 100,
  //                             child: Text(
  //                               'Wed 1 Jul',
  //                               style: TextStyle(
  //                                 color: Colors.grey,
  //                                 fontSize: 13,
  //                                 fontFamily: 'Ubuntu',
  //                                 fontWeight: FontWeight.normal,
  //                               ),
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.symmetric(
  //                                 horizontal: 10, vertical: 20),
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: Colors.grey,
  //                                   offset: Offset(0.1, 0.2),
  //                                 )
  //                               ],
  //                               color: Colors.grey[100],
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             height: 40,
  //                             width: 100,
  //                             child: Text(
  //                               'Wed 1 Jul',
  //                               style: TextStyle(
  //                                 color: Colors.grey,
  //                                 fontSize: 13,
  //                                 fontFamily: 'Ubuntu',
  //                                 fontWeight: FontWeight.normal,
  //                               ),
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.symmetric(
  //                                 horizontal: 10, vertical: 20),
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: Colors.grey,
  //                                   offset: Offset(0.1, 0.2),
  //                                 )
  //                               ],
  //                               color: Colors.grey[100],
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             height: 40,
  //                             width: 100,
  //                             child: Text(
  //                               'Wed 1 Jul',
  //                               style: TextStyle(
  //                                 color: Colors.grey,
  //                                 fontSize: 13,
  //                                 fontFamily: 'Ubuntu',
  //                                 fontWeight: FontWeight.normal,
  //                               ),
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.symmetric(
  //                                 horizontal: 10, vertical: 20),
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: Colors.grey,
  //                                   offset: Offset(0.1, 0.2),
  //                                 )
  //                               ],
  //                               color: Colors.grey[100],
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             height: 40,
  //                             width: 100,
  //                             child: Text(
  //                               'Wed 1 Jul',
  //                               style: TextStyle(
  //                                 color: Colors.grey,
  //                                 fontSize: 13,
  //                                 fontFamily: 'Ubuntu',
  //                                 fontWeight: FontWeight.normal,
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //
  //                   ///evening
  //                   Row(
  //                     children: [
  //                       Container(
  //                         margin: EdgeInsets.symmetric(horizontal: 10),
  //                         // color: Colors.blue,
  //                         width: 30,
  //                         height: 30,
  //                         child: Image.asset(
  //                           'images/morning.png',
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                       Container(
  //                         alignment: Alignment.center,
  //                         height: 30,
  //                         child: Text(
  //                           'Evening',
  //                           style: TextStyle(
  //                             color: Colors.blue,
  //                             fontSize: 15,
  //                             fontFamily: 'Ubuntu',
  //                             fontWeight: FontWeight.w700,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SingleChildScrollView(
  //                     scrollDirection: Axis.horizontal,
  //                     child: Container(
  //                       alignment: Alignment.centerLeft,
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         children: [
  //                           Container(
  //                             margin: EdgeInsets.symmetric(
  //                                 horizontal: 10, vertical: 20),
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: Colors.grey,
  //                                   offset: Offset(0.1, 0.2),
  //                                 )
  //                               ],
  //                               color: Colors.grey[100],
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             height: 40,
  //                             width: 100,
  //                             child: Text(
  //                               'Wed 1 Jul',
  //                               style: TextStyle(
  //                                 color: Colors.grey,
  //                                 fontSize: 13,
  //                                 fontFamily: 'Ubuntu',
  //                                 fontWeight: FontWeight.normal,
  //                               ),
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.symmetric(
  //                                 horizontal: 10, vertical: 20),
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: Colors.grey,
  //                                   offset: Offset(0.1, 0.2),
  //                                 )
  //                               ],
  //                               color: Colors.grey[100],
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             height: 40,
  //                             width: 100,
  //                             child: Text(
  //                               'Wed 1 Jul',
  //                               style: TextStyle(
  //                                 color: Colors.grey,
  //                                 fontSize: 13,
  //                                 fontFamily: 'Ubuntu',
  //                                 fontWeight: FontWeight.normal,
  //                               ),
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.symmetric(
  //                                 horizontal: 10, vertical: 20),
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: Colors.grey,
  //                                   offset: Offset(0.1, 0.2),
  //                                 )
  //                               ],
  //                               color: Colors.grey[100],
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             height: 40,
  //                             width: 100,
  //                             child: Text(
  //                               'Wed 1 Jul',
  //                               style: TextStyle(
  //                                 color: Colors.grey,
  //                                 fontSize: 13,
  //                                 fontFamily: 'Ubuntu',
  //                                 fontWeight: FontWeight.normal,
  //                               ),
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.symmetric(
  //                                 horizontal: 10, vertical: 20),
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: Colors.grey,
  //                                   offset: Offset(0.1, 0.2),
  //                                 )
  //                               ],
  //                               color: Colors.grey[100],
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             height: 40,
  //                             width: 100,
  //                             child: Text(
  //                               'Wed 1 Jul',
  //                               style: TextStyle(
  //                                 color: Colors.grey,
  //                                 fontSize: 13,
  //                                 fontFamily: 'Ubuntu',
  //                                 fontWeight: FontWeight.normal,
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //
  //                   ///continue
  //                   Row(
  //                     children: [
  //                       ElevatedButton(
  //                         onPressed: () {},
  //                         child: Text('Continue'),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
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
              Get.to(() => AppointmentTimeScreen(),
                  // transition: Transition.cupertinoDialog,
                  fullscreenDialog: true,
                  curve: Curves.easeInToLinear,
                  duration: Duration(milliseconds: 600));
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              getContent();
              // setState(() {
              //   openBottomSheet(context);
              // });

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
