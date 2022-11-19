import 'package:flutter/material.dart';

class AnimalPhoto {
  AnimalPhoto.show(BuildContext context, String url, {double? width}) {
    width ??= MediaQuery.of(context).size.width;

    Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: _PhotoHero(
          photo: url,
          width: width!,
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }));
  }
}

class _PhotoHero extends StatelessWidget {
  final String photo;
  final VoidCallback onTap;
  final double width;

  const _PhotoHero({required this.photo, required this.width, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
