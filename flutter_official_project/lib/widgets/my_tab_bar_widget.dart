import 'package:flutter/material.dart';
import 'package:flutter_official_project/pages/douya_top_250_list_widget.dart';
import 'package:flutter_official_project/pages/movie/movie_page_new.dart';
import 'package:stack_trace/stack_trace.dart';

// import 'package:doubanapp/pages/douya_top_250_list_widget.dart';
// import 'package:doubanapp/pages/movie/movie_page.dart';

class FlutterTabBarView extends StatelessWidget {
  final TabController tabController;

  const FlutterTabBarView({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    debugPrint('🐑🐑🐑 ${Trace.current().frames[0].member}');

    var viewList = [
      MoviePage(key: const PageStorageKey<String>('MoviePage'),),
      const Page2(),
      const DouBanListView(key: PageStorageKey<String>('DouBanListView'),),
      const Page4(),
      const Page5(),
      const Page1(),
    ];

    return TabBarView(
      controller: tabController,
      children: viewList,
    );

    // return const Text('123');
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('🐑🐑🐑 ${Trace.current().frames[0].member}');

    return const Center(
      child: Text('Page1'),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('🐑🐑🐑 ${Trace.current().frames[0].member}');

    return const Center(
      child: Text('Page2'),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('🐑🐑🐑 ${Trace.current().frames[0].member}');

    return const Center(
      child: Text('Page3'),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('🐑🐑🐑 ${Trace.current().frames[0].member}');

    return const Center(
      child: Text('Page4'),
    );
  }
}

class Page5 extends StatelessWidget {
  const Page5({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('🐑🐑🐑 ${Trace.current().frames[0].member}');

    return const Center(
      child: Text('Page5'),
    );
  }
}
