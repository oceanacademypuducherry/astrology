import 'package:flutter/material.dart';

class AppointmentTimeScreen extends StatelessWidget {
  const AppointmentTimeScreen({Key? key}) : super(key: key);

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
          Container(
            margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            child: Wrap(
              children: [
                ///morning
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      // color: Colors.blue,
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        'images/morning.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text(
                        'Morning',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.1, 0.2),
                              )
                            ],
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 40,
                          width: 100,
                          child: Text(
                            '9 AM',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.1, 0.2),
                              )
                            ],
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 40,
                          width: 100,
                          child: Text(
                            '9:30 AM',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.1, 0.2),
                              )
                            ],
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 40,
                          width: 100,
                          child: Text(
                            '10 AM',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.1, 0.2),
                              )
                            ],
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 40,
                          width: 100,
                          child: Text(
                            '10:30 AM',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///afternoon
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      // color: Colors.blue,
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        'images/afternoon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text(
                        'Afternoon',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.1, 0.2),
                              )
                            ],
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 40,
                          width: 100,
                          child: Text(
                            '12 PM',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.1, 0.2),
                              )
                            ],
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 40,
                          width: 100,
                          child: Text(
                            '12:30 PM',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.1, 0.2),
                              )
                            ],
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 40,
                          width: 100,
                          child: Text(
                            '1:30 PM',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.1, 0.2),
                              )
                            ],
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 40,
                          width: 100,
                          child: Text(
                            '2:30 PM',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///evening
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      // color: Colors.blue,
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        'images/morning.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text(
                        'Evening',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.1, 0.2),
                              )
                            ],
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 40,
                          width: 100,
                          child: Text(
                            '4 PM',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.1, 0.2),
                              )
                            ],
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 40,
                          width: 100,
                          child: Text(
                            '4:30 PM',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.1, 0.2),
                              )
                            ],
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 40,
                          width: 100,
                          child: Text(
                            '5 PM',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.1, 0.2),
                              )
                            ],
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 40,
                          width: 100,
                          child: Text(
                            '6 PM',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///continue
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Continue'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
