import 'package:flutter/material.dart';

// import 'package:doubanapp/pages/douya_top_250_list_widget.dart';
// import 'package:doubanapp/pages/movie/movie_page.dart';

class FlutterTabBarView extends StatelessWidget {
  final TabController tabController;

  const FlutterTabBarView({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    debugPrint('build FlutterTabBarView');

    // var viewList = [
    //   MoviePage(key: const PageStorageKey<String>('MoviePage'),),
    //   Page2(),
    //   DouBanListView(key: const PageStorageKey<String>('DouBanListView'),),
    //   Page4(),
    //   Page5(),
    //   Page1(),
    // ];

    // return TabBarView(
    //   children: viewList,
    //   controller: tabController,
    // );

    return const Text('123');
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build Page1');

    return const Center(
      child: Text('Page1'),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build Page2');

    return const Center(
      child: Text('Page2'),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build Page3');

    return const Center(
      child: Text('Page3'),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build Page4');

    return const Center(
      child: Text('Page4'),
    );
  }
}

class Page5 extends StatelessWidget {
  const Page5({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build Page5');

    return const Center(
      child: Text('Page5'),
    );
  }
}
