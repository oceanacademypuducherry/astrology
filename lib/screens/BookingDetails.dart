import 'package:flutter/material.dart';

enum BestTutorSite { javatpoint, w3schools, tutorialandexample }

class BookingDetails extends StatefulWidget {
  const BookingDetails({Key? key}) : super(key: key);

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  BestTutorSite _site = BestTutorSite.javatpoint;
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff045de9),
        centerTitle: true,
        title: Text(
          'Booking Details',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontFamily: 'Ubuntu',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                ///purpose of appointment
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Purpose of Appointment',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Ubuntu',
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                ///checkbox
                Row(
                  children: [
                    Checkbox(
                      side: BorderSide(width: 1.5, color: Colors.black54),
                      value: this.value,
                      onChanged: (value) {
                        setState(() {
                          this.value = value!;
                        });
                      },
                    ),
                    Text(
                      'Marriage',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Ubuntu',
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      side: BorderSide(width: 1.5, color: Colors.black54),
                      value: this.value,
                      onChanged: (value) {
                        setState(() {
                          this.value = value!;
                        });
                      },
                    ),
                    Text(
                      'Marriage',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Ubuntu',
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      side: BorderSide(width: 1.5, color: Colors.black54),
                      value: this.value,
                      onChanged: (value) {
                        setState(() {
                          this.value = value!;
                        });
                      },
                    ),
                    Text(
                      'Marriage',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Ubuntu',
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 0.2,
                  color: Colors.grey,
                ),
                SizedBox(height: 20),

                ///date and time
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Date and Time',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Ubuntu',
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 80,
                      height: 40,
                      margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.2, 0.2),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '2:16 PM',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Ubuntu',
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.2, 0.2),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Saturday, 24 July 2021',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Ubuntu',
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Divider(
                  thickness: 0.2,
                  color: Colors.grey,
                ),
                SizedBox(height: 20),

                ///this appointment is for
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'This Appointment is for',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Ubuntu',
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text(
                        'For me',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Ubuntu',
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      leading: Radio(
                        value: BestTutorSite.javatpoint,
                        groupValue: _site,
                        onChanged: (value) {
                          setState(() {
                            _site = BestTutorSite.javatpoint;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Someone else',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Ubuntu',
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      leading: Radio(
                        value: BestTutorSite.w3schools,
                        groupValue: _site,
                        onChanged: (value) {
                          setState(() {
                            _site = BestTutorSite.w3schools;
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
