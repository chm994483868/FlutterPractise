import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String url1 = 'https://flutterchina.club/';
String url2 = 'http://flutterall.com/';
bool _closed = false;
bool _isShow = true;

/// 提供链接到一个唯一 webview 的单例实例，以便您可以从应用程序的任何位置控制 webview
final _webviewReference = FlutterWebviewPlugin();

/// 市集 市集使用两个 webview 代替，因为豆瓣中这个就是 WebView
class ShopPageWidget extends StatelessWidget {
  const ShopPageWidget({super.key});

  void setShowState(bool isShow) {
    _isShow = isShow;
    if (!isShow) {
      _closed = true;
      _webviewReference.hide();
      _webviewReference.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const WebViewPageWidget();
  }
}

class WebViewPageWidget extends StatefulWidget {
  const WebViewPageWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WebViewPageWidgetState createState() => _WebViewPageWidgetState();
}

class _WebViewPageWidgetState extends State<WebViewPageWidget> with SingleTickerProviderStateMixin {
  var list = ['豆芽豆品', '豆芽时间'];
  int selectIndex = 0;
  Color selectColor, unselectColor;
  TextStyle selectStyle, unselectedStyle;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    debugPrint('_ShopPageWidgetState initState');

    _webviewReference.close();
    tabController = new TabController(length: list.length, vsync: this);
    selectColor = Colors.green;
    unselectColor = Color.fromARGB(255, 117, 117, 117);
    selectStyle = TextStyle(fontSize: 18);
    unselectedStyle = TextStyle(fontSize: 18);
    _webviewReference.onUrlChanged.listen((url) {
      if (url != url1 || url != url2) {
        debugPrint('new Url = $url');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('_ShopPageWidgetState dispose');

    tabController.dispose();
    _webviewReference.close();
    _webviewReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isShow) {
      return Container();
    }

    return Container(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TabBar(
                      tabs: list.map((item) => Text(item)).toList(),
                      isScrollable: false,
                      controller: tabController,
                      indicatorColor: selectColor,
                      labelColor: selectColor,
                      labelStyle: selectStyle,
                      unselectedLabelColor: unselectColor,
                      unselectedLabelStyle: unselectedStyle,
                      indicatorSize: TabBarIndicatorSize.label,
                      onTap: (selectIndex) {
                        this.selectIndex = selectIndex;
                        _webviewReference.reloadUrl(selectIndex == 0 ? url1 : url2);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
            Expanded(
              child: _WebViewWidget(selectIndex == 0 ? url1 : url2),
            )
          ],
        ),
      ),
      color: Colors.white,
    );
  }
}