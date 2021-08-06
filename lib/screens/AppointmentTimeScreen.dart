import 'package:astrology_app/screens/BookingDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class AppointmentTimeScreen extends StatefulWidget {
  String focusedDate;
  List dbList;
  AppointmentTimeScreen({required this.focusedDate, required this.dbList});

  @override
  _AppointmentTimeScreenState createState() => _AppointmentTimeScreenState();
}

class _AppointmentTimeScreenState extends State<AppointmentTimeScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? orderTime;

  List minuteSlot = [];

  String? value;
  void minTime(List newList) {
    for (var i in newList) {
      String minute = i.toString().substring(i.length - 2);
      // String choosen = minute.substring(i.length - 2)
      minuteSlot.add(minute);
    }
    print(minuteSlot);
  }

  @override
  Widget build(BuildContext context) {
    List time_slot = [
      '${widget.focusedDate} 10:00 AM',
      '${widget.focusedDate} 11:00 AM',
      "${widget.focusedDate} 12:00 PM",
      '${widget.focusedDate} 01:00 PM',
      '${widget.focusedDate} 02:00 PM',
      '${widget.focusedDate} 03:00 PM',
      '${widget.focusedDate} 04:00 PM',
      '${widget.focusedDate} 05:00 PM',
      '${widget.focusedDate} 06:00 PM'
    ];

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
      body: Column(
        children: [
          Text('Evening'),
          Expanded(
              child: GridView.builder(
            itemCount: time_slot.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) => InkWell(
              // onTap: () {
              //   orderTime = time_slot.elementAt(index);
              // },
              onTap: widget.dbList.contains(time_slot.elementAt(index))
                  ? null
                  : () {
                      orderTime = time_slot.elementAt(index);
                      // setState(() {
                      //   isCheck = true;
                      // });

                      print('+++++++++++++++++++++++++++++++');
                    },
              child: Column(
                children: [
                  Card(
                    color: widget.dbList.contains(time_slot.elementAt(index))
                        ? Colors.grey
                        : Colors.white,
                    child: GridTile(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // isCheck ?  time_slot.elementAt(index) == orderTime ?Icon(Icons.check) : Text(''),
                            Text(
                                '${time_slot.elementAt(index).toString().substring(time_slot.elementAt(index).toString().length - 8)}'),
                            Text('$index'),
                            Text(widget.dbList
                                    .contains(time_slot.elementAt(index))
                                ? "Full"
                                : 'Available'),
                          ],
                        ),
                      ),
                      // header: orderTime == time_slot.elementAt(index)
                      //     ? Icon(Icons.check)
                      //     : Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          )),
          ElevatedButton(
            child: Text('continue'),
            onPressed: () {
              print(orderTime);
              _firestore.collection('booking').add({
                'time': orderTime,
              });
            },
          )
        ],
      ),
    );
  }
}
