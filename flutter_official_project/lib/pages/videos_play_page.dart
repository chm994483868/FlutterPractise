import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_official_project/bean/movie_detail_bean.dart';
import 'package:flutter_official_project/widgets/video_widget.dart';

class VideoPlayPage extends StatefulWidget {
  final List<Blooper> beans;

  const VideoPlayPage(this.beans, {super.key});

  @override
  State<StatefulWidget> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  late double? mediumW, mediumH; // 309 X 177
  int _showPlayIndex = 0;
  late VideoWidget playWidget;

  @override
  Widget build(BuildContext context) {
    if (mediumW == null) {
      mediumW = MediaQuery.of(context).size.width / 4;
      mediumH = mediumW! / 309 * 177;
      playWidget = VideoWidget(
        url:widget.beans[0].resource_url!,
        previewImgUrl: widget.beans[0].medium!,
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                playWidget
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          const Expanded(
                            child: Text(
                              '观看预告片/片段/花絮',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                          Text('${widget.beans.length}',
                              style: const TextStyle(fontSize: 12.0))
                        ],
                      ),
                    );
                  }
                  return getItem(widget.beans[index - 1], index - 1);
                },
                itemCount: widget.beans.length + 1,
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget getItem(Blooper bean, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: bean.medium!,
                      width: mediumW,
                      height: mediumH,
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: getPlay(index),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    bean.title!,
                    softWrap: true,
                    style: const TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
            ],
          ),
          const Divider()
        ],
      ),
      onTap: () {
        setState(() {
          _showPlayIndex = index;
        });
        playWidget.updateUrl(bean.resource_url!);
      },
    );
  }

  getPlay(int index) {
    if (index == _showPlayIndex) {
      return Container(
        width: mediumW,
        height: mediumH,
        alignment: Alignment.center,
        child: const Icon(
          Icons.play_circle_outline,
          color: Colors.amber,
        ),
      );
    } else {
      return Container();
    }
  }
}
