import 'package:flutter/material.dart';

class LoadingBar {
  factory LoadingBar(BuildContext context) => getInstance(context);

  static LoadingBar getInstance(BuildContext context) {
    if (_instance == null) {
      _instance = LoadingBar._internal(context);
    }
    return _instance;
  }

  static LoadingBar _instance;
  LoadingBar._internal(this.context);

  final BuildContext context;

  static Widget show(BuildContext context) => Container(
        color: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
