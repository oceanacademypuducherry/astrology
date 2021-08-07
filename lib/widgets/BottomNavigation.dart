import 'package:astrology_app/Forum/forum.dart';
import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/screens/AppointmentScreen.dart';
import 'package:astrology_app/screens/BooksScreen.dart';
import 'package:astrology_app/screens/ForumScreen.dart';
import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:astrology_app/screens/ProfileScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    BooksScreen(),
    AppointmentScreen(),
    Forum(),
    ProfileScreen(),
  ];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  setSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userNumber = prefs.getString('user').toString();
    var userDatas = await _firestore.collection('newusers').get();
    for (var i in userDatas.docs) {
      if (i['phoneNumber'] == userNumber) {
        Get.find<ForumContreller>().setUserSession(userNumber.toString());
        Get.find<ForumContreller>().setUserInfo(i.data());
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Ubuntu',
          fontSize: 11,
        ),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.grey[600],
              ),
              label: 'Home',
              activeIcon: Padding(
                padding: const EdgeInsets.all(1),
                child: Icon(
                  Icons.home,
                ),
              )),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.book,
              color: Colors.grey[600],
              size: 20,
            ),
            label: 'Books',
            activeIcon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                FontAwesomeIcons.book,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.calendar,
              color: Colors.grey[600],
              size: 20,
            ),
            label: 'Appointment',
            activeIcon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                FontAwesomeIcons.calendarAlt,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: Colors.grey[600],
              size: 25,
            ),
            label: 'Forum',
            activeIcon: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Icon(
                Icons.chat,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Icon(
                  FontAwesomeIcons.user,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            ),
            label: 'Profile',
            activeIcon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                FontAwesomeIcons.userAlt,
              ),
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
    ;
  }
}
