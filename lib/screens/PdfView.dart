import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class PdfView extends StatefulWidget {
  String pdfLink;
  String appBarName;
  PdfView({required this.pdfLink, required this.appBarName});
  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.appBarName}'),
      ),
      body: SfPdfViewer.network(
        '${widget.pdfLink}',
        // key: _pdfViewerKey,
      ),
    );
  }
}

class PDFViewerPage extends StatefulWidget {
  final File file;

  const PDFViewerPage({
    required this.file,
  });

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PDFViewController controller;

  late String urlPDFPath;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = '${indexPage + 1} of $pages';
    bool pdfReady = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        // actions: pages >= 2
        //     ? [
        //         Center(child: Text(text)),
        //         IconButton(
        //           icon: Icon(Icons.chevron_left, size: 32),
        //           onPressed: () {
        //             final page = indexPage == 0 ? pages : indexPage - 1;
        //             controller.setPage(page);
        //           },
        //         ),
        //         IconButton(
        //           icon: Icon(Icons.chevron_right, size: 32),
        //           onPressed: () {
        //             final page = indexPage == pages - 1 ? 0 : indexPage + 1;
        //             controller.setPage(page);
        //           },
        //         ),
        //       ]
        //     : null,
      ),
      body: widget.file.path != null
          ? PDFView(
              filePath: widget.file.path,
              autoSpacing: false,
              swipeHorizontal: true,
              pageSnap: false,
              pageFling: false,

              onRender: (pages) => setState(() {
                pdfReady = true;
              }),

              // onViewCreated: (controller) =>
              //     setState(() => this.controller = controller),
              // onPageChanged: (indexPage, _) =>
              //     setState(() => this.indexPage = indexPage!),
            )
          : CircularProgressIndicator(),
    );
  }

  Future<File> getFileFromUrl(url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdfonline.pdf");

      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }
}
