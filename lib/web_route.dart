import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:core';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

abstract class WebViewRoute extends StatefulWidget {
  //nessaray
  String get url;

  String get routeName => '${this.runtimeType.toString()}';

  String get title => this.routeName;

  String get description => null;

  FlutterWebviewPlugin get flutterWebViewPlugin => FlutterWebviewPlugin();

  @override
  State<StatefulWidget> createState() => _WebViewRouteState();

  Widget buildRouteContent(BuildContext context) => WebviewScaffold(
        url: url,
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: Container(
          color: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
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
      );

  //build appbar
  Widget buildTitleBar(BuildContext context) => null;
}

class _WebViewRouteState extends State<WebViewRoute> {
  // On destroy stream
  StreamSubscription _onDestroy;

  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  StreamSubscription<WebViewHttpError> _onHttpError;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FlutterWebviewPlugin flutterWebViewPlugin;

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin = this.widget.flutterWebViewPlugin;
    flutterWebViewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
      if (mounted) {
        // Actions like show a info toast.
        _scaffoldKey.currentState.showSnackBar(
            const SnackBar(content: const Text('Webview Destroyed')));
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        print('===> url = $url');
      }
    });

    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        print('===>type = ${state.type}, url = ${state.url}');
      }
    });

    _onHttpError =
        flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
      if (mounted) {
        print('===> error = ${error.code}');
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

    this.widget.flutterWebViewPlugin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: this.widget.buildTitleBar(context) ??
              AppBar(
                title: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(this.widget.title),
                ),
              ),
          body: Builder(
            builder: (BuildContext context) {
              return AlwaysAliveWidget(
                  child: this.widget.buildRouteContent(context));
            },
          ),
        ),
        onWillPop: _onBackPress);
  }

  Future<bool> _onBackPress() {
    return Future.value(true);
  }
}

// This widget is always kept alive, so that when tab is switched back, its
// child's state is still preserved.
class AlwaysAliveWidget extends StatefulWidget {
  final Widget child;

  const AlwaysAliveWidget({Key key, @required this.child}) : super(key: key);
  @override
  _AlwaysAliveWidgetState createState() => _AlwaysAliveWidgetState();
}

class _AlwaysAliveWidgetState extends State<AlwaysAliveWidget>
    with AutomaticKeepAliveClientMixin<AlwaysAliveWidget> {
  @override
  Widget build(BuildContext context) {
    return this.widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
