import 'package:astrology_app/Forum/forumController.dart';
import 'package:astrology_app/services/storage_service.dart';
import 'package:astrology_app/widgets/BottomNavigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SomeoneElse extends StatefulWidget {
  String appointmentFor;
  String purpose;
  SomeoneElse({required this.appointmentFor, required this.purpose});

  @override
  _SomeoneElseState createState() => _SomeoneElseState();
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _SomeoneElseState extends State<SomeoneElse> {
  ForumContreller _forumContreller = Get.find<ForumContreller>();
  late Razorpay _razorpay;

  ///controller
  TextEditingController? emailController = TextEditingController();
  TextEditingController? nameController = TextEditingController();
  TextEditingController? phoneNumberController = TextEditingController();

  ///variable
  var getName;
  var getMobileNumber;
  var phoneNumber;
  var getEmail;
  var email;
  var fullname;
  String rupees = " \$50";
  UploadTask? task;
  File? file;
  String? profilePictureLink;
  String? jadhagamLink;
  bool validation = false;

  ///widegts
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

    _razorpay = Razorpay();
    print(_forumContreller.userSession.value);
    print(_forumContreller.sessionUserInfo.value);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    print('************************************************');
    print(_forumContreller.userSession.value);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  ///RAZORPAY START
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _firestore.collection('booking').add({
      'time': Get.arguments,
      'phoneNumber': _forumContreller.userSession.value,
      'email': _forumContreller.sessionUserInfo.value['email'],
      'userName': _forumContreller.sessionUserInfo.value['name'],
      'jadhagam': _forumContreller.sessionUserInfo.value['jadhagam'],
      'payment': rupees,
      'birthTime': _forumContreller.sessionUserInfo.value['birthTime'],
      'birthPlace': _forumContreller.sessionUserInfo.value['birthPlace'],
      'bookingFor': widget.appointmentFor,
      'purposeFor': widget.purpose,
    });
    print('uploaded successfully');

    Get.to(() => BottomNavigation(),
        transition: Transition.rightToLeft,
        curve: Curves.easeInToLinear,
        duration: Duration(milliseconds: 600));
    print(
        '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    print(response.paymentId);
    print(response.orderId);
    print(response.signature);
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response.message);
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response.walletName);
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_live_yI4lHyiI5FRJWt',
      'amount': 100,
      'name': 'OceanAcademy',
      'description': 'Booking Appointment',
      'prefill': {
        'contact': '${_forumContreller.userSession.value}',
        'email': '${_forumContreller.sessionUserInfo.value['email']}'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  ///RAZORPAY END

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          // color: Colors.grey[200],
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
                        GestureDetector(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage('$profilePictureLink'),
                          ),
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
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                              ),
                              onPressed: selectProfileFile,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: selectJadhagamFile,
                      child: Text('Upload Jadhagam'),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(double.infinity, 50),
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 25,
                          ),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Ubuntu',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Text('$fileName'),
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
                    onPressed: () {
                      ///someone else page
                      openCheckout();
                      // Get.to(() => SomeoneElse(),
                      //     transition: Transition.topLevel,
                      //     // curve: Curves.ease,
                      //     duration: Duration(milliseconds: 600));
                    },
                    child: Text('Proceed to Payment'),
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
      jadhagamLink = urlDownload;
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
      profilePictureLink = urlDownload;
    });

    print('Download-Link: $urlDownload');
  }
}
