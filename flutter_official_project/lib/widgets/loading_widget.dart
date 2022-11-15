import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadingWidget {
  static Widget getLoading({Color? backgroundColor, Color? loadingBgColor}) {
    return Container(
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(color: loadingBgColor ?? Colors.white, borderRadius: BorderRadius.circular(10.0)),
        width: 70.0,
        height: 70.0,
        alignment: AlignmentDirectional.center,
        child: const SizedBox(
          height: 25.0,
          width: 25.0,
          child: CupertinoActivityIndicator(
            radius: 15.0,
          ),
        ),
      ),
    );
  }

  static Widget containerLoadingBody(Widget body, {bool loading = true, Color? backgroundColor, Color? loadingBgColor}) {
    return Stack(
      children: <Widget>[
        body,
        Offstage(
          offstage: !loading,
          child: getLoading(backgroundColor: backgroundColor, loadingBgColor: loadingBgColor),
        )
      ],
    );
  }
}
