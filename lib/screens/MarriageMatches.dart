import 'dart:math';

import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/screens/MarriageMatchesDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MarriageMatches extends StatefulWidget {
  const MarriageMatches({Key? key}) : super(key: key);

  @override
  _MarriageMatchesState createState() => _MarriageMatchesState();
}

class _MarriageMatchesState extends State<MarriageMatches> {
  ///boy widgets and fields

  TextEditingController? boyNameController = TextEditingController();

  FocusNode messageFocusNode1 = FocusNode();
  FocusNode messageFocusNode2 = FocusNode();
  bool validation = false;
  var boyName;
  var girlName;

  List<String> natchatharam = [
    'Select',
    'Ashwini',
    'Bharani',
    'Krithika',
    'Mrigashirsha',
    'Ardra',
    'Punarvasu',
    'Pushya',
    'Ashlesha',
    'Magha',
    'Purva Phalguni',
    'Uttara Phalguni',
    'Hastra',
    'Chitra',
    'Swati',
    'Vishaka',
    'Anuradha',
    'Jyeshta',
    'Moola',
    'Purva Ashadha',
    'Uttara Ashadha',
    'Sharvana',
    'Dhanishta',
    'Shatabhisha',
    'Uttara Bhadrapada',
    'Purva Bhadrapada',
    'Revati',
  ];
  List<String> pada = [
    'Select',
    '1',
    '2',
    '3',
    '4',
  ];

  String boyValue = 'Select';
  String boyPada = 'Select';
  String girlPada = 'Select';
  String girlValue = 'Select';
  int? boySelectedNum;
  int? girlSelectedNum;

  natchathiramDropdown() {
    List<DropdownMenuItem<String>> dropList = [];

    for (var enquerys in natchatharam) {
      var newList = DropdownMenuItem(
        child: Text(enquerys),
        value: enquerys,
      );
      dropList.add(newList);
    }
    return dropList;
  }

  padaDropdown() {
    List<DropdownMenuItem<String>> dropList = [];

    for (var enquerys in pada) {
      var newList = DropdownMenuItem(
        child: Text(enquerys),
        value: enquerys,
      );
      dropList.add(newList);
    }
    return dropList;
  }

  Widget _buildBoyName() {
    return TextFormField(
      focusNode: messageFocusNode1,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Ubuntu',
        fontSize: 15,
        color: Colors.black54,
      ),
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
        hintText: 'Enter Name',
        hintStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          fontFamily: 'Ubuntu',
          color: Colors.grey,
        ),
        // labelText: 'Name',
      ),
      controller: boyNameController,
      onChanged: (value) {
        boyName = value;
      },
    );
  }

  ///girl widgets and fields

  TextEditingController? girlNameController = TextEditingController();

  Widget _buildGirlName() {
    return TextFormField(
      focusNode: messageFocusNode2,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Ubuntu',
        fontSize: 15,
        color: Colors.black54,
      ),
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
        hintText: 'Enter Name',
        hintStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          fontFamily: 'Ubuntu',
          color: Colors.grey,
        ),
        // labelText: 'Name',
      ),
      controller: girlNameController,
      onChanged: (value) {
        girlName = value;
      },
    );
  }

  ///matches
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  Future createToken() async {
    final http.Response response = await http.post(
      Uri.parse('https://api.prokerala.com/token'),
      body: {
        'client_id': '7a7a7f65-fdd5-4499-9b0f-5afb178295ff',
        'client_secret': 'oGTDRcX1sXNCSC0KovUMeWru4cTcY15YS63KVbAH',
        'grant_type': 'client_credentials',
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print('0000000000000000000000000000000000000000000000');
      Map valueMap = json.decode(response.body);
      print(valueMap);
      _forumContreller.setMatchingToken(valueMap['access_token']);
      print(
          "///////////////////////token${_forumContreller.matchingToken.value}");
      print('0000000000000000000000000000000000000000000000');
    } else {
      print(response.statusCode);
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  ///matches

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Hero(
                  tag: "animation",
                  child: Image.asset(
                    'images/marriage.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return KeyboardDismisser(
                    child: Container(
                      color: Colors.white,
                      // height: MediaQuery.of(context).size.height,
                      // height: 600,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Container(
                            child: Text(
                              'Boy\'s Details ',
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            height: 70,
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                offset: Offset(0.2, 0.2),
                                blurRadius: 10,
                                spreadRadius: 10,
                                color: Colors.grey.shade200,
                              ),
                            ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Boy Name ',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: " *",
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red[200],
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  // color: Colors.pinkAccent,
                                  child: _buildBoyName(),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            height: 68,
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                offset: Offset(0.3, 0.3),
                                blurRadius: 5,
                                spreadRadius: 3,
                                color: Colors.black12,
                              ),
                            ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // color: Colors.black38,
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Boy Nachathuram',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: " *",
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red[200],
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                                Container(
                                  // margin: EdgeInsets.only(bottom: 10),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    // color: Colors.black38,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      onTap: () {
                                        messageFocusNode1.unfocus();
                                        messageFocusNode2.unfocus();
                                      },
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.grey,
                                      ),
                                      value: boyValue,
                                      isExpanded: true,
                                      items: natchathiramDropdown(),
                                      onChanged: (value) {
                                        setState(() {
                                          boyValue = value!;
                                          boySelectedNum =
                                              natchatharam.indexOf(value) - 1;
                                        });
                                        print(value);
                                        print(boySelectedNum);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            height: 68,
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                offset: Offset(0.3, 0.3),
                                blurRadius: 5,
                                spreadRadius: 3,
                                color: Colors.black12,
                              ),
                            ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // color: Colors.black38,
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Boy Pada',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: " *",
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red[200],
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                                Container(
                                  // margin: EdgeInsets.only(bottom: 10),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    // color: Colors.black38,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      onTap: () {
                                        messageFocusNode1.unfocus();
                                        messageFocusNode2.unfocus();
                                      },
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.grey,
                                      ),
                                      value: boyPada,
                                      isExpanded: true,
                                      items: padaDropdown(),
                                      onChanged: (value) {
                                        setState(() {
                                          boyPada = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 50,
                            color: Colors.grey[400],
                            thickness: 0.3,
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Text(
                              'Girl\'s Details ',
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            height: 70,
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                offset: Offset(0.2, 0.2),
                                blurRadius: 10,
                                spreadRadius: 10,
                                color: Colors.grey.shade200,
                              ),
                            ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Girl Name ',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: " *",
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red[200],
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  // color: Colors.pinkAccent,
                                  child: _buildGirlName(),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            height: 70,
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                offset: Offset(0.3, 0.3),
                                blurRadius: 5,
                                spreadRadius: 3,
                                color: Colors.black12,
                              ),
                            ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Girl Nachathuram',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: " *",
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red[200],
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    // color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      onTap: () {
                                        messageFocusNode1.unfocus();
                                        messageFocusNode2.unfocus();
                                      },
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.grey,
                                      ),
                                      value: girlValue,
                                      isExpanded: true,
                                      items: natchathiramDropdown(),
                                      onChanged: (value) {
                                        setState(() {
                                          girlValue = value!;
                                          girlSelectedNum =
                                              natchatharam.indexOf(girlValue) -
                                                  1;
                                        });
                                        print(value);
                                        print(girlSelectedNum);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            height: 68,
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                offset: Offset(0.3, 0.3),
                                blurRadius: 5,
                                spreadRadius: 3,
                                color: Colors.black12,
                              ),
                            ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // color: Colors.black38,
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Girl Pada',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: " *",
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red[200],
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                                Container(
                                  // margin: EdgeInsets.only(bottom: 10),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    // color: Colors.black38,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      onTap: () {
                                        messageFocusNode1.unfocus();
                                        messageFocusNode2.unfocus();
                                      },
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.grey,
                                      ),
                                      value: girlPada,
                                      isExpanded: true,
                                      items: padaDropdown(),
                                      onChanged: (value) {
                                        setState(() {
                                          girlPada = value!;
                                        });
                                        print(value);
                                        print(boySelectedNum);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 55,
                            margin: const EdgeInsets.only(top: 22),
                            child: ElevatedButton(
                              onPressed: () async {
                                print('uuuuuuuuuuuuuuuuuuuuuuuuuuu');
                                print("${boyName}");
                                print(boySelectedNum.toString());
                                print(boyPada);
                                print(girlName);
                                print(girlValue);
                                print(boyValue);
                                print(girlPada);
                                print(girlSelectedNum.toString());
                                await createToken();

                                print('uuuuuuuuuuuuuuuuuuuuuuuuuuu');
                                Get.to(
                                  MarriageMatchesDetails(
                                    boyPada: boyPada,
                                    natchathiramGirlValue: girlValue,
                                    natchathiramBoyValue: boyValue,
                                    girlPada: girlPada,
                                    girlNatchathiram:
                                        girlSelectedNum.toString(),
                                    boyNatchathiram: boySelectedNum.toString(),
                                    boyName: boyName,
                                    girlName: girlName,
                                  ),
                                  transition: Transition.downToUp,
                                  duration: Duration(milliseconds: 500),
                                );

                                // if (boyPada != "select" &&
                                //         girlValue != "null" &&
                                //         boyValue != "select" &&
                                //         girlPada != "null" &&
                                //         girlSelectedNum.toString() != -1 &&
                                //         boySelectedNum.toString() != -1 ||
                                //     boySelectedNum.toString() != null && boyName != null && girlName != "select") {
                                //   Get.to(
                                //     MarriageMatchesDetails(
                                //       boyPada: boyPada,
                                //       natchathiramGirlValue: girlValue,
                                //       natchathiramBoyValue: boyValue,
                                //       girlPada: girlPada,
                                //       girlNatchathiram: girlSelectedNum.toString(),
                                //       boyNatchathiram: boySelectedNum.toString(),
                                //       boyName: boyName,
                                //       girlName: girlName,
                                //     ),
                                //     transition: Transition.downToUp,
                                //     duration: Duration(milliseconds: 500),
                                //   );
                                // } else {
                                //   Get.snackbar(
                                //     "Thirumana Porutham",
                                //     "You missed some fields",
                                //     icon: Icon(Icons.person, color: Colors.white),
                                //     snackPosition: SnackPosition.TOP,
                                //   );
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                elevation: 2,
                                primary: Color(0xff045de9),
                                onPrimary: Colors.white,
                                textStyle: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text('Matches'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
