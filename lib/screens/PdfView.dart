import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatefulWidget {
  String pdfLink;
  PdfView({required this.pdfLink});
  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('VIEW PDF'),
      ),
      body: SfPdfViewer.network(
        '${widget.pdfLink}',
        // key: _pdfViewerKey,
      ),
    );
  }
}
