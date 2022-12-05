// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_official_project/constant/constant.dart';
import 'package:flutter_official_project/util/screen_utils.dart';

import 'package:video_player/video_player.dart';
// import 'package:flutter_official_project/widgets/video_progress_bar.dart';

// http://vt1.doubanio.com/201902111139/0c06a85c600b915d8c9cbdbbaf06ba9f/view/movie/M/302420330.mp4
// ignore: must_be_immutable
class VideoWidget extends StatefulWidget {
  final String url;
  final String previewImgUrl; // 预览图片的地址

  final bool showProgressBar; // 是否显示进度条
  final bool showProgressText; // 是否显示视频时长/播放时长的文本

  VideoWidget({super.key, required this.url, required this.previewImgUrl, this.showProgressBar = true, this.showProgressText = true});

  // ignore: library_private_types_in_public_api
  late _VideoWidgetState state;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    state = _VideoWidgetState();
    return state;
  }

  // 更新播放 URL
  updateUrl(String url) {
    state.setUrl(url);
  }
}

class _VideoWidgetState extends State<VideoWidget> {
  // _controller 变量在 initState 函数中进行初始化，它是一个 ValueNotifier 监听器变量
  late VideoPlayerController _controller;

  // listener 变量在构造函数中进行初始化
  late VoidCallback listener;

  // ignore: prefer_final_fields
  bool _showSeekBar = true;

  // 构造函数
  _VideoWidgetState() {
    // 初始化 listener
    listener = () {
      if (mounted) {
        setState(() {});
      }
    };
  }

  @override
  void initState() {
    super.initState();

    debugPrint('🐑🐑🐑 视频播放的 URL: ${widget.url}');

    // 初始化 _controller
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});

          // 这里是视频跳转到开头
          if (_controller.value.duration == _controller.value.position) {
            _controller.seekTo(const Duration(seconds: 0));
            setState(() {});
          }
        }
      });

    // 添加监听
    _controller.addListener(listener);
  }

  @override
  void deactivate() {
    _controller.removeListener(listener);
    super.deactivate();
  }

  // FadeAnimation imageFadeAnim;
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      // 子 Widget
      GestureDetector(
        // 视频播放的 Widget
        child: VideoPlayer(_controller),
        onTap: () {
          // 点击隐藏或者显示视频跳转操作条
          setState(() {
            _showSeekBar = !_showSeekBar;
          });
        },
      ),
      // 视频播放控制按钮等 Widget
      getPlayController(),
    ];

    // 指定宽高比的 Widget
    return AspectRatio(
      // 这里需要的是一个视频宽高的比例，宽度应该是屏幕的宽度，高度应该根据比例算出来，而不是现在的直接写死的 350
      // aspectRatio: _controller.value.aspectRatio,
      // aspectRatio: ScreenUtils.screenW(context) / 350.0,
      aspectRatio: _controller.value.isInitialized ? _controller.value.aspectRatio : ScreenUtils.screenW(context),
      child: Stack(
        // 填充方式
        fit: StackFit.passthrough,
        // 子 Widget
        children: children,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // 释放播放器资源
  }

  // 没用到
  CachedNetworkImage? getPreviewImg() {
    return widget.previewImgUrl.isNotEmpty ? CachedNetworkImage(imageUrl: widget.previewImgUrl) : null;
  }

  getMinuteSeconds(var inSeconds) {
    if (inSeconds == null || inSeconds <= 0) {
      return '00:00';
    }

    var tmp = inSeconds ~/ Duration.secondsPerMinute;
    var minute;
    if (tmp < 10) {
      minute = '0$tmp';
    } else {
      minute = '$tmp';
    }

    var tmp1 = inSeconds % Duration.secondsPerMinute;
    var seconds;
    if (tmp1 < 10) {
      seconds = '0$tmp1';
    } else {
      seconds = '$tmp1';
    }
    return '$minute:$seconds';
  }

  // 获取视频时长字符串
  getDurationText() {
    var txt;
    if (_controller.value.position == null || _controller.value.duration == null) {
      txt = '00:00/00:00';
    } else {
      txt = '${getMinuteSeconds(_controller.value.position.inSeconds)}/${getMinuteSeconds(_controller.value.duration.inSeconds)}';
    }
    // ignore: sized_box_for_whitespace
    return Container(
      height: 20,
      width: 80,
      child: Text(
        '$txt',
        style: const TextStyle(color: Colors.white, fontSize: 12.0),
        textAlign: TextAlign.center,
      ),
    );
  }

  // 视频播放控制
  getPlayController() {
    return Offstage(
      // 根据 _showSeekBar 显示与否
      offstage: !_showSeekBar,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            // IconButton 在视频画面中间显示的 暂停/播放 的按钮
            child: IconButton(
                iconSize: 55.0,
                icon: Image.asset(Constant.ASSETS_IMG + (_controller.value.isPlaying ? 'ic_pause.png' : 'ic_playing.png')),
                onPressed: () {
                  // 根据当前播放状态，暂停/播放 视频
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                }),
          ),

          // 视频时长数据/视频播放的进度条
          getProgressContent(),

          // 加载进度动画
          Align(
            alignment: Alignment.bottomCenter,
            // 根据当前是否正在缓存，才决定是否有这个加载进度动画
            child: Center(child: _controller.value.isBuffering ? const CircularProgressIndicator() : null),
          )
        ],
      ),
    );
  }

  // 更新播放的 URL
  void setUrl(String url) {
    if (mounted) {
      debugPrint('updateUrl');

      // 移除之前的监听
      if (_controller != null) {
        _controller.removeListener(listener);
        _controller.pause();
      }

      // 根据新的播放 URL 初始化 _controller，并重新添加监听
      _controller = VideoPlayerController.network(url)
        ..initialize().then((_) {
          setState(() {});

          if (_controller.value.duration == _controller.value.position) {
            _controller.seekTo(const Duration(seconds: 0));
            setState(() {});
          }
        });
      // 添加监听
      _controller.addListener(listener);
    }
  }

  // 视频进度条/时长文字 Widget
  Widget getProgressContent() {
    return (widget.showProgressBar || widget.showProgressText
        ? Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 8.0,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Offstage(
                      offstage: !widget.showProgressBar,
                      // 视频播放进度条
                      child: VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(playedColor: Colors.amberAccent, backgroundColor: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Offstage(
                  // 视频时长数字数据显示与否
                  child: getDurationText(),
                  offstage: !widget.showProgressText,
                )
              ],
            ),
          )
        : Container());
  }
}

// 并没有使用
class FadeAnimation extends StatefulWidget {
  const FadeAnimation({super.key, required this.child, this.duration = const Duration(milliseconds: 1500)});

  final Widget child;
  final Duration duration;

  @override
  // ignore: library_private_types_in_public_api
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(duration: widget.duration, vsync: this);
    animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    animationController.forward(from: 0.0);
  }

  @override
  void deactivate() {
    animationController.stop();
    super.deactivate();
  }

  @override
  void didUpdateWidget(FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return animationController.isAnimating
        ? Opacity(
            opacity: 1.0 - animationController.value,
            child: widget.child,
          )
        : Container();
  }
}
