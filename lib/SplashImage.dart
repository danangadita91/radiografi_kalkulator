import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SplashImage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  SplashImage({@required this.LogoSplash});
  final AssetImage LogoSplash;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
            height: 330,
            width: 330,
            image: LogoSplash),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
