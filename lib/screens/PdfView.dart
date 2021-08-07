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
              pinned: true,
              collapsedHeight: 50,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'See Pdf',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                background: Image.asset(
                  'images/background_image.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: SfPdfViewer.network(
                    '${widget.pdfLink}',
                    // key: _pdfViewerKey,
                  ),
                );
              }, childCount: 1),
            ),
          ],
        ),
      ),
    );
  }
}
