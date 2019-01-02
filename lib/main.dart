import 'package:flutter/material.dart';
import './routes.dart';
import './home_page.dart';



void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '贵阳图书馆',
      theme: ThemeData(
        primarySwatch: ThemeData.light().primaryColor,
      ),
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('zh', 'ZH'), // Chinese
        // ... other locales the app supports
      ],
      initialRoute: HomePage.route,
      routes: routes,
    );
  }
}
