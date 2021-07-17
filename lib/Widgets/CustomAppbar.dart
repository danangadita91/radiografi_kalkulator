import 'package:flutter/material.dart';
import '../TextStyle.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar ({@required this.titleBar, this.backLogo, this.logoBar1,
    this.logoBar2, this.logoBar3, this.tapBack, this.tapBar1,this.tapBar2,
    this.tapBar3, this.barColor, this.shadow
  });
  final String titleBar; final IconData backLogo; final Color barColor,shadow;
  final AssetImage logoBar1, logoBar2, logoBar3;
  final Function tapBack, tapBar1, tapBar2, tapBar3;
  @override
  Widget build(BuildContext context) {
    return Container(height: MediaQuery.of(context).size.height/15,
      margin: EdgeInsets.all(20), padding: EdgeInsets.all(7),
      decoration: BoxDecoration(boxShadow: [BoxShadow(color: shadow,
          offset: Offset(2,2),blurRadius: 10)],
          borderRadius: BorderRadius.circular(10), color: barColor),
      child: Row(
        children: <Widget>[
          SizedBox(width: 5),
          GestureDetector(onTap: tapBack,
            child: Icon(backLogo, color: Colors.white, size: 30)),
          SizedBox(width: 7),
          Text(titleBar, style: TitleBar),
          Spacer(),
          GestureDetector(onTap: tapBar1,
            child: Image(image: logoBar1, height: logoTapBar, width: logoTapBar)),
          SizedBox(width: 10),
          GestureDetector(onTap: tapBar2,
            child: Image(image: logoBar2, height: logoTapBar, width: logoTapBar)),
          SizedBox(width: 5),
          GestureDetector(onTap: tapBar3,
            child: Image(image: logoBar3, height: logoTapBar, width: logoTapBar)),
        ],
      ),
    );
  }
}
