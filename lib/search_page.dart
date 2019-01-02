import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import './web_route.dart';
import './loading_bar.dart';

const String selectUrl =
    'http://agentdockingopac.featurelib.libsou.com/showhome/search/showSearch?schoolId=1697';

class SearchNamePage extends WebViewRoute {
  static const String route = '/search';

  @override
  String get title => '图书检索';

  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  Widget buildRouteContent(BuildContext context) {
    return WebviewScaffold(
      url: selectUrl,
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
    );
  }
}
