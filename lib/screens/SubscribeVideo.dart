import 'package:astrology_app/screens/PaidVedios.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscribeVideoScreen extends StatelessWidget {
  const SubscribeVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff045de9),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff045de9),
              Colors.blue,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Access all Premium Videos on Astro',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Ubuntu',
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Choose from hundreds of guided meditations, inspirational speeches, binaural tracks and much, much more.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.4,
                  height: 1.2,
                  fontFamily: 'Ubuntu',
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: AssetImage('images/s.jpg'),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: 270,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => PaidVedios(),
                              // transition: Transition.cupertinoDialog,
                              fullscreenDialog: true,
                              curve: Curves.easeInToLinear,
                              duration: Duration(milliseconds: 600));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Start Your lifetime access video',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Ubuntu',
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Then 5,400.00/lifeTime',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Ubuntu',
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Text(
                        "YouTube Premium is a paid membership, available in certain countries, that gives you an ad-free, "
                        "feature-rich (offline viewing), and enhanced experience across many of Google's video and music services, "
                        "like YouTube, YouTube Music, YouTube Gaming, and YouTube Kids",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Ubuntu',
                          fontSize: 10,
                          color: Colors.black54,
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
    );
  }
}
