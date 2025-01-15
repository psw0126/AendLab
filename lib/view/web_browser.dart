import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../preference.dart';
// import 'package:flutter_webview_pro/webview_flutter.dart';

class WebBrowserCommunityPage extends StatefulWidget {
  final Map args;

  WebBrowserCommunityPage({Key? key, required this.args}) : super(key: key);

  @override
  _WebBrowserCommunityPageState createState() => _WebBrowserCommunityPageState();
}

class _WebBrowserCommunityPageState extends State<WebBrowserCommunityPage> {
  // final SharedPreferences pref = SharedPreferences.getInstance() as SharedPreferences;
  late Preference _preference;
  late WebViewController _controller;
  String? token;
  String? uri;

  @override
  void initState() {
    token = this.widget.args['token'];
    uri = this.widget.args['uri'];
    super.initState();
    // WidgetsFlutterBinding.ensureInitialized();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                          child: WillPopScope(
                              onWillPop: () => _goBack(context),
                              child: WebView(
                                initialUrl: uri,
                                onWebViewCreated:
                                    (WebViewController webViewController) {
                                  _controller = webViewController;
                                },
                                javascriptMode: JavascriptMode.unrestricted,
                                javascriptChannels: Set.from([
                                  JavascriptChannel(
                                      name: 'JavaScriptChannel',
                                      onMessageReceived:
                                          (JavascriptMessage message) {
                                        switch (message.message) {
                                          case 'close':
                                            Modular.to.pop();
                                            break;
                                        }
                                      })
                                ]),
                              ))),
                    ),
                  ],
                ),
              ),
        ),
      );
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
