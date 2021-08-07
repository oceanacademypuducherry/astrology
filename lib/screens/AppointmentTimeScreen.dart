import 'package:astrology_app/screens/BookingDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class AppointmentTimeScreen extends StatefulWidget {
  String focusedDate;

  List dbList;
  AppointmentTimeScreen({
    required this.focusedDate,
    required this.dbList,
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

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Wrap(
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
                                      });
                                      orderTime = time_slot[i];
                                      print(orderTime);
                                    },
                              child: Card(
                                color: widget.dbList.contains(time_slot[i])
                                    ? Colors.red[200]
                                    : colorChange[i]
                                        ? Colors.green[300]
                                        : Colors.grey[200],
                                elevation: 8,
                                //                  Colors.white,,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${DateFormat.jm().format(time_slot[i])}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      widget.dbList.contains(time_slot[i])
                                          ? Text(
                                              'Unavailable',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              'Available',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
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
                margin: EdgeInsets.symmetric(vertical: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'images/afternoon.png',
                          width: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'AfterNoon',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Container(
                      child: Wrap(
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
                                        });
                                        orderTime = time_slot[i];
                                        print(orderTime);
                                      },
                                child: Card(
                                  color: widget.dbList.contains(time_slot[i])
                                      ? Colors.red[200]
                                      : colorChange[i]
                                          ? Colors.green[300]
                                          : Colors.grey[200],
                                  elevation: 8,
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${DateFormat.jm().format(time_slot[i])}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        widget.dbList.contains(i)
                                            ? Text(
                                                'Unavailable',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                'Available',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                // color: Colors.lightGreenAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'images/night.png',
                          width: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Evenings',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Wrap(
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
                              onTap: widget.dbList.contains(i)
                                  ? null
                                  : () {
                                      orderTime = time_slot[i];
                                      print(orderTime);
                                      setState(() {
                                        print('$i 000000000000');
                                        colorChange.updateAll((key, value) =>
                                            colorChange[key] = false);
                                        colorChange[i] = true;
                                      });
                                    },
                              child: Card(
                                // margin: EdgeInsets.all(12),
                                color: widget.dbList.contains(time_slot[i])
                                    ? Colors.red[200]
                                    : colorChange[i]
                                        ? Colors.green[300]
                                        : Colors.grey[200],
                                elevation: 8,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${DateFormat.jm().format(time_slot[i])}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      widget.dbList.contains(time_slot[i])
                                          ? Text(
                                              'Unavailable',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              'Available',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          'continue',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      onPressed: () {
                        print('>>>>>>>>>>>>>>>>>>>>>>>');
                        print(orderTime);
                        setState(() {
                          colorChange.updateAll(
                              (key, value) => colorChange[key] = false);
                        });

                        Get.to(() => BookingDetails(),
                            arguments: orderTime,
                            transition: Transition.rightToLeft,
                            curve: Curves.easeInToLinear,
                            duration: Duration(milliseconds: 600));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
