import 'package:flutter/material.dart';

class PhotoHeroPage extends StatelessWidget {
  final String photoUrl;
  final double width;

  const PhotoHeroPage({super.key, required this.photoUrl, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.center,
      child: _PhotoHero(
        photoUrl: photoUrl,
        width: width,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class _PhotoHero extends StatelessWidget {
  final String photoUrl;
  final double width;
  final VoidCallback onTap;

  const _PhotoHero({required this.photoUrl, required this.width, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photoUrl,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photoUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

//class HeroAnimation extends StatelessWidget {
//  final String url;
//
//  HeroAnimation(this.url, {Key key}) : super(key: key);
//
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Basic Hero Animation'),
//      ),
//      body: Center(
//        child: PhotoHero(
//            photo: url,
//            width: 300.0,
//            onTap: () {
//              Router.push(
//                  context, Router.photoHero, {'photoUrl': url, 'width': 100.0});
//            }),
//      ),
//    );
//  }
//}
//
//class PhotoHero extends StatelessWidget {
//  const PhotoHero({Key key, this.photo, this.onTap, this.width})
//      : super(key: key);
//
//  final String photo;
//  final VoidCallback onTap;
//  final double width;
//
//  Widget build(BuildContext context) {
//    return SizedBox(
//      width: width,
//      child: Hero(
//        tag: photo,
//        child: Material(
//          color: Colors.transparent,
//          child: InkWell(
//            onTap: onTap,
//            child: ListView.builder(itemBuilder: (BuildContext context, int index){
//              return Image.network(
//                photo,
//                fit: BoxFit.contain,
//              );
//            }, itemCount: 20,),
//          ),
//        ),
//      ),
//    );
//  }
//}
