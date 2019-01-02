import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import './search_page.dart';
import './loading_bar.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

String selectedUrl = 'http://m.superlib.com/';

class HomePage extends StatefulWidget {
  static const String route = '/';
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  // On destroy stream
  StreamSubscription _onDestroy;

  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  StreamSubscription<WebViewHttpError> _onHttpError;

  final _urlCtrl = TextEditingController(text: selectedUrl);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
    void initState() {
      super.initState();

      flutterWebViewPlugin.close();

      _urlCtrl.addListener(() {
        selectedUrl = _urlCtrl.text;
      });

      // Add a listener to on destroy WebView, so you can make came actions.
      _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
        if (mounted) {
          // Actions like show a info toast.
          _scaffoldKey.currentState.showSnackBar(const SnackBar(content: const Text('Webview Destroyed')));
        }
      });

      // Add a listener to on url changed
      _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
        if (mounted) {
          setState(() {
          });
        }
      });

      _onStateChanged = flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
        if (mounted) {
          setState(() {
          });
        }
      });

      _onHttpError = flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
        if (mounted) {
          setState(() {
          });
        }
      });
    }
  @override
    void dispose() {
      // Every listener should be canceled, the same should be done with this stream.
      _onDestroy.cancel();
      _onUrlChanged.cancel();
      _onStateChanged.cancel();
      _onHttpError.cancel();

      flutterWebViewPlugin.dispose();

      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('贵阳图书馆'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, SearchNamePage.route);
            },
          )
        ],
      ),
      body: WebviewScaffold(
        url: selectedUrl,
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: LoadingBar.show(context),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  flutterWebViewPlugin.goBack();
                },
              ),
              IconButton(
                icon: const Icon(Icons.autorenew),
                onPressed: () {
                  flutterWebViewPlugin.reload();
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  flutterWebViewPlugin.goForward();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}