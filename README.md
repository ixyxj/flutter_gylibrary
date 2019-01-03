### flutter_gylibrary

贵阳图书馆flutter版本

### Update
- 重构代码, 新开webview
```dart
import './web_route.dart';

const String selectUrl =
    'http://agentdockingopac.featurelib.libsou.com/showhome/search/showSearch?schoolId=1697';

class SearchNamePage extends WebViewRoute {
  static const String route = '/search';   

  @override
  String get url => selectUrl;       

  @override
  String get title => '图书检索';
}
```




### Show

![image](https://raw.githubusercontent.com/ixyxj/flutter_gylibrary/master/record.gif)



### Download

pger:https://www.pgyer.com/gylib

### TODO

1. webview back and show empty layout
2. complete iOS app



### Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
