import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AcceptableUseScreen extends StatefulHookWidget {
  static const String id = 'accept';

  @override
  _AcceptableUseScreenState createState() => _AcceptableUseScreenState();
}

class _AcceptableUseScreenState extends State<AcceptableUseScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  int indexPosition = 1;
  final key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              indexPosition = 0;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          // onNavigationRequest: (NavigationRequest request) {
          //   // return null;
          //   // if (request.url.startsWith('https://www.youtube.com/')) {
          //   //   return NavigationDecision.prevent;
          //   // }
          //   // return NavigationDecision.navigate;
          // },
        ),
      )
      ..loadRequest(
          Uri.parse('https://mmaflashcards.com/Acceptable-Use-Policy'));
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 00,
          elevation: 0.0,
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          //   icon: Icon(
          //     Icons.arrow_back_ios,
          //     color: Colors.black,
          //   ),
          // ),
          // foregroundColor: Colors.black87,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            IndexedStack(index: indexPosition, children: [
              WebViewWidget(controller: controller),
              Container(
                child: Center(child: CircularProgressIndicator()),
              )
            ]),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.centerLeft,
                color: Colors.white,
                height: scaler.scalerH(40),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: scaler.scalerH(15), top: scaler.scalerV(10)),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
