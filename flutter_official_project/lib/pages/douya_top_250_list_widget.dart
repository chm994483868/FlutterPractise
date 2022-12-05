// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_official_project/bean/subject_entity.dart';
import 'package:flutter_official_project/http/API.dart';
import 'package:flutter_official_project/router.dart';
import 'package:stack_trace/stack_trace.dart';

class DouBanListView extends StatefulWidget {
  const DouBanListView({super.key});

  @override
  State<StatefulWidget> createState() {
    return DouBanState();
  }
}

class DouBanState extends State<DouBanListView> with AutomaticKeepAliveClientMixin {
  List<Subject> subjects = [];
  var api = API();
  var itemHeight = 150.0;

  @override
  void initState() {
    super.initState();

    api.top250((datas) {
      setState(() {
        subjects = datas;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🐑🐑🐑 ${Trace.current().frames[0].member}');

    return Container(
      child: getListViewContainer(),
    );
  }

  getListViewContainer() {
    if (subjects.isEmpty) {
      // loading
      return const CupertinoActivityIndicator();
    }

    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        // item 的数量
        itemCount: subjects.length,
        itemBuilder: (BuildContext context, int index) {
          Subject bean = subjects[index];
          return GestureDetector(
            // Flutter 手势处理
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  numberWidget(index + 1),
                  getItemContainerView(bean),
                  // 下面的灰色分割线
                  Container(
                    height: 10,
                    color: const Color.fromARGB(255, 234, 233, 234),
                  )
                ],
              ),
            ),
            onTap: () {
              // 暂时未开放
              MyRouter.push(context, MyRouter.detailPage, bean.id);
            },
          );
        });
  }

  // 肖申克的救赎(1993) View
  getTitleView(Subject subject) {
//    var title = subject['title'];
//    var year = subject['year'];
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.play_circle_outline,
            color: Colors.redAccent,
          ),
          Text(
            subject.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text('(${subject.year})', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey))
        ],
      ),
    );
  }

  getItemContainerView(Subject subject) {
//    var imgUrl = subject['images']['medium'];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          getImage(subject.images?.medium),
          Expanded(
            child: getMovieInfoView(subject),
            flex: 1,
          )
        ],
      ),
    );
  }

  // 圆角图片
  getImage(var imgUrl) {
    return Container(
      decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover), borderRadius: const BorderRadius.all(Radius.circular(5.0))),
      margin: const EdgeInsets.only(left: 8, top: 3, right: 8, bottom: 3),
      height: itemHeight,
      width: 100.0,
    );
  }

  getStaring(var stars) {
    return Row(
      children: <Widget>[RatingBar(stars), Text('$stars')],
    );
  }

  // 电影标题，星标评分，演员简介 Container
  getMovieInfoView(Subject subject) {
//    var start = subject['rating']['average'];
    return Container(
      height: itemHeight,
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[getTitleView(subject), RatingBar(subject.rating?.average), DescWidget(subject)],
      ),
    );
  }

  // NO.1 图标
  numberWidget(var no) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 255, 201, 129), borderRadius: BorderRadius.all(Radius.circular(5.0))),
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      margin: const EdgeInsets.only(left: 12, top: 10),
      child: Text(
        'No.$no',
        style: const TextStyle(color: Color.fromARGB(255, 133, 66, 0)),
      ),
    );
  }

//
//  Flutter中为了节约内存不会保存widget的状态，widget都是临时变量。当我们使用 TabBar，TabBarView 是我们就会发现，切换 tab 后再重新切换回上一页面，这时候 tab 会重新加载重新创建，体验很不友好。Flutter 出于自己的设计考虑并没有延续 android 的 ViewPager 这样的缓存页面设计，毕竟控件两端都要开发，目前还在 beta 版本有很多设计还不够完善，但是设计的拓展性没得说，flutter 还是为我们提供了解决办法。我们可以强制 widget 不显示情况下保留状态，下回再加载时就不用重新创建了。
//
//  AutomaticKeepAliveClientMixin
//  AutomaticKeepAliveClientMixin 是一个抽象状态，使用也很简单，我们只需要用我们自己的状态继承这个抽象状态，并实现 wantKeepAlive 方法即可。
//
//  继承这个状态后，widget 在不显示之后也不会被销毁仍然保存在内存中，所以慎重使用这个方法。
//  ---------------------
//  作者：唯夜
//  来源：CSDN
//  原文：https://blog.csdn.net/tgbus18990140382/article/details/81181879
//  版权声明：本文为博主原创文章，转载请附上博文链接！

  @override
  bool get wantKeepAlive => true;
}

// 类别、演员介绍
class DescWidget extends StatelessWidget {
  final Subject subject;

  const DescWidget(this.subject, {super.key});

  @override
  Widget build(BuildContext context) {
    // 这里用了一个强制取值
    var casts = subject.casts!;

    var sb = StringBuffer();
    var genres = subject.genres;
    for (var i = 0; i < genres.length; i++) {
      sb.write('${genres[i]}  ');
    }
    sb.write("/ ");
    List<String> list = List.generate(casts.length, (int index) => casts[index].name.toString());

    for (var i = 0; i < list.length; i++) {
      sb.write('${list[i]} ');
    }
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        sb.toString(),
        softWrap: true,
        textDirection: TextDirection.ltr,
        style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 118, 117, 118)),
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final stars;

  const RatingBar(this.stars, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> startList = [];
    // 实心星星
    var startNumber = stars ~/ 2;
    // 半实心星星
    var startHalf = 0;
    if (stars.toString().contains('.')) {
      int tmp = int.parse((stars.toString().split('.')[1]));
      if (tmp >= 5) {
        startHalf = 1;
      }
    }
    // 空心星星
    var startEmpty = 5 - startNumber - startHalf;

    for (var i = 0; i < startNumber; i++) {
      startList.add(const Icon(
        Icons.star,
        color: Colors.amberAccent,
        size: 18,
      ));
    }

    if (startHalf > 0) {
      startList.add(const Icon(
        Icons.star_half,
        color: Colors.amberAccent,
        size: 18,
      ));
    }

    for (var i = 0; i < startEmpty; i++) {
      startList.add(const Icon(
        Icons.star_border,
        color: Colors.grey,
        size: 18,
      ));
    }

    startList.add(Text(
      '$stars',
      style: const TextStyle(
        color: Colors.grey,
      ),
    ));

    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 0, top: 8, right: 0, bottom: 5),
      child: Row(
        children: startList,
      ),
    );
  }
}
