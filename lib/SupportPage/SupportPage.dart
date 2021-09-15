import 'package:astrology_app/screens/HomeScreen.dart';
import 'package:astrology_app/screens/ProfileScreen.dart';
import 'package:astrology_app/widgets/BottomNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Get.offAll(BottomNavigation());
          },
          child: Icon(
            Icons.home,
            color: Colors.blue.shade900,
            size: 30,
          ),
        ),
        body: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images8.alphacoders.com/379/379448.jpg'),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
                color: Colors.blue[200],
              ),
              width: context.screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Image.asset('images/border.png'),
                        ),
                        "For Query/Information".text.xl3.make(),
                        Container(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SupportField(
                                    fieldName: "Name",
                                    fieldValue: "S. Arichandran"),
                                SupportField(
                                    fieldName: "Company",
                                    fieldValue: "Makarajothi Astro Labs"),
                                SupportField(
                                    fieldName: "Mobile Number",
                                    fieldValue: "+91 1234567890"),
                                SupportField(
                                    fieldName: "Contact Time",
                                    fieldValue: "9 AM to 6 PM"),
                                SupportField(
                                    fieldName: "Address",
                                    fieldValue: "Coimbatore, Tamilnadu"),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Image.asset('images/border.png'),
                        ),
                      ],
                    )
                        .box
                        .width(context.screenWidth - 40)
                        .height(context.screenHeight - 160)
                        .white
                        .make()
                        .cornerRadius(10),
                  ),
                ],
              )),
        ));
  }

  Container SupportField({fieldName, fieldValue}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(fieldName).text.coolGray400.xl.make().py8(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(fieldValue).text.xl2.coolGray700.make().box.make(),
          ),
          Divider(
            thickness: 2,
          )
        ],
      ),
    );
  }
}
