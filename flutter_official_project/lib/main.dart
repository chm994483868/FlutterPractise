// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_official_project/http/API.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '我的课程'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void testgetTodayPlay() {
    // 测试网络数据请求
    API().getTodayPlay((value) {
      print('API getTodayPlay 数据请求成功: $value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                child: _getItem(),
                onTap: () {
                  // print('🍉🍉🍉：$index');
                  testgetTodayPlay();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Card(
            child: Image(
          image: AssetImage('images/tomcat.png'),
          width: 140.0,
        )),
        const Padding(
          padding: EdgeInsets.all(5.0),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                '2020 年《初级会计实务》精讲视频，如果标题特别长的话会怎么样呢！，哦哦哦，原来你会自动换行呀，如果内容超级长呢，你会怎么样呢？，哦哦哦，你会一直延伸，那如果，限制最大两行呢？',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
              Text(
                '已学习',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    );
  }

  // Widget _getHomeItem() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       const Card(
  //         child: Image(
  //           image: AssetImage('images/home.png'),
  //           width: 200,
  //         ),
  //       ),
  //       const Padding(
  //         padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
  //       ),
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[Text('推荐'), Text('4399 人学习')],
  //       ),
  //     ],
  //   );
  // }
}
