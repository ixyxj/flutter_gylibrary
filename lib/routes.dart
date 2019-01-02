import 'package:flutter/material.dart';
import './search_page.dart';
import './home_page.dart';

Map<String, WidgetBuilder> routes = {
  HomePage.route: (BuildContext context) => HomePage(),
  SearchNamePage.route: (BuildContext context) => SearchNamePage()
};
