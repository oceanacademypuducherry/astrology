import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:astrology_app/services/storage_service.dart';
import 'package:astrology_app/widgets/BottomNavigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _ProfileScreenState extends State<ProfileScreen> {
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  UploadTask? task;
  File? file;
  String? email = 'thamizh';
  String? updatedProfile;
  String? updatedJadhagam;

  String? phoneNumber;

  String? fullname;

  bool validation = false;

  TextEditingController? emailController = TextEditingController();
  TextEditingController? nameController = TextEditingController();
  TextEditingController? phoneNumberController = TextEditingController();
  var getName;
  var getMobileNumber;
  var getEmail;
  var getId;

  void edit_profile() async {
    print("---------------------------");
    await for (var snapshot in _firestore
        .collection('newusers')
        .where("PhoneNumber", isEqualTo: _forumContreller.userSession.value)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        getId = message.id;
      }
      print('++++++++++++++++++');
    }

    print("---------------------------");
  }

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
      readOnly: true,
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
      readOnly: true,
      onChanged: (value) {
        phoneNumber = value;
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    edit_profile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: false,
                  expandedHeight: 150,
                  // automaticallyImplyLeading: true,
                  toolbarHeight: 50,
                  // stretch: true,
                  pinned: false,
                  collapsedHeight: 50,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Image.asset(
                      'images/profile1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream:
                                _firestore.collection('newusers').snapshots(),
                            // ignore: missing_return
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                print(
                                    'SSSSSSSSSSSSPPPPPPPPPPPPPPPSSSSSSSSSSSSSSSSSSSSSSSS');
                                return Text("Loading...");
                              } else {
                                final messages = snapshot.data!.docs;
                                for (var message in messages) {
                                  nameController!.text = message['name'];
                                  phoneNumberController!.text =
                                      message['PhoneNumber'];
                                  emailController!.text = message['email'];

                                  final profilePicture = message['profile'];
                                  final jadhagamLink = message['jadhagam'];
                                  getName = nameController!.text;
                                  getEmail = emailController!.text;
                                  getMobileNumber = phoneNumberController!.text;

                                  return Container(
                                    // color: Colors.grey[200],
                                    margin: EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  GestureDetector(
                                                    onTap: selectProfileFile,
                                                    child: CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          updatedProfile == null
                                                              ? '${profilePicture}'
                                                              : '${updatedProfile}'),
                                                      radius: 50,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 5,
                                                    bottom: 5,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            offset: Offset(
                                                                0.5, 0.5),
                                                            color: Colors.grey,
                                                          )
                                                        ],
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      width: 25,
                                                      height: 25,
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.add,
                                                        ),
                                                        onPressed: () {},
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 25),
                                                height: 80,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        getName,
                                                        style: TextStyle(
                                                          letterSpacing: 0.4,
                                                          color: Colors.black54,
                                                          fontSize: 21,
                                                          fontFamily: 'Ubuntu',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        '${getEmail}',
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 13,
                                                          fontFamily: 'Ubuntu',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        '${getMobileNumber}',
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 13,
                                                          fontFamily: 'Ubuntu',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
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
                                          margin: EdgeInsets.only(
                                              right: 20, left: 20, top: 30),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      _firestore
                                                          .collection(
                                                              "newusers")
                                                          .doc(getId)
                                                          .set({
                                                        "name": nameController!
                                                            .text,
                                                        "email":
                                                            emailController!
                                                                .text,
                                                        "jadhagam":
                                                            updatedJadhagam,
                                                        'profile':
                                                            updatedProfile,
                                                        'PhoneNumber':
                                                            phoneNumberController!
                                                                .text
                                                      });
                                                      print(
                                                          'Updated Successfully');
                                                      Get.to(() => BottomNavigation(),
                                                          transition: Transition
                                                              .rightToLeft,
                                                          curve: Curves
                                                              .easeInToLinear,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  600));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 10),
                                                      child: Text(
                                                        'update',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontFamily: 'Ubuntu',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              Stack(
                                                children: [
                                                  GestureDetector(
                                                    onTap: selectJadhagamFile,
                                                    child: CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          updatedJadhagam ==
                                                                  null
                                                              ? '${jadhagamLink}'
                                                              : '${updatedJadhagam}'),
                                                      radius: 50,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 5,
                                                    bottom: 5,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            offset: Offset(
                                                                0.5, 0.5),
                                                            color: Colors.grey,
                                                          )
                                                        ],
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
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
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                alignment: Alignment.centerLeft,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 20),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              offset: Offset(
                                                                  0.1, 0.2),
                                                            )
                                                          ],
                                                          color:
                                                              Colors.grey[100],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        height: 40,
                                                        width: 100,
                                                        child: Text(
                                                          'Wed 1 Jul',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 20),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              offset: Offset(
                                                                  0.1, 0.2),
                                                            )
                                                          ],
                                                          color:
                                                              Colors.grey[100],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        height: 40,
                                                        width: 100,
                                                        child: Text(
                                                          'Wed 1 Jul',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 20),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              offset: Offset(
                                                                  0.1, 0.2),
                                                            )
                                                          ],
                                                          color:
                                                              Colors.grey[100],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        height: 40,
                                                        width: 100,
                                                        child: Text(
                                                          'Wed 1 Jul',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 20),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              offset: Offset(
                                                                  0.1, 0.2),
                                                            )
                                                          ],
                                                          color:
                                                              Colors.grey[100],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        height: 40,
                                                        width: 100,
                                                        child: Text(
                                                          'Wed 1 Jul',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
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
                                  );
                                }
                                return Container(
                                    child: Text('jayalathahahjgj'));
                              }
                            },
                          ),
                        ],
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future selectJadhagamFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
    setState(() {
      uploadJadhagam();
    });
  }

  Future uploadJadhagam() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'jadhagam/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {
      print('profile picture uploaded');
    });
    final urlDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      updatedJadhagam = urlDownload;
    });

    print('Download-Link: $urlDownload');
  }

  Future selectProfileFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
    setState(() {
      uploadProfile();
    });
  }

  Future uploadProfile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'profile/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {
      print('profile picture uploaded');

      ///Todo snakbar upload
    });
    final urlDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      updatedProfile = urlDownload;
      // profilePicture = updatedProfile;
    });

    // setState(() {
    //
    // });

    print('Download-Link: $urlDownload');
  }
}
