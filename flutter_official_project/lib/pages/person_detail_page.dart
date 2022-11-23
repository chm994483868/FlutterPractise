// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_official_project/bean/celebrity_entity.dart';
import 'package:flutter_official_project/bean/celebrity_work_entity.dart';
import 'package:flutter_official_project/repository/person_detail_repository.dart';
import 'package:flutter_official_project/router.dart';
import 'package:flutter_official_project/widgets/image/radius_img.dart';
import 'package:flutter_official_project/widgets/item_count_title.dart';
import 'package:flutter_official_project/widgets/loading_widget.dart';
import 'package:flutter_official_project/widgets/rating_bar.dart';
import 'package:flutter_official_project/widgets/subject_mark_image_widget.dart';
import 'package:flutter_official_project/widgets/title_bar.dart' as title;

class PersonDetailPage extends StatefulWidget {
  final String id;
  final String? personImgUrl;

  const PersonDetailPage({super.key, required this.id, this.personImgUrl});

  @override
  State<StatefulWidget> createState() {
    return _PersonDetailPageState();
  }
}

class _PersonDetailPageState extends State<PersonDetailPage> {
  CelebrityEntity? celebrityEntity;
  CelebrityWorkEntity? celebrityWorkEntity;
  late double itemW;
  late double itemH;
  late double photoH;
  double titleSize = 16.0;
  bool loading = true;

  // 记录上一个页面的状态栏颜色
  SystemUiOverlayStyle? _lastStyle;

  @override
  void initState() {
    // 获取上一个页面的状态栏颜色
    // ignore: invalid_use_of_visible_for_testing_member
    _lastStyle = SystemChrome.latestStyle;
    // 设置当前页面状态栏颜色为白色
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    super.initState();

    requestAPI();
  }

  @override
  void dispose() {
    // 将状态栏设置为之前的颜色
    if (_lastStyle != null) {
      SystemChrome.setSystemUIOverlayStyle(_lastStyle!);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    itemW = MediaQuery.of(context).size.width / 4;
    itemH = itemW / 0.5;
    photoH = MediaQuery.of(context).size.width / 3;

    return title.TitleBar(
      title: '人物',
      body: LoadingWidget.containerLoadingBody(
        _getBody(),
        loading: loading,
      ),
    );
  }

  _getBody() {
    if (celebrityEntity == null) {
      return _PersonPhoto(
        photoUrl: widget.personImgUrl!,
      );
    } else {
      return CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _PersonPhoto(
                      photoUrl: widget.personImgUrl!,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            celebrityEntity?.name ?? "",
                            style: const TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            celebrityEntity?.name_en ?? "",
                            style: const TextStyle(fontSize: 13.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 7.0),
                  child: Text(
                    '简介',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleSize),
                  ),
                ),
                Text(
                  celebrityEntity?.summary ?? "",
                  softWrap: true,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
              child: ItemCountTitle(
                title: '影视',
                count: celebrityWorkEntity?.works?.length ?? 0,
                fontSize: titleSize,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: itemH,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  CelebrityWorkWorksSubject? bean = celebrityWorkEntity?.works?[index].subject;
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: _getItem(bean),
                  );
                },
                itemCount: celebrityWorkEntity?.works?.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ItemCountTitle(
              title: '相册',
              count: celebrityEntity?.photos?.length,
              fontSize: titleSize,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: photoH,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15.0, right: 3.0),
                    child: Image.network(
                      celebrityEntity?.photos?[index].image ?? "",
                      height: photoH,
                      fit: BoxFit.contain,
                    ),
                  );
                },
                itemCount: celebrityEntity?.photos?.length,
              ),
            ),
          )
        ],
      );
    }
  }

  void requestAPI() async {
    Future(() => (PersonDetailRepository().requestAPI(widget.id))).then((personDetailRepository) {
      setState(() {
        loading = false;
        celebrityEntity = personDetailRepository.celebrityEntity;
        celebrityWorkEntity = personDetailRepository.celebrityWorkEntity;
      });
    });
  }

  // 影院热映 item
  Widget _getItem(CelebrityWorkWorksSubject? bean) {
    if (bean == null || bean.images?.large == null) {
      return Container();
    }

    return GestureDetector(
      child: Container(
        width: itemW,
        height: itemH,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SubjectMarkImageWidget(
                imgNetUrl: bean.images?.large,
                width: itemW,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                width: double.infinity,
                child: Text(
                  bean.title!,
                  // 文本只显示一行
                  softWrap: false,
                  // 多出的文本渐隐方式
                  overflow: TextOverflow.fade,
                  style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            RatingBar(
              bean.rating!.average,
              size: 12.0,
            )
          ],
        ),
      ),
      onTap: () {
        // 功能待开放
        MyRouter.push(context, MyRouter.detailPage, bean.id);
      },
    );
  }
}

class _PersonPhoto extends StatelessWidget {
  final String photoUrl;

  const _PersonPhoto({required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width / 5;

    return SizedBox(
      width: w,
      child: Hero(
        tag: photoUrl,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: RadiusImg.get(photoUrl, w, imgH: w / 0.8, elevation: 3.0),
          ),
        ),
      ),
    );
  }
}
