import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? email;

  String? phoneNumber;

  String? fullname;

  bool validation = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  Widget _buildEmail() {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
      // ignore: deprecated_member_use
      autovalidate: validation,
      validator: (value) =>
          EmailValidator.validate(value!) ? null : "please enter a valid email",
      decoration: const InputDecoration(
          // prefixIcon: Icon(Icons.email_outlined),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
          border: InputBorder.none,
          hintText: 'Enter Your Email',
          hintStyle: TextStyle(fontSize: 12)
          // labelText: 'Email',
          ),
      controller: emailController,
      onChanged: (value) {
        email = value;
      },
    );
  }

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

  Widget _buildphonenumber() {
    return TextFormField(
      // ignore: deprecated_member_use
      autovalidate: validation,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp(r"^\d+\.?\d{0,2}"),
        ),
        LengthLimitingTextInputFormatter(10),
      ],
      validator: (value) {
        if (value!.isEmpty) {
          return 'phone_number is required';
        } else if (value.length < 10) {
          return 'invalid phone_number';
        }
        return null;
      },
      decoration: const InputDecoration(
          // prefixIcon: Icon(Icons.phone_android_outlined),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
          border: InputBorder.none,
          hintText: 'Enter Your Number',
          hintStyle: TextStyle(fontSize: 12)
          // labelText: 'Number',
          ),
      controller: phoneNumberController,
      onChanged: (value) {
        phoneNumber = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: IconButton(
              icon: Icon(
                Icons.padding,
                color: Colors.blue,
              ),
              onPressed: () {},
            ),
          ),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 15,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 20,
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("images/p.jpg"),
                          radius: 50,
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0.5, 0.5),
                                  color: Colors.grey,
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: 25,
                            height: 25,
                            child: Icon(
                              Icons.add,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'Mohamed Ijass',
                              style: TextStyle(
                                letterSpacing: 0.4,
                                color: Colors.black54,
                                fontSize: 21,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              'jass07rtr@gmail.com',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              '9952727521',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20, left: 20, top: 30),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Full Name',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    _buildName(),
                  ],
                ),
              ),
              Divider(
                color: Colors.black54,
                thickness: 0.2,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Mobile Phone',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    _buildphonenumber(),
                  ],
                ),
              ),
              Divider(
                color: Colors.black54,
                thickness: 0.2,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    _buildEmail(),
                  ],
                ),
              ),
              Divider(
                color: Colors.black54,
                thickness: 0.2,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              'Update Jadhagam',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )),
                    ),
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("images/p.jpg"),
                          radius: 50,
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0.5, 0.5),
                                  color: Colors.grey,
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: 25,
                            height: 25,
                            child: Icon(
                              Icons.add,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black54,
                thickness: 0.2,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'History of Appointment',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
                                'Wed 1 Jul',
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
                                'Wed 1 Jul',
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
                                'Wed 1 Jul',
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
                                'Wed 1 Jul',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
