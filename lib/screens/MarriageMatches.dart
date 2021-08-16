import 'package:astrology_app/screens/MarriageMatchesDetails.dart';
import 'package:astrology_app/zoom/contentFromApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class MarriageMatches extends StatefulWidget {
  const MarriageMatches({Key? key}) : super(key: key);

  @override
  _MarriageMatchesState createState() => _MarriageMatchesState();
}

class _MarriageMatchesState extends State<MarriageMatches> {
  ///boy widgets and fields

  TextEditingController? boyNameController = TextEditingController();

  FocusNode messageFocusNode1 = FocusNode();
  bool validation = false;
  var boyName;

  List<String> boyNatchatharam = [
    'Select',
    'Natcharam1',
    'Natcharam2',
    'Natcharam3',
    'Natcharam4',
  ];

  String boyValue = 'Select';

  getBoyDropdown() {
    List<DropdownMenuItem<String>> dropList = [];

    for (var enquerys in boyNatchatharam) {
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
        boyValue = value;
      },
    );
  }

  ///girl widgets and fields

  TextEditingController? girlNameController = TextEditingController();
  String girlValue = 'Select';

  List<String> girlNatchatharam = [
    'Select',
    'Ashwini',
    'Natcharam2',
    'Natcharam3',
    'Natcharam4',
  ];
  int? boySelectedNum;
  int? girlSelectedNum;

  getGirlDropdown() {
    List<DropdownMenuItem<String>> dropList = [];

    for (var enquerys in boyNatchatharam) {
      var newList = DropdownMenuItem(
        child: Text(enquerys),
        value: enquerys,
      );
      dropList.add(newList);
    }
    return dropList;
  }

  Widget _buildGirlName() {
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
      controller: girlNameController,
      onChanged: (value) {
        girlValue = value;
      },
    );
  }

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
                            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            height: 70,
                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                                  child: _buildGirlName(),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            height: 68,
                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.grey,
                                      ),
                                      value: boyValue,
                                      isExpanded: true,
                                      items: getBoyDropdown(),
                                      onChanged: (value) {
                                        setState(() {
                                          boyValue = value!;
                                          boySelectedNum = boyNatchatharam.indexOf(value) - 1;
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
                            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            height: 68,
                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.grey,
                                      ),
                                      value: boyValue,
                                      isExpanded: true,
                                      items: getBoyDropdown(),
                                      onChanged: (value) {
                                        setState(() {
                                          boyValue = value!;
                                          boySelectedNum = boyNatchatharam.indexOf(value) - 1;
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
                            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            height: 70,
                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            height: 70,
                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.grey,
                                      ),
                                      value: girlValue,
                                      isExpanded: true,
                                      items: getBoyDropdown(),
                                      onChanged: (value) {
                                        setState(() {
                                          girlValue = value!;
                                          girlSelectedNum = boyNatchatharam.indexOf(girlValue) - 1;
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
                            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            height: 68,
                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.grey,
                                      ),
                                      value: boyValue,
                                      isExpanded: true,
                                      items: getBoyDropdown(),
                                      onChanged: (value) {
                                        setState(() {
                                          boyValue = value!;
                                          boySelectedNum = boyNatchatharam.indexOf(value) - 1;
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
                              onPressed: () {
                                Get.to(
                                  MarriageMatchesDetails(),
                                  transition: Transition.downToUp,
                                  duration: Duration(milliseconds: 500),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
