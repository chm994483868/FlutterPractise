// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_official_project/bean/subject_entity.dart';
import 'package:flutter_official_project/constant/constant.dart';
import 'package:flutter_official_project/http/API.dart';
// ignore: unused_import
import 'package:flutter_official_project/http/http_request.dart';
import 'package:flutter_official_project/http/mock_request.dart';
import 'package:flutter_official_project/router.dart';
import 'package:flutter_official_project/widgets/image/radius_img.dart';
import 'package:flutter_official_project/widgets/loading_widget.dart';
import 'package:flutter_official_project/widgets/search_text_field_widget.dart';

// 小组
class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    String hintText = '搜索书影音 小组 日记 用户等';

    // return const Text('GROUP WAITING...');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          SearchTextFieldWidget(
            enabled: true,
            margin: const EdgeInsets.all(Constant.MARGIN_RIGHT),
            hintText: hintText,
            onTap: () {
              // 暂时未开放
              MyRouter.push(context, MyRouter.searchPage, hintText);
            },
          ),
          Expanded(
            child: _GroupWidget(),
          )
        ],
      )),
    );
  }
}

class _GroupWidget extends StatefulWidget {
  @override
  _GroupWidgetState createState() => _GroupWidgetState();
}

// var _request = HttpRequest(API.BASE_URL);
var _request = MockRequest();

class _GroupWidgetState extends State<_GroupWidget> {
  List<Subject>? list;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    
    // 请求正在热映的数据
    Future(() {
      return _request.get(API.IN_THEATERS);
    }).then((result) {
      var resultList = result['subjects'];
      setState(() {
        loading = false;
        if (resultList != null) {
          list = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
        } else {
          list = null;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget.containerLoadingBody(_getBody(), loading: loading);
  }

  Widget _getBody() {
    // ignore: unnecessary_null_comparison
    if (list == null) {
      return Container(
        // ignore: prefer_interpolation_to_compose_strings
        child: Image.asset(Constant.ASSETS_IMG + 'ic_group_top.png'),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          // ignore: prefer_interpolation_to_compose_strings
          return Image.asset(Constant.ASSETS_IMG + 'ic_group_top.png');
        }

        Subject bean = list![index - 1];
        return Padding(
          padding: const EdgeInsets.only(right: Constant.MARGIN_RIGHT, left: 6.0, top: 13.0),
          child: _getItem(bean, index - 1),
        );
      },
      itemCount: list!.length + 1,
    );
  }

  Widget _getItem(Subject bean, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: <Widget>[
          RadiusImg.get(bean.images?.small, 50.0, radius: 3.0),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    bean.title,
                    style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                  Text(bean.pubdates != null ? bean.pubdates[0] : '', style: const TextStyle(fontSize: 13.0))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              '${bean.collect_count}人',
              style: const TextStyle(fontSize: 13.0),
            ),
          ),
          GestureDetector(
            child: Image.asset(
              Constant.ASSETS_IMG + (list![index].tag ? 'ic_group_checked_anonymous.png' : 'ic_group_check_anonymous.png'),
              width: 25.0,
              height: 25.0,
            ),
            onTap: () {
              setState(() {
                list![index].tag = !list![index].tag;
              });
            },
          )
        ],
      ),
      onTap: () {
        // 暂时未开放
        MyRouter.push(context, MyRouter.detailPage, bean.id);
      },
    );
  }
}
