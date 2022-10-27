import 'package:flutter/material.dart';

typedef TapCallback = void Function();

class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _TextImageWidget(
          'movies',
          'assets/images/find_movie.png',
          tabCallBack: () {
            print('click find movie');
            // route movie
          },
        ),
        
      ],
    );
  }
}

class _TextImageWidget extends StatelessWidget {
  final String text;
  final String imgAsset;
  final TapCallback tabCallBack;

  _TextImageWidget(this.text, this.imgAsset, {Key key, this.tabCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (tabCallBack != null) {
          tabCallBack();
        }
      },
      child: Column(
        children: <Widget>[
          Image.asset(
            imgAsset,
            width: 45,
            height: 45,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 13, color: Color.fromARGB(255, 128, 128, 128)),
          )
        ],
      ),
    );
  }
}
