// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewIntegration extends StatefulWidget {
//   @override
//   _WebViewIntegrationState createState() => _WebViewIntegrationState();
// }
//
// class _WebViewIntegrationState extends State<WebViewIntegration> {
//   // late WebViewController _controller;
//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('zoom Integration'),
//         ),
//         body: SafeArea(
//           child: WebView(
//             initialUrl: 'https://www.digitalocean.com',
//             javascriptMode: JavascriptMode.disabled,
//             onWebViewCreated: (WebViewController webViewController) {
//               _controller.complete(webViewController);
//             },
//           ),
//         ));
//   }
// }
