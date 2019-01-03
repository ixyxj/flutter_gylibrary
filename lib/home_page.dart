import 'package:flutter/material.dart';
import './search_page.dart';
import './web_route.dart';

String selectedUrl = 'http://m.superlib.com/';

class HomePage extends WebViewRoute {
  @override
  String get url => selectedUrl;

  static const String route = '/';

  @override
  Widget buildTitleBar(BuildContext context) {
    return AppBar(
      title: Text('贵阳图书馆'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            _navigateAndReload(context);
          },
        )
      ],
    );
  }

  _navigateAndReload(BuildContext context) async {
    final result = Navigator.pushNamed(
      context,
      SearchNamePage.route,
    );

    if (result != null) {
      this.flutterWebViewPlugin.close();
    }
  }
}
