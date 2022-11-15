// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison, prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_official_project/bean/search_result_entity.dart';
import 'package:flutter_official_project/http/API.dart';
import 'package:flutter_official_project/widgets/search_text_field_widget.dart';

// 搜索
class SearchPage extends StatefulWidget {
  final String searchHintContent;

  // 搜索框中的默认显示内容
  const SearchPage({super.key, this.searchHintContent = '用一部电影来形容你的2018'});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final API _api = API();

  late SearchResultEntity _searchResultEntity;
  var imgW;
  var imgH;
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    if (imgW == null) {
      imgW = MediaQuery.of(context).size.width / 7;
      imgH = imgW / 0.75;
    }

    if (_searchResultEntity != null && _searchResultEntity.subjects!.isNotEmpty) {
      _searchResultEntity.subjects!.sort((a, b) => (b.year!.compareTo(a.year!)));
    }

    return Scaffold(
      body: SafeArea(
          child: showLoading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : _searchResultEntity == null
                  ? getSearchWidget()
                  : Column(
                      children: <Widget>[
                        getSearchWidget(),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              SearchResultSubject bean = _searchResultEntity.subjects![index];
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  child: _getItem(bean, index),
                                  onTap: () {
                                    // 功能暂时未开放
                                    // MyRouter.push(context, MyRouter.detailPage, bean.id);
                                  },
                                ),
                              );
                            },
                            itemCount: _searchResultEntity.subjects!.length,
                          ),
                        )
                      ],
                    )),
    );
  }

  String getType(String subtype) {
    switch (subtype) {
      case 'movie':
        return '电影';
    }
    return '';
  }

  String listConvertString2(List<SearchResultSubjectsDirector> genres) {
    if (genres.isEmpty) {
      return '';
    } else {
      String tmp = '';
      for (SearchResultSubjectsDirector item in genres) {
        tmp = tmp + item.name;
      }
      return tmp;
    }
  }

  String listConvertString(List<String> genres) {
    if (genres.isEmpty) {
      return '';
    } else {
      String tmp = '';
      for (String item in genres) {
        tmp = tmp + item;
      }
      return tmp;
    }
  }

  Widget getSearchWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SearchTextFieldWidget(
              hintText: widget.searchHintContent,
              onSubmitted: (searchContent) {
                showLoading = true;
                _api.searchMovie(searchContent, (searchResultEntity) {
                  setState(() {
                    showLoading = false;
                    _searchResultEntity = searchResultEntity;
                  });
                });
              },
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                '取消',
                style: getStyle(Colors.green, 17.0),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Widget _getItem(SearchResultSubject bean, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          clipBehavior: Clip.antiAlias,
          elevation: 5.0,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Image.network(
            bean.images!.medium!,
            fit: BoxFit.cover,
            width: imgW,
            height: imgH,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(5.0),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(getType(bean.subtype!), style: getStyle(Colors.grey, 12.0),),
              Text(bean.title! + '(${bean.year!})', style: getStyle(Colors.black, 15.0, bold: true)),
              Text('${bean.rating!.average!} 分 / ${listConvertString(bean.pubdates!)} / ${listConvertString(bean.genres!)} / ${listConvertString2(bean.directors!)}', style: getStyle(Colors.grey, 13.0))
            ],
          ),
        )
      ],
    );
  }

  TextStyle getStyle(Color color, double fontSize, {bool bold = false}) {
    return TextStyle(color: color, fontSize: fontSize, fontWeight: bold ? FontWeight.bold : FontWeight.normal);
  }
}
