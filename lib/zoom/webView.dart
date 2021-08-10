import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewIntegration extends StatefulWidget {
  @override
  _WebViewIntegrationState createState() => _WebViewIntegrationState();
}

class _WebViewIntegrationState extends State<WebViewIntegration> {
  late WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('zoom Integration'),
        ),
        body: SafeArea(
          child: WebView(
            initialUrl:
                'https://us02web.zoom.us/j/88982175765?pwd=bldhd2pWbkNtSzVQTTM0WHF6dmM5UT09',
            javascriptMode: JavascriptMode.disabled,
            onWebViewCreated: (WebViewController web) {
              _controller = web;
            },
          ),
        ));
  }
}
