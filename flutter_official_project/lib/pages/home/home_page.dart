import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build HomePage');

    return getWidget();
  }
}

var _tabs = ['动态', '推荐'];

DefaultTabController getWidget() {
  return DefaultTabController(
    initialIndex: 1,
    length: _tabs.length,
    child: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            
          )
        ]
      },
    ),
  );
}
