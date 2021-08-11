import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatefulWidget {
  String pdfLink;
  String appBarName;
  PdfView({required this.pdfLink, required this.appBarName});
  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
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
