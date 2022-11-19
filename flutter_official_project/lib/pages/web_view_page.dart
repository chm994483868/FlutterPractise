import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatelessWidget {
  final String url;
  final dynamic params;
  // ignore: constant_identifier_names
  static const String TITLE = 'title';

  const WebViewPage(this.url, this.params, {super.key});

  // final _webviewReference = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    // _webviewReference.close();
    // _webviewReference.dispose();

    return WebviewScaffold(
      url: url,
      appBar: AppBar(
        title: Text(params[TITLE]),
        backgroundColor: Colors.green,
      ),
    );
  }
}
