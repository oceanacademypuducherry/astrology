import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewIntegration extends StatefulWidget {
  @override
  _WebViewIntegrationState createState() => _WebViewIntegrationState();
}

class _WebViewIntegrationState extends State<WebViewIntegration> {
  // late WebViewController _controller;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Article'),
        ),
        body: SafeArea(
          child: WebView(
            initialUrl:
                'https://oceanacademypuducherry.blogspot.com/2021/08/lorem-ipsum-simply-dummy-text-of.html',
            javascriptMode: JavascriptMode.disabled,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          ),
        ));
  }
}
