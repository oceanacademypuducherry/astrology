// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:http/http.dart' as http;
//
// class Checking extends StatefulWidget {
//   @override
//   _CheckingState createState() => _CheckingState();
// }
//
// class _CheckingState extends State<Checking> {
//   String assetPDFPath = "";
//   String urlPDFPath = "";
//
//   @override
//   void initState() {
//     super.initState();
//
//     getFileFromAsset("assets/mypdf.pdf").then((f) {
//       setState(() {
//         assetPDFPath = f.path;
//         print(assetPDFPath);
//       });
//     });
//
//     getFileFromUrl(
//             "https://firebasestorage.googleapis.com/v0/b/astrology-7cec1.appspot.com/o/sample1.pdf?alt=media&token=18456878-8f05-49ab-9f00-506ec40934bf")
//         .then((f) {
//       setState(() {
//         urlPDFPath = f.path;
//         print(urlPDFPath);
//       });
//     });
//   }
//
//   Future<File> getFileFromAsset(String asset) async {
//     try {
//       var data = await rootBundle.load(asset);
//       var bytes = data.buffer.asUint8List();
//       var dir = await getApplicationDocumentsDirectory();
//       File file = File("${dir.path}/mypdf.pdf");
//
//       File assetFile = await file.writeAsBytes(bytes);
//       return assetFile;
//     } catch (e) {
//       throw Exception("Error opening asset file");
//     }
//   }
//
//   Future<File> getFileFromUrl(String url) async {
//     try {
//       var data = await http.get(Uri.parse(url));
//       var bytes = data.bodyBytes;
//       var dir = await getApplicationDocumentsDirectory();
//       File file = File("${dir.path}/mypdfonline.pdf");
//
//       File urlFile = await file.writeAsBytes(bytes);
//       return urlFile;
//     } catch (e) {
//       throw Exception("Error opening url file");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Flutter PDF Tutorial"),
//         ),
//         body: Center(
//           child: Builder(
//             builder: (context) => Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 RaisedButton(
//                   color: Colors.amber,
//                   child: Text("Open from URL"),
//                   onPressed: () {
//                     if (urlPDFPath != null) {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   PdfViewPage(path: assetPDFPath)));
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 RaisedButton(
//                   color: Colors.cyan,
//                   child: Text("Open from Asset"),
//                   onPressed: () {
//                     if (assetPDFPath != null) {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   PdfViewPage(path: assetPDFPath)));
//                     }
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class PdfViewPage extends StatefulWidget {
//   final String path;
//
//   const PdfViewPage({required this.path});
//   @override
//   _PdfViewPageState createState() => _PdfViewPageState();
// }
//
// class _PdfViewPageState extends State<PdfViewPage> {
//   int _totalPages = 0;
//   int _currentPage = 0;
//   bool pdfReady = false;
//   late PDFViewController _pdfViewController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Document"),
//       ),
//       body: PDFView(
//         filePath: widget.path,
//         autoSpacing: true,
//         enableSwipe: true,
//         pageSnap: true,
//         swipeHorizontal: true,
//         nightMode: false,
//         onError: (e) {
//           print(e);
//         },
//         onRender: (_pages) {
//           setState(() {
//             _totalPages = _pages!;
//             pdfReady = true;
//           });
//         },
//         onViewCreated: (PDFViewController vc) {
//           _pdfViewController = vc;
//         },
//         // onPageChanged: (int page, int total) {
//         //   setState(() {});
//         // },
//         onPageError: (page, e) {},
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           _currentPage > 0
//               ? FloatingActionButton.extended(
//                   backgroundColor: Colors.red,
//                   label: Text("Go to ${_currentPage - 1}"),
//                   onPressed: () {
//                     _currentPage -= 1;
//                     _pdfViewController.setPage(_currentPage);
//                   },
//                 )
//               : Offstage(),
//           _currentPage + 1 < _totalPages
//               ? FloatingActionButton.extended(
//                   backgroundColor: Colors.green,
//                   label: Text("Go to ${_currentPage + 1}"),
//                   onPressed: () {
//                     _currentPage += 1;
//                     _pdfViewController.setPage(_currentPage);
//                   },
//                 )
//               : Offstage(),
//         ],
//       ),
//     );
//   }
// }

import 'package:astrology_app/pdfapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerPage2 extends StatefulWidget {
  @override
  _PdfViewerPage2State createState() => _PdfViewerPage2State();
}

class _PdfViewerPage2State extends State<PdfViewerPage2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String? localPath;

  @override
  Widget build(BuildContext context) {
    ApiServiceProvider.loadPDF().then((value) {
      setState(() {
        localPath = value;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CodingBoot Flutter PDF Viewer",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: localPath != null
          ? PDFView(
              filePath: localPath,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
