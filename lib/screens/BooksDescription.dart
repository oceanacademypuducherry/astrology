import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:flutter/services.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:translator/translator.dart';

class BooksDescription extends StatefulWidget {
  String bookImage;
  String bookName;
  String bookType;
  String description;
  String pdfLink;
  BooksDescription(
      {required this.bookImage,
      required this.bookName,
      required this.description,
      required this.bookType,
      required this.pdfLink});

  @override
  _BooksDescriptionState createState() => _BooksDescriptionState();
}

class _BooksDescriptionState extends State<BooksDescription> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    final FlutterTts flutterTts = FlutterTts();
    // final translator = GoogleTranslator();
    Future _speak() async {
      await flutterTts.setLanguage('ta');
      var result = await flutterTts.speak("காலை வணக்கம்");
      print('$result  playing///////////////////////////////////');
      if (result == 1) setState(() => result = result.playing);
    }

    Future _stop() async {
      var result = await flutterTts.stop();
      if (result == 1) setState(() => result = result.stopped);
    }

    // Future<List<int>> _readDocumentData(String name) async {
    //   final ByteData data = await rootBundle.load('assets/$name');
    //   return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // }
    //
    // Future<void> _extractAllText() async {
    //   //Load the existing PDF document.
    //   PdfDocument document = PdfDocument(
    //       inputBytes: await _readDocumentData('pdf_succinctly.pdf'));
    //
    //   //Create the new instance of the PdfTextExtractor.
    //   PdfTextExtractor extractor = PdfTextExtractor(document);
    //
    //   //Extract all the text from the document.
    //   String text = extractor.extractText();
    //
    //   //Display the text.
    //   // print('Translated: ${await text.translate(to: 'ta')}');
    //   String language = "${await text.translate(to: 'ta')}";
    //   print(language);
    //   _showResult(language);
    // }

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
                                child: Image.network(
                                  widget.bookImage,
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
                                      widget.bookName,
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
                                      widget.bookType,
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
                            OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    isOpen = true;
                                  });
                                  _pdfViewerKey.currentState
                                      ?.openBookmarkView();
                                },
                                child: Text('View Pdf')),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      widget.description,
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
                  ),
                  Visibility(
                    visible: isOpen,
                    child: SingleChildScrollView(
                      child: Container(
                        /// TO make correct height
                        height: 100,
                        child: SfPdfViewer.network(
                          '${widget.pdfLink}',
                          key: _pdfViewerKey,
                        ),
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
