import 'package:flutter/material.dart';


abstract class WebViewRoute extends StatefulWidget {

  String get routeName => '${this.runtimeType.toString()}';

  String get title => this.routeName;

  String get description => null;

  @override
  State<StatefulWidget> createState() => _WebViewRouteState();

  Widget buildRouteContent(BuildContext context);
}

class _WebViewRouteState extends State<WebViewRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(this.widget.title),
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return AlwaysAliveWidget(child: this.widget.buildRouteContent(context));
        },
      ),
    );
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