import 'package:flutter/material.dart';
import 'package:flutter_official_project/bean/movie_detail_bean.dart';
import 'package:flutter_official_project/constant/constant.dart';
import 'package:flutter_official_project/pages/detail/look_confirm_button.dart';

class DetailTitleWidget extends StatelessWidget {
  final MovieDetailBean bean;
  final Color shadowColor;

  const DetailTitleWidget(this.bean, this.shadowColor, {super.key});

  @override
  Widget build(BuildContext context) {
    var screenW = MediaQuery.of(context).size.width;
    var imgW = screenW / 4;
    var imgH = imgW * 421 / 297;
    var countries = list2String(bean.countries);
    var genres = list2String(bean.genres);
    var pubdates = list2String(bean.pubdates);
    var durations = list2String(bean.durations);
    // 将按下的颜色设置较为浅色
    var btnPressedColor = Color.fromARGB(100, shadowColor.red, shadowColor.red, shadowColor.red);
    return Row(
      children: <Widget>[
        Card(
          // 影音海报
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          color: shadowColor,
          clipBehavior: Clip.antiAlias,
          elevation: 10.0,
          child: Image.network(
            bean.images!.large!,
            width: imgW,
            height: imgH,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: Constant.MARGIN_LEFT),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  bean.title!,
                  style: const TextStyle(fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 7.0),
                  child: Text(
                    '(${bean.year})',
                    style: const TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    '$countries/$genres/上映时间：$pubdates/片长：$durations',
                    style: const TextStyle(fontSize: 12.0, color: Colors.white70),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: LookConfirmButton(
                        btnText: '想看',
                        iconAsset: 'assets/images/ic_info_wish.png',
                        defaultColor: Colors.white,
                        pressedColor: btnPressedColor,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                    ),
                    Expanded(
                      child: LookConfirmButton(
                        btnText: '看过',
                        iconAsset: 'assets/images/ic_info_done.png',
                        defaultColor: Colors.white,
                        pressedColor: btnPressedColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  String list2String(List<String>? list) {
    var tmp = '';
    if (list == null || list.isEmpty) {
      return tmp;
    }
    for (String item in list) {
      tmp = tmp + item;
    }
    return tmp;
  }
}
