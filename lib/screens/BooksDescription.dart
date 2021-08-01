import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BooksDescription extends StatefulWidget {
  const BooksDescription({Key? key}) : super(key: key);

  @override
  _BooksDescriptionState createState() => _BooksDescriptionState();
}

class _BooksDescriptionState extends State<BooksDescription> {
  @override
  Widget build(BuildContext context) {
    final FlutterTts flutterTts = FlutterTts();
    // Future speak() async {
    //   print(await BooksDescription.flutterTts.getLanguages);
    //   await BooksDescription.flutterTts.setLanguage('ta');
    //   await BooksDescription.flutterTts.setPitch(1);
    //   print(await BooksDescription.flutterTts.getVoices);
    //   await BooksDescription.flutterTts.speak("காலை வணக்கம்");
    // }

    Future _speak() async {
      await flutterTts.setLanguage('ta');
      var result = await flutterTts.speak(
          "காலை வணக்கம் காலை வணக்கம் காலை வணக்கம் காலை வணக்கம் காலை வணக்கம்");
      print('$result  playing///////////////////////////////////');
      if (result == 1) setState(() => result = result.playing);
    }

    Future _stop() async {
      var result = await flutterTts.stop();
      if (result == 1) setState(() => result = result.stopped);
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        splashRadius: 10,
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 180,
                                width: 130,
                                child: Image.asset(
                                  'images/books/book2.jpg',
                                  fit: BoxFit.cover,

                                  // alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              height: 55,
                              width: 140,
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'The Broken Circle ',
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: 14,
                                        height: 1.3,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Ubuntu",
                                        letterSpacing: 0.6,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'BY GURUJI',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 10,
                                        fontFamily: "Ubuntu",
                                        letterSpacing: 0.4,
                                        height: 1,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Free',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 10,
                                        fontFamily: "Ubuntu",
                                        letterSpacing: 0.4,
                                        height: 1,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            OutlinedButton(
                                onPressed: () => _speak(),
                                child: Text('PreView')),
                            OutlinedButton(
                                onPressed: () => _stop(),
                                child: Text('PreView')),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has"
                      " been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley "
                      "of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also "
                      "the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with "
                      "the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software "
                      "like Aldus PageMaker including versions of Lorem Ipsum."
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has"
                      " been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley "
                      "of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also "
                      "the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with "
                      "the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software "
                      "like Aldus PageMaker including versions of Lorem Ipsum.",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 14,
                        height: 1.6,
                        fontWeight: FontWeight.normal,
                        // fontStyle: FontStyle.italic,
                        fontFamily: "Ubuntu",
                        letterSpacing: 0.6,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
