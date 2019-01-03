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
