// ignore_for_file: file_names

import 'dart:math';
import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/screens/MarriageMatchesDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:velocity_x/velocity_x.dart';

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
  dynamic loadingJadhagam;
  var selectedRasiIndex;
  var englishSelectedGirlRasi;
  var englishNatchathiramSelectedGirl;
  bool isOpen = true;

  List<String> rasiList = [
    'Select',
    'மேஷம்',
    'ரிஷபம்',
    'மிதுனம்',
    'கடகம்',
    'சிம்மம்',
    'கன்னி',
    'துலாம்',
    'விருச்சிகம்',
    'தனுசு',
    'மகரம்',
    'கும்பம்',
    'மீனம்',
  ];

  List EnglishRasiList = [
    'Select',
    'Mesham',
    'Rishabam',
    'Mithunam',
    'Kadagam',
    'Simmam',
    'Kanni',
    'Thulam',
    'Virichigam',
    'Dhanusu',
    'Magaram',
    'Kumbam',
    'Meenam',
  ];

  var boySelectedRasi = 'Select';
  String girlSelectedRasi = 'Select';
  var boySelectedNatchathiram;
  var girlSelectedNatchathiram;
  List<String> boyNatchathiram = [];
  List<String> girlNatchathiram = [];

  boyNatchathiramDropdown() {
    List<DropdownMenuItem<String>> dropList = [];
    for (var natchathiram in boyNatchathiram) {
      print("${boyNatchathiram} ///////////////////////////////");
      var newList = DropdownMenuItem(
        child: Text(natchathiram),
        value: natchathiram,
      );
      dropList.add(newList);
    }
    return dropList;
  }

  girlNatchathiramDropdown() {
    List<DropdownMenuItem<String>> dropList = [];
    for (var natchathiram in girlNatchathiram) {
      print("${girlNatchathiram} ///////////////////////////////");
      var newList = DropdownMenuItem(
        child: Text(natchathiram),
        value: natchathiram,
      );
      dropList.add(newList);
    }
    return dropList;
  }

  Map a = {
    "Mesham": ["Select", "Aswini", "Barani", "Karthigai"],
    "Rishabam": ["Select", "Karthigai", "Rohini", "Mirugasirisham"],
    "Mithunam": ["Select", "Mirugasirisham", "Thiruvathirai", "Punarpusam"],
    "Kadagam": ["Select", "Punarpusam", "Pusam", "Aayilyam"],
    "Simmam": ["Select", "Magam", "Pooram", "Uthiram"],
    "Kanni": ["Select", "Uthiram", "Astham", "Chithirai"],
    "Thulam": ["Select", "Chithirai", "Swathi", "Visagam"],
    "Virichigam": ["Select", "Visagam", "Anusham", "Ketai"],
    "Dhanusu": ["Select", "Moolam", "Pooradam", "Uthradam"],
    "Magaram": ["Select", "Uthradam", "Thiruvonam", "Avitam"],
    "Kumbam": ["Select", "Avitam", "Sadhayam", "Pooratathi"],
    "Meenam": ["Select", "Pooratathi", "Uthiratathi", "Revathi"],
  };

  Map tamilNatchathiram = {
    "Mesham": ["Select", "அஸ்வினி", "பரணி", "கார்த்திகை"],
    "Rishabam": ["Select", "கார்த்திகை", "ரோகினி", "மிருகசிரிஷம்"],
    "Mithunam": ["Select", "மிருகசிரிஷம்", "திருவாதிரை", "புனர்பூசம்"],
    "Kadagam": ["Select", "புனர்பூசம்", "பூசம்", "ஆயில்யம்"],
    "Simmam": ["Select", "மகம்", "பூரம்", "உத்திரம்"],
    "Kanni": ["Select", "உத்திரம்", "ஹஸ்தம்", "சித்திரை"],
    "Thulam": ["Select", "சித்திரை", "சுவாதி", "விசாகம்"],
    "Virichigam": ["Select", "விசாகம்", "அனுஷம்", "கேட்டை"],
    "Dhanusu": ["Select", "மூலம்", "பூராடம்", "உத்ராடம்"],
    "Magaram": ["Select", "உத்ராடம்", "திருவோணம்", "அவிட்டம்"],
    "Kumbam": ["Select", "அவிட்டம்", "சாதயம்", "பூரட்டாதி"],
    "Meenam": ["Select", "பூரட்டாதி", "உத்திரட்டாதி", "ரேவதி"],
  };
  rasiListDropdown() {
    List<DropdownMenuItem<String>> dropList = [];

    for (var enquerys in rasiList) {
      print("$boySelectedRasi rasiDisBlankropdown");
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

  var marriage;
  marriageData(String boyNatchathiram, String girlNatchathiram) async {
    print(boyNatchathiram);
    print(girlNatchathiram);
    final response = await http.get(
      Uri.parse(
          'https://dheivegam.com/wp-admin/admin-ajax.php?action=populate_natchathira_porutham&male_natchatra=$boyNatchathiram&female_natchatra=$girlNatchathiram'),
    );
    if (response.statusCode == 200) {
      List joinig = [];
      List porutham = [
        'தின பொருத்தம்',
        'கன பொருத்தம்',
        'மகேந்திர பொருத்தம்',
        'ஸ்திரி பொருத்தம்',
        'யோனி பொருத்தம்',
        'ராசி பொருத்தம்',
        'ராசி அதிபதி பொருத்தம்',
        'வசிய பொருத்தம்',
        'ராஜ்ஜி பொருத்தம்',
        'நாடி பொருத்தம்',
      ];
      print(response.statusCode);

      print(response.body.runtimeType);
      marriage = response.body.split(' ');
      for (var i in marriage) {
        i.contains('YES')
            ? joinig.add('YES')
            : i.contains('NO')
                ? joinig.add('NO')
                : null;
      }

      Map combination = {};

      for (var i = 0; i <= porutham.length - 1; i++) {
        combination[porutham[i]] = joinig[i];
      }

      _forumContreller.setJadhagamDetails(combination);

      Future.delayed(0.100.seconds, loadingJadhagam);
      print(
          '================////////////////////////api//////////////////////////==============');
      print(joinig);

      print('=================api=============');
    } else {
      print(response.statusCode);
      throw Exception('Failed *********************');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj ');
  }

  ///matches
  var englishSelectedRasi;
  var englishNatchathiramSelectedBoy;
  @override
  Widget build(BuildContext context) {
    // isOpen = true;
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
                              'மணமகன் விவரம்',
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
                                        text: "மணமகன் பெயர்",
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
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
                                        text: 'மணமகன் ராசி',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
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
                                      value: boySelectedRasi,
                                      isExpanded: true,
                                      items: rasiListDropdown(),
                                      onChanged: (value) {
                                        setState(() {
                                          boySelectedRasi = value!;
                                          selectedRasiIndex =
                                              rasiList.indexOf(value);
                                          print(
                                              '$selectedRasiIndex iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
                                          englishSelectedRasi = EnglishRasiList[
                                              selectedRasiIndex];
                                          print(englishSelectedRasi);
                                          boyNatchathiram = tamilNatchathiram[
                                              englishSelectedRasi];
                                          boySelectedNatchathiram =
                                              boyNatchathiram[0];
                                        });

                                        print(
                                            "$boySelectedRasi ☻☻☻boySelectedRasi");
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
                                        text: 'மணமகன் நட்சத்திரம்',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
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
                                      value: boySelectedNatchathiram,
                                      isExpanded: true,
                                      items: boyNatchathiramDropdown(),
                                      onChanged: (value) {
                                        setState(() {
                                          boySelectedNatchathiram = value!;
                                          var englishNatchathiramIndex =
                                              tamilNatchathiram[
                                                      englishSelectedRasi]
                                                  .indexOf(value);
                                          print(englishNatchathiramIndex);
                                          englishNatchathiramSelectedBoy =
                                              a[englishSelectedRasi]
                                                  [englishNatchathiramIndex];
                                          print(englishNatchathiramSelectedBoy);
                                        });

                                        print(
                                            "$boySelectedNatchathiram  selectedboySelectedNatchathiram");
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
                              'மணமகள் விவரம்',
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
                                        text: 'மணமகள் பெயர்',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
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
                                        text: 'மணமகள் ராசி',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
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
                                      value: girlSelectedRasi,
                                      isExpanded: true,
                                      items: rasiListDropdown(),
                                      onChanged: (value) {
                                        setState(() {
                                          girlSelectedRasi = value!;
                                          var selectedRasiGirlIndex =
                                              rasiList.indexOf(value);
                                          englishSelectedGirlRasi =
                                              EnglishRasiList[
                                                  selectedRasiGirlIndex];
                                          print(
                                              '$englishSelectedGirlRasi oooooooooooooooooooooooooooooooooooo');
                                          girlNatchathiram = tamilNatchathiram[
                                              englishSelectedGirlRasi];
                                          girlSelectedNatchathiram =
                                              girlNatchathiram[0];
                                          print(
                                              "$girlSelectedRasi  ☻☻☻girlSelectedRasi");
                                        });
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
                                        text: 'மணமகள் நட்சத்திரம்',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
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
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.grey,
                                      ),
                                      value: girlSelectedNatchathiram,
                                      isExpanded: true,
                                      items: girlNatchathiramDropdown(),
                                      onChanged: (value) {
                                        setState(() {
                                          ///todo

                                          ///todo
                                          girlSelectedNatchathiram = value!;
                                          var englishNatchathiramIndex =
                                              tamilNatchathiram[
                                                      englishSelectedGirlRasi]
                                                  .indexOf(value);
                                          print(englishNatchathiramIndex);

                                          englishNatchathiramSelectedGirl =
                                              a[englishSelectedGirlRasi]
                                                  [englishNatchathiramIndex];

                                          print(
                                              englishNatchathiramSelectedGirl);

                                          print(
                                              "$girlSelectedNatchathiram  ☻☻☻girlSelectedNatchathiram");
                                        });
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
                              onPressed: isOpen == true
                                  ? () async {
                                      setState(() {
                                        isOpen = false;
                                      });
                                      print('//////////////////////');
                                      print(
                                          '$boySelectedRasi ///☻☻boySelectedRasi');
                                      print(
                                          '$boySelectedNatchathiram ///☻☻boySelectedNatchathiram');
                                      print(
                                          '$girlSelectedRasi  ///☻☻girlSelectedRasi');
                                      print(
                                          '$girlSelectedNatchathiram ///☻☻girlSelectedNatchathiram');
                                      print('$girlName ///☻☻girlName');
                                      print('$boyName  ///☻☻boyName');
                                      print('//////////////////////');
                                      if (boySelectedRasi != "select" &&
                                          boySelectedNatchathiram != null &&
                                          girlSelectedRasi != "select" &&
                                          girlSelectedNatchathiram != null &&
                                          boyName != null &&
                                          girlName != null) {
                                        print(_forumContreller
                                            .jadhagamDetail.value);
                                        loadingJadhagam = VxToast.showLoading(
                                            context,
                                            msg: "Loading");
                                        await marriageData(
                                            englishNatchathiramSelectedBoy,
                                            englishNatchathiramSelectedGirl);
                                        setState(() {
                                          isOpen = true;
                                        });
                                        Get.to(
                                          MarriageMatchesDetails(
                                            boyRasi: boySelectedRasi,
                                            natchathiramGirlValue:
                                                girlSelectedNatchathiram,
                                            natchathiramBoyValue:
                                                boySelectedNatchathiram,
                                            girlRasi: girlSelectedRasi,
                                            boyName: boyName,
                                            girlName: girlName,
                                          ),
                                          transition: Transition.downToUp,
                                          duration: Duration(milliseconds: 500),
                                        );
                                      } else {
                                        setState(() {
                                          isOpen = true;
                                        });
                                        Get.snackbar(
                                          "Hi ${_forumContreller.sessionUserInfo.value['name']} !",
                                          "You missed some fields",
                                          icon: Icon(Icons.person,
                                              color: Colors.white),
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      }
                                    }
                                  : null,
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
                              child: const Text('Find Matches'),
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
