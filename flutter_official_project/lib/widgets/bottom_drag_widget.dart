import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stack_trace/stack_trace.dart';

// 上拉抽屉
class BottomDragWidget extends StatelessWidget {
  final Widget body;
  final DragContainer dragContainer;

  const BottomDragWidget({super.key, required this.body, required this.dragContainer});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        body,
        Align(
          alignment: Alignment.bottomCenter,
          child: dragContainer,
        )
      ],
    );
  }
}

typedef DragListener = void Function(double dragDistance, ScrollNotificationListener isDragEnd);

class DragController {
  late DragListener _dragListener;

  setDrag(DragListener l) {
    _dragListener = l;
  }

  void updateDragDistance(double dragDistance, ScrollNotificationListener isDragEnd) {
    // ignore: unnecessary_null_comparison
    if (_dragListener != null) {
      _dragListener(dragDistance, isDragEnd);
    }
  }
}

class DragContainer extends StatefulWidget {
  final Widget drawer;
  final double defaultShowHeight;
  final double height;

  DragContainer({super.key, required this.drawer, required this.defaultShowHeight, required this.height}) {
    _controller = DragController();
  }

  @override
  // ignore: library_private_types_in_public_api
  _DragContainerState createState() => _DragContainerState();
}

class _DragContainerState extends State<DragContainer> with TickerProviderStateMixin {
  late AnimationController animalController;

  // 滑动位置超过这个位置，会滚到顶部；小于，会滚动底部。
  late double maxOffsetDistance;
  bool onResetControllerValue = true;
  late double offsetDistance = 0;
  late Animation<double> animation;
  bool offstage = false;
  bool _isFling = false;

  double get defaultOffsetDistance => widget.height - widget.defaultShowHeight;

  @override
  void initState() {
    animalController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    maxOffsetDistance = (widget.height + widget.defaultShowHeight) * 0.5;

//    if (controller != null) {
    _controller.setDrag((double value, ScrollNotificationListener notification) {
      if (notification != ScrollNotificationListener.edge) {
        _handleDragEnd(null);
      } else {
        setState(() {
          offsetDistance = offsetDistance + value;
        });
      }
    });
//    }
    super.initState();
  }

  GestureRecognizerFactoryWithHandlers<MyVerticalDragGestureRecognizer> getRecognizer() {
    return GestureRecognizerFactoryWithHandlers<MyVerticalDragGestureRecognizer>(
      () => MyVerticalDragGestureRecognizer(flingListener: (bool isFling) {
        _isFling = isFling;
      }), //constructor
      (MyVerticalDragGestureRecognizer instance) {
        //initializer
        instance
          ..onStart = _handleDragStart
          ..onUpdate = _handleDragUpdate
          ..onEnd = _handleDragEnd;
      },
    );
  }

  @override
  void dispose() {
    animalController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (offsetDistance == null || onResetControllerValue) {
      // 说明是第一次加载,由于 BottomDragWidget 中 alignment: Alignment.bottomCenter,故直接设置
      offsetDistance = defaultOffsetDistance;
    }

    // 偏移值在这个范围内
    offsetDistance = offsetDistance.clamp(0.0, defaultOffsetDistance);
    offstage = offsetDistance < maxOffsetDistance;
    return Transform.translate(
      offset: Offset(0.0, offsetDistance),
      child: RawGestureDetector(
        gestures: {MyVerticalDragGestureRecognizer: getRecognizer()},
        child: Stack(
          children: <Widget>[
            // ignore: sized_box_for_whitespace
            Container(
              height: widget.height,
              child: widget.drawer,
            ),
            Offstage(
              offstage: offstage,
              child: Container(
                // 使用图层来解决当抽屉露出头时，上拉抽屉上移。解决的方案最佳
                color: Colors.transparent,
                height: widget.height,
              ),
            )
          ],
        ),
      ),
    );
  }

  double get screenH => MediaQuery.of(context).size.height;

  // 当拖拽结束时调用
  void _handleDragEnd(DragEndDetails? details) {
    onResetControllerValue = true;

    // 很重要！！！动画完毕后，controller.value = 1.0，这里要将 value 的值重置为 0.0，才会再次运行动画
    // 重置 value 的值时，会刷新 UI，故这里使用 [onResetControllerValue] 来进行过滤。
    animalController.value = 0.0;
    onResetControllerValue = false;
    double start;
    double end;
    if (offsetDistance <= maxOffsetDistance) {
      // 这个判断通过，说明已经 child 位置超过警戒线了，需要滚动到顶部了
      start = offsetDistance;
      end = 0.0;
    } else {
      start = offsetDistance;
      end = defaultOffsetDistance;
    }

    // ignore: unnecessary_null_comparison
    if (_isFling && details != null && details.velocity != null && details.velocity.pixelsPerSecond != null && details.velocity.pixelsPerSecond.dy < 0) {
      // 这个判断通过，说明是快速向上滑动，此时需要滚动到顶部了
      start = offsetDistance;
      end = 0.0;
    }

    // easeOut 先快后慢
    final CurvedAnimation curve = CurvedAnimation(parent: animalController, curve: Curves.easeOut);
    animation = Tween(begin: start, end: end).animate(curve)
      ..addListener(() {
        if (!onResetControllerValue) {
          offsetDistance = animation.value;
          setState(() {});
        }
      });

    // 自己滚动
    animalController.forward();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    offsetDistance = offsetDistance + details.delta.dy;
    setState(() {});
  }

  void _handleDragStart(DragStartDetails details) {
    _isFling = false;
  }
}

typedef FlingListener = void Function(bool isFling);

// MyVerticalDragGestureRecognizer 负责任务
// 1.监听 child 的位置更新
// 2.判断 child 在手松的那一刻是否是出于 fling 状态
class MyVerticalDragGestureRecognizer extends VerticalDragGestureRecognizer {
  final FlingListener flingListener;

  /// Create a gesture recognizer for interactions in the vertical axis.
  MyVerticalDragGestureRecognizer({Object? debugOwner, required this.flingListener}) : super(debugOwner: debugOwner);

  final Map<int, VelocityTracker> _velocityTrackers = <int, VelocityTracker>{};

  @override
  void handleEvent(PointerEvent event) {
    super.handleEvent(event);
    if (!event.synthesized && (event is PointerDownEvent || event is PointerMoveEvent)) {
      final VelocityTracker tracker = _velocityTrackers[event.pointer]!;
      // ignore: unnecessary_null_comparison
      assert(tracker != null);
      tracker.addPosition(event.timeStamp, event.position);
    }
  }

  @override
  void addPointer(PointerDownEvent event) {
    super.addPointer(event);
    _velocityTrackers[event.pointer] = VelocityTracker.withKind(PointerDeviceKind.touch);
  }

  // 来检测是否是 fling
  @override
  void didStopTrackingLastPointer(int pointer) {
    final double minVelocity = minFlingVelocity ?? kMinFlingVelocity;
    final double minDistance = minFlingDistance ?? kTouchSlop;
    final VelocityTracker tracker = _velocityTrackers[pointer]!;

    // VelocityEstimate 计算二维速度的
    final VelocityEstimate? estimate = tracker.getVelocityEstimate();
    bool isFling = false;
    if (estimate != null) {
      isFling = estimate.pixelsPerSecond.dy.abs() > minVelocity && estimate.offset.dy.abs() > minDistance;
    }
    _velocityTrackers.clear();
    // ignore: unnecessary_null_comparison
    if (flingListener != null) {
      flingListener(isFling);
    }

    // super.didStopTrackingLastPointer(pointer) 会调用[_handleDragEnd]
    // 所以将 [lingListener(isFling);] 放在前一步调用
    super.didStopTrackingLastPointer(pointer);
  }

  @override
  void dispose() {
    _velocityTrackers.clear();
    super.dispose();
  }
}

typedef ScrollListener = void Function(double dragDistance, ScrollNotificationListener notification);

late DragController _controller;

///监听手指在child处于边缘时的滑动
///例如：当child滚动到顶部时，此时下拉，会回调[ScrollNotificationListener.edge],
///或者child滚动到底部时，此时下拉，会回调[ScrollNotificationListener.edge],
///当child为[ScrollView]的子类时，例如：[ListView] / [GridView] 等，时，需要将其`physics`属性设置为[ClampingScrollPhysics]
///想看原因的，可以看下：
/// ///这个属性是用来断定滚动的部件的物理特性，例如：
//        ///scrollStart
//        ///ScrollUpdate
//        ///Overscroll
//        ///ScrollEnd
//        ///在Android和ios等平台，其默认值是不同的。我们可以在scroll_configuration.dart中看到如下配置
//
//        /// The scroll physics to use for the platform given by [getPlatform].
//        ///
//        /// Defaults to [BouncingScrollPhysics] on iOS and [ClampingScrollPhysics] on
//        /// Android.
////  ScrollPhysics getScrollPhysics(BuildContext context) {
////    switch (getPlatform(context)) {
////    case TargetPlatform.iOS:/*/
////         return const BouncingScrollPhysics();
////    case TargetPlatform.android:
////    case TargetPlatform.fuchsia:
////        return const ClampingScrollPhysics();
////    }
////    return null;
////  }
///在ios中，默认返回BouncingScrollPhysics，对于[BouncingScrollPhysics]而言，
///由于   double applyBoundaryConditions(ScrollMetrics position, double value) => 0.0;
///会导致：当listview的第一条目显示时，继续下拉时，不会调用上面提到的Overscroll监听。
///故这里，设定为[ClampingScrollPhysics]
class OverscrollNotificationWidget extends StatefulWidget {
  const OverscrollNotificationWidget({super.key, required this.child});

  final Widget child;

//  final ScrollListener scrollListener;

  @override
  OverscrollNotificationWidgetState createState() => OverscrollNotificationWidgetState();
}

/// Contains the state for a [OverscrollNotificationWidget]. This class can be used to
/// programmatically show the refresh indicator, see the [show] method.
class OverscrollNotificationWidgetState extends State<OverscrollNotificationWidget> with TickerProviderStateMixin<OverscrollNotificationWidget> {
  final GlobalKey _key = GlobalKey();

  ///[ScrollStartNotification] 部件开始滑动
  ///[ScrollUpdateNotification] 部件位置发生改变
  ///[OverscrollNotification] 表示窗口小部件未更改它的滚动位置，因为更改会导致滚动位置超出其滚动范围
  ///[ScrollEndNotification] 部件停止滚动
  ///之所以不能使用这个来build或者layout，是因为这个通知的回调是会有延迟的。
  ///Any attempt to adjust the build or layout based on a scroll notification would
  ///result in a layout that lagged one frame behind, which is a poor user experience.

  @override
  Widget build(BuildContext context) {
    debugPrint('🐑🐑🐑 ${Trace.current().frames[0].member}');

    final Widget child = NotificationListener<ScrollStartNotification>(
      key: _key,
      child: NotificationListener<ScrollUpdateNotification>(
        child: NotificationListener<OverscrollNotification>(
          child: NotificationListener<ScrollEndNotification>(
            child: widget.child,
            onNotification: (ScrollEndNotification notification) {
              _controller.updateDragDistance(0.0, ScrollNotificationListener.end);
              return false;
            },
          ),
          onNotification: (OverscrollNotification notification) {
            // ignore: unnecessary_null_comparison
            if (notification.dragDetails != null && notification.dragDetails!.delta != null) {
              _controller.updateDragDistance(notification.dragDetails!.delta.dy, ScrollNotificationListener.edge);
            }
            return false;
          },
        ),
        onNotification: (ScrollUpdateNotification notification) {
          return false;
        },
      ),
      onNotification: (ScrollStartNotification scrollUpdateNotification) {
        _controller.updateDragDistance(0.0, ScrollNotificationListener.start);
        return false;
      },
    );

    return child;
  }
}

enum ScrollNotificationListener {
  // 滑动开始
  start,
  // 滑动结束
  end,
  // 滑动时，控件在边缘（最上面显示或者最下面显示）位置
  edge
}

/// -----------------------DEMO-----------------------
///
///
///
/// DragController controller = DragController();
//class Demo extends StatefulWidget {
//  @override
//  _DemoState createState() => _DemoState();
//}
//
//class _DemoState extends State<Demo> {
//  @override
//  Widget build(BuildContext context) {
//    return BottomDragWidget(
//        body: Container(
//          color: Colors.brown,
//          child: ListView.builder(itemBuilder: (BuildContext context, int index){
//            return Text('我是listview下面一层的东东，index=$index');
//          }, itemCount: 100,),
//        ),
//        dragContainer: DragContainer(
//          controller: controller,
//          drawer: getListView(),
//          defaultShowHeight: 150.0,
//          height: 700.0,
//        ));
//  }
//
//  Widget getListView() {
//    return Container(
//      height:600.0,
//
//      ///总高度
//      color: Colors.amberAccent,
//      child: Column(
//        children: <Widget>[
//          Container(
//            color: Colors.deepOrangeAccent,
//            height: 10.0,
//          ),
//          Expanded(child: newListView())
//        ],
//      ),
//    );
//  }
//
//  Widget newListView() {
//    return OverscrollNotificationWidget(
//      child: ListView.builder(
//        itemBuilder: (BuildContext context, int index) {
//          return Text('data=$index');
//        },
//        itemCount: 100,
//        ///这个属性是用来断定滚动的部件的物理特性，例如：
//        ///scrollStart
//        ///ScrollUpdate
//        ///Overscroll
//        ///ScrollEnd
//        ///在Android和ios等平台，其默认值是不同的。我们可以在scroll_configuration.dart中看到如下配置
//
/////下面代码是我在翻源码找到的解决方案
///// The scroll physics to use for the platform given by [getPlatform].
//        ///
//        /// Defaults to [BouncingScrollPhysics] on iOS and [ClampingScrollPhysics] on
//        /// Android.
////  ScrollPhysics getScrollPhysics(BuildContext context) {
////    switch (getPlatform(context)) {
////    case TargetPlatform.iOS:/*/
////         return const BouncingScrollPhysics();
////    case TargetPlatform.android:
////    case TargetPlatform.fuchsia:
////        return const ClampingScrollPhysics();
////    }
////    return null;
////  }
//        ///在ios中，默认返回BouncingScrollPhysics，对于[BouncingScrollPhysics]而言，
//        ///由于   double applyBoundaryConditions(ScrollMetrics position, double value) => 0.0;
//        ///会导致：当listview的第一条目显示时，继续下拉时，不会调用上面提到的Overscroll监听。
//        ///故这里，设定为[ClampingScrollPhysics]
//        physics: const ClampingScrollPhysics(),
//      ),
//      scrollListener: _scrollListener,
//    );
//  }
//
//  void _scrollListener(
//      double dragDistance, ScrollNotificationListener isDragEnd) {
//    controller.updateDragDistance(dragDistance, isDragEnd);
//  }
//}
///
