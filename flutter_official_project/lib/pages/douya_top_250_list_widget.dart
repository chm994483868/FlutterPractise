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
    debugPrint('πππ ${Trace.current().frames[0].member}');

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
        // item ηζ°ι
        itemCount: subjects.length,
        itemBuilder: (BuildContext context, int index) {
          Subject bean = subjects[index];
          return GestureDetector(
            // Flutter ζεΏε€η
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  numberWidget(index + 1),
                  getItemContainerView(bean),
                  // δΈι’ηη°θ²εε²ηΊΏ
                  Container(
                    height: 10,
                    color: const Color.fromARGB(255, 234, 233, 234),
                  )
                ],
              ),
            ),
            onTap: () {
              // ζζΆζͺεΌζΎ
              MyRouter.push(context, MyRouter.detailPage, bean.id);
            },
          );
        });
  }

  // θη³εηζθ΅(1993) View
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

  // εθ§εΎη
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

  // η΅ε½±ζ ι’οΌζζ θ―εοΌζΌεη?δ» Container
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

  // NO.1 εΎζ 
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
//  FlutterδΈ­δΈΊδΊθηΊ¦εε­δΈδΌδΏε­widgetηηΆζοΌwidgetι½ζ―δΈ΄ζΆειγε½ζδ»¬δ½Ώη¨ TabBarοΌTabBarView ζ―ζδ»¬ε°±δΌεη°οΌεζ’ tab εειζ°εζ’εδΈδΈι‘΅ι’οΌθΏζΆε tab δΌιζ°ε θ½½ιζ°εε»ΊοΌδ½ιͺεΎδΈεε₯½γFlutter εΊδΊθͺε·±ηθ?Ύθ?‘θθεΉΆζ²‘ζε»Άη»­ android η ViewPager θΏζ ·ηηΌε­ι‘΅ι’θ?Ύθ?‘οΌζ―η«ζ§δ»ΆδΈ€η«―ι½θ¦εΌεοΌη?εθΏε¨ beta ηζ¬ζεΎε€θ?Ύθ?‘θΏδΈε€ε?εοΌδ½ζ―θ?Ύθ?‘ηζε±ζ§ζ²‘εΎθ―΄οΌflutter θΏζ―δΈΊζδ»¬ζδΎδΊθ§£ε³εζ³γζδ»¬ε―δ»₯εΌΊεΆ widget δΈζΎη€Ίζε΅δΈδΏηηΆζοΌδΈεεε θ½½ζΆε°±δΈη¨ιζ°εε»ΊδΊγ
//
//  AutomaticKeepAliveClientMixin
//  AutomaticKeepAliveClientMixin ζ―δΈδΈͺζ½θ±‘ηΆζοΌδ½Ώη¨δΉεΎη?εοΌζδ»¬εͺιθ¦η¨ζδ»¬θͺε·±ηηΆζη»§ζΏθΏδΈͺζ½θ±‘ηΆζοΌεΉΆε?η° wantKeepAlive ζΉζ³ε³ε―γ
//
//  η»§ζΏθΏδΈͺηΆζεοΌwidget ε¨δΈζΎη€ΊδΉεδΉδΈδΌθ’«ιζ―δ»ηΆδΏε­ε¨εε­δΈ­οΌζδ»₯ζιδ½Ώη¨θΏδΈͺζΉζ³γ
//  ---------------------
//  δ½θοΌε―ε€
//  ζ₯ζΊοΌCSDN
//  εζοΌhttps://blog.csdn.net/tgbus18990140382/article/details/81181879
//  ηζε£°ζοΌζ¬ζδΈΊεδΈ»εεζη« οΌθ½¬θ½½θ―·ιδΈεζιΎζ₯οΌ

  @override
  bool get wantKeepAlive => true;
}

// η±»ε«γζΌεδ»η»
class DescWidget extends StatelessWidget {
  final Subject subject;

  const DescWidget(this.subject, {super.key});

  @override
  Widget build(BuildContext context) {
    // θΏιη¨δΊδΈδΈͺεΌΊεΆεεΌ
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
    // ε?εΏζζ
    var startNumber = stars ~/ 2;
    // εε?εΏζζ
    var startHalf = 0;
    if (stars.toString().contains('.')) {
      int tmp = int.parse((stars.toString().split('.')[1]));
      if (tmp >= 5) {
        startHalf = 1;
      }
    }
    // η©ΊεΏζζ
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
