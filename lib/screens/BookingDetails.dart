import 'package:astrology_app/screens/SomeoneElseScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum Appointment { ForMe, SomeoneElse }
enum Purpose { Marriage, Astrology, Other }

class BookingDetails extends StatefulWidget {
  const BookingDetails({Key? key}) : super(key: key);

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  Appointment _appointment = Appointment.ForMe;
  Purpose _purpose = Purpose.Marriage;

  ///widgets
  Widget _buildName() {
    return TextFormField(
      // ignore: deprecated_member_use
      autovalidate: validation,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
        LengthLimitingTextInputFormatter(40),
      ],
      // autovalidate: _autoValidate,
      validator: (value) {
        if (value!.isEmpty) {
          return 'name is required';
        } else if (value.length < 3) {
          return 'character should be morethan 2';
        }
        return null;
      },
      decoration: const InputDecoration(
          // prefixIcon: Icon(Icons.drive_file_rename_outline),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
          border: InputBorder.none,
          hintText: 'Enter Your Name',
          hintStyle: TextStyle(fontSize: 12)
          // labelText: 'Name',
          ),
      controller: nameController,
      onChanged: (value) {
        fullname = value;
      },
    );
  }

  bool value = false;
  @override
  Widget build(BuildContext context) {
    print(_purpose);
    print(_appointment);
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
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                ///date and time
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
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
                ),
                SizedBox(height: 20),
                Divider(
                  thickness: 0.2,
                  color: Colors.grey,
                ),
                SizedBox(height: 20),

                ///purpose of appointment
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
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

                ///radio button
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: const Text(
                    'Marriage',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Ubuntu',
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  leading: Radio(
                    value: Purpose.Marriage,
                    groupValue: _purpose,
                    onChanged: (value) {
                      setState(() {
                        _purpose = Purpose.Marriage;
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: const Text(
                    'Astrology',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Ubuntu',
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  leading: Radio(
                    value: Purpose.Astrology,
                    groupValue: _purpose,
                    onChanged: (value) {
                      setState(() {
                        _purpose = Purpose.Astrology;
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: const Text(
                    'Other',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Ubuntu',
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  leading: Radio(
                    value: Purpose.Other,
                    groupValue: _purpose,
                    onChanged: (value) {
                      setState(() {
                        _purpose = Purpose.Other;
                      });
                    },
                  ),
                ),

                ///Condition  value == other means Textfield
                _purpose == Purpose.Other ? TextField() : Container(),
                Divider(
                  thickness: 0.2,
                  color: Colors.grey,
                ),
                SizedBox(height: 20),

                ///this appointment is for
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
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

                ///radio button
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
                    value: Appointment.ForMe,
                    groupValue: _appointment,
                    onChanged: (value) {
                      setState(() {
                        _appointment = Appointment.ForMe;
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
                    value: Appointment.SomeoneElse,
                    groupValue: _appointment,
                    onChanged: (value) {
                      setState(() {
                        _appointment = Appointment.SomeoneElse;
                      });
                    },
                  ),
                ),
                Divider(
                  thickness: 0.2,
                  color: Colors.grey,
                ),

                ///continue button
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xff045de9),
                            Colors.blue,
                          ],
                        )),
                    child: ElevatedButton(
                      ///checking For Me or SomeoneElse to Route to next Page
                      onPressed: _appointment == Appointment.ForMe
                          ? () {
                              ///payment page
                              // Get.to(() => BookingDetails(),
                              //     transition: Transition.topLevel,
                              //     // curve: Curves.ease,
                              //     duration: Duration(milliseconds: 600));
                            }
                          : () {
                              ///someone else page
                              Get.to(() => SomeoneElse(),
                                  transition: Transition.topLevel,
                                  // curve: Curves.ease,
                                  duration: Duration(milliseconds: 600));
                            },
                      child: _appointment == Appointment.ForMe
                          ? Text('Proceed to Payment')
                          : Text('Update Their Document'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        fixedSize: Size(double.infinity, 50),
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 25,
                        ),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Ubuntu',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
