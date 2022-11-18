import 'package:flutter/material.dart';
import 'package:flutter_official_project/bean/subject_entity.dart';
import 'package:flutter_official_project/constant/constant.dart';

// 影院热映、即将上映
class HotSoonMovieWidget extends StatefulWidget {
  final state = _HotSoonMovieWidgetState();

  HotSoonMovieWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HotSoonMovieWidgetState createState() {
    // ignore: no_logic_in_create_state
    return state;
  }

  // 设置影院热映数据
  void setHotMovieBeanList(List<Subject> list) {
    state.setHotMovieBeanList(list);
  }
}

TabController? _tabController;
var movieCount = 16;

class _HotSoonMovieWidgetState extends State<HotSoonMovieWidget> with SingleTickerProviderStateMixin {
  Color? selectColor, unselectedColor;
  TextStyle? selectStyle, unselectedStyle;
  Widget? tabBar;
  double childAspectRatio = 355.0 / 506.0;
  // ignore: prefer_typing_uninitialized_variables
  var hotCount, soonCount; // 热映数量、即将上映数量、
  List<Subject>? hotMovieBeans, soonMovieBeans;

  @override
  void initState() {
    super.initState();

    selectColor = const Color.fromARGB(255, 45, 45, 45);
    unselectedColor = const Color.fromARGB(255, 135, 135, 135);
    selectStyle = TextStyle(fontSize: 20, color: selectColor, fontWeight: FontWeight.bold);
    unselectedStyle = TextStyle(fontSize: 20, color: unselectedColor);
    _tabController = TabController(vsync: this, length: 2);
    _tabController?.addListener(listener);
    
    tabBar = TabBar(
      tabs: const [
        Padding(
          padding: EdgeInsets.only(bottom: Constant.TAB_BOTTOM),
          child: Text('影院热映'),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: Constant.TAB_BOTTOM),
          child: Text('即将上映'),
        )
      ],
      
      indicatorColor: selectColor,
      labelColor: selectColor,
      labelStyle: selectStyle,
      unselectedLabelColor: unselectedColor,
      unselectedLabelStyle: unselectedStyle,
      indicatorSize: TabBarIndicatorSize.label,
      controller: _tabController,
      isScrollable: true,
//      onTap: (index) {
//        setState(() {
//          if (index == 0) {
//            movieCount = hotCount;
//          } else {
//            movieCount = 20;
//          }
//        });
//      },
    );
  }

  void listener() {
    if (_tabController?.indexIsChanging ?? false) {
      var index = _tabController?.index;
      debugPrint("HotSoonMovieWidget index changing=$index");

      setState(() {
        if (index == 0) {
          movieCount = hotCount;
        } else {
          movieCount = 20;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: tabBar!,
            ),
            Text(
              '全部 $movieCount > ',
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
//        GridView.builder(
//            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                crossAxisCount: 3,
//                crossAxisSpacing: 10.0,
//                mainAxisSpacing: 10.0,
//                childAspectRatio: childAspectRatio),
//            //Widget Function(BuildContext context, int index);
//            itemBuilder: (BuildContext context, int index) {
//              return SubjectMarkImageWidget(hotMovieBeans[index].images.large);
//            })
      ],
    );
  }

  @override
  void dispose() {
    _tabController?.removeListener(listener);
    _tabController?.dispose();
    super.dispose();
  }

  void setHotMovieBeanList(List<Subject> list) {
    setState(() {
      hotMovieBeans = list;
      hotCount = hotMovieBeans?.length;
    });
  }
}
