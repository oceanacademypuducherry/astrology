import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SampleBooking extends StatefulWidget {
  List dbList;
  SampleBooking({required this.dbList});
  @override
  _SampleBookingState createState() => _SampleBookingState();
}

class _SampleBookingState extends State<SampleBooking> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List time_slot = ['10:00', '11:00', "12:00", '01:00'];

  String? orderTime;

  bool isCheck = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          Expanded(
              child: GridView.builder(
            itemCount: time_slot.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) => InkWell(
              onTap: widget.dbList.contains(time_slot)
                  ? null
                  : () {
                      setState(() {
                        isCheck = true;
                      });

                      orderTime = time_slot.elementAt(index);
                      print(orderTime);
                      print('+++++++++++++++++++++++++++++++');
                    },
              child: Card(
                color: widget.dbList.contains(time_slot.elementAt(index))
                    ? Colors.pinkAccent
                    : Colors.redAccent,
                child: GridTile(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('$isCheck'),
                        // isCheck ?  time_slot.elementAt(index) == orderTime ?Icon(Icons.check) : Text(''),
                        Text('${time_slot.elementAt(index)}'),
                        Text('$index'),
                        Text(widget.dbList.contains(time_slot.elementAt(index))
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
            ),
          )),
          ElevatedButton(
            child: Text('continue'),
            onPressed: () {
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
