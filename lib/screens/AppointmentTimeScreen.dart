import 'package:astrology_app/screens/BookingDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    // getAvailable(widget.focusedDate);
    print(widget.freeList);
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
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
                margin: EdgeInsets.only(top: 20, left: 15, bottom: 20, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          decoration: BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(color: Colors.grey.shade300, offset: Offset(2, 2), blurRadius: 2),
                            BoxShadow(color: Colors.grey.shade200, offset: Offset(-2, -2), blurRadius: 2),
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
                          decoration: BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(color: Colors.grey.shade300, offset: Offset(2, 2), blurRadius: 1),
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
                          if (DateFormat.jm()
                                  .format(time_slot[i])
                                  .substring(DateFormat.jm().format(time_slot[i]).length - 2) ==
                              'AM')
                            GestureDetector(
                              onTap: widget.dbList.contains(time_slot[i])
                                  ? null
                                  : () {
                                      setState(() {
                                        print('$i 000000000000');
                                        colorChange.updateAll((key, value) => colorChange[key] = false);
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
                                elevation: widget.dbList.contains(time_slot[i]) ? 0 : 13,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${DateFormat.jm().format(time_slot[i])}',
                                        style: widget.dbList.contains(time_slot[i])
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
                            if ((DateFormat.jm()
                                        .format(time_slot[i])
                                        .substring(DateFormat.jm().format(time_slot[i]).length - 2) ==
                                    'PM') &&
                                time_slot[i].hour > 12 &&
                                time_slot[i].hour < 16)
                              GestureDetector(
                                onTap: widget.dbList.contains(i)
                                    ? null
                                    : () {
                                        setState(() {
                                          print('$i 000000000000');
                                          colorChange.updateAll((key, value) => colorChange[key] = false);
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
                                  elevation: widget.dbList.contains(time_slot[i]) ? 0 : 13,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${DateFormat.jm().format(time_slot[i])}',
                                          style: widget.dbList.contains(time_slot[i])
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
                          if ((DateFormat.jm()
                                      .format(time_slot[i])
                                      .substring(DateFormat.jm().format(time_slot[i]).length - 2) ==
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
                                        colorChange.updateAll((key, value) => colorChange[key] = false);
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
                                elevation: widget.dbList.contains(time_slot[i]) ? 0 : 13,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${DateFormat.jm().format(time_slot[i])}',
                                        style: widget.dbList.contains(time_slot[i])
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
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          ? () {
                              print('>>>>>>>>>>>>>>>>>>>>>>>');
                              print(orderTime);
                              setState(() {
                                colorChange.updateAll((key, value) => colorChange[key] = false);
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
