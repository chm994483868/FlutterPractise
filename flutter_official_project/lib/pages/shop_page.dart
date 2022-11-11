import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_official_project/util/screen_utils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String url1 = 'https://flutterchina.club/';
String url2 = 'http://flutterall.com/';
bool _closed = false;
bool _isShow = true;

/// 提供链接到一个唯一 WebView 的单例实例，以便你可以从应用程序的任何位置控制 webview
final _webviewReference = FlutterWebviewPlugin();

/// 市集使用两个 webview 代替，因为豆瓣中这个就是 WebView
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
  late Color selectColor, unselectColor;
  late TextStyle selectStyle, unselectedStyle;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    debugPrint('_ShopPageWidgetState initState');

    _webviewReference.close();
    tabController = TabController(length: list.length, vsync: this);
    selectColor = Colors.green;
    unselectColor = const Color.fromARGB(255, 117, 117, 117);
    selectStyle = const TextStyle(fontSize: 18);
    unselectedStyle = const TextStyle(fontSize: 18);

    /// 这个是？
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
      color: Colors.white,
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
                        debugPrint('select=$selectIndex');
                        this.selectIndex = selectIndex;
                        debugPrint('_closed=$_closed');

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
    );
  }
}

class _WebViewWidget extends StatefulWidget {
  final String url;

  const _WebViewWidget(this.url, {Key? key}) : super(key: key);

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<_WebViewWidget> {
  Rect? _rect;
  bool needFullScreen = false;

  @override
  void initState() {
    super.initState();
    _webviewReference.close();
  }

  @override
  void dispose() {
    super.dispose();

    _webviewReference.close();
    _webviewReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build widget.url=${widget.url}');

    return _WebviewPlaceholder(
      onRectChanged: (value) {
        if (_rect == null || _closed) {
          if (_rect != value) {
            _rect = value;
          }
          debugPrint('_webviewReference.launch');
          _webviewReference.launch(widget.url, withJavascript: true, withLocalStorage: true, scrollBar: true, rect: getRect());
        } else {
          if (_rect != value) {
            _rect = value;
          }
          _webviewReference.reloadUrl(widget.url);
        }
      },
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  getRect() {
    if (needFullScreen) {
      return null;
    } else {
      return Rect.fromLTRB(0.0, ScreenUtils.getStatusBarH(context) + 60.0, ScreenUtils.screenW(context), ScreenUtils.screenH(context) - 60.0);
    }
  }
}

class _WebviewPlaceholder extends SingleChildRenderObjectWidget {
  const _WebviewPlaceholder({Key? key, required this.onRectChanged, required Widget child}) : super(key: key, child: child);

  final ValueChanged<Rect> onRectChanged;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _WebviewPlaceholderRender(onRectChanged: onRectChanged);
  }

  @override
  void updateRenderObject(BuildContext context, _WebviewPlaceholderRender renderObject) {
    renderObject.onRectChanged = onRectChanged;
  }
}

class _WebviewPlaceholderRender extends RenderProxyBox {
  _WebviewPlaceholderRender({RenderBox? child, required ValueChanged<Rect> onRectChanged})
      : _callback = onRectChanged,
        super(child);

  ValueChanged<Rect> _callback;
  late Rect _rect;
  Rect get rect => _rect;

  set onRectChanged(ValueChanged<Rect> callback) {
    if (callback != _callback) {
      _callback = callback;
      notifyRect();
    }
  }

  void notifyRect() {
    _callback(_rect);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    final rect = offset & size;
    if (_rect != rect) {
      _rect = rect;
      notifyRect();
    }
  }
}
