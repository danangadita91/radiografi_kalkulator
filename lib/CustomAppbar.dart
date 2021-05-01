import 'package:flutter/material.dart';
import 'Cons.dart';


class CustomAppBar extends StatelessWidget {
  CustomAppBar ({@required this.Title, this.BackLogo, this.LogoBar1, this.LogoBar2, this.LogoBar3,
    this.PressBack, this.TapBar1,this.TapBar2,this.TapBar3, this.WarnaBar
  });

  final Color WarnaBar;
  final Function TapBar1;
  final Function TapBar2;
  final Function TapBar3;
  final Function PressBack;
  final IconData BackLogo;
  final String Title;
  final AssetImage LogoBar1;
  final AssetImage LogoBar2;
  final AssetImage LogoBar3;


  @override
  Widget build(BuildContext context) {
    'alphabet'.toUpperCase(); // 'ALPHABET'
    'ABC'.toUpperCase();
    return Container(
      height: 50,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      color: WarnaBar
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 5),
          GestureDetector(
            onTap: PressBack,
            child: Icon(BackLogo,
              color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(width: 7),
          Text(Title,
          style: TextBar,
          ),
          Spacer(),
          GestureDetector(
            onTap: TapBar1,
            child: Image(image: LogoBar1,
              height: 30,
              width: 30,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: TapBar2,
            child: Image(image: LogoBar2,
              height: 30,
              width: 30,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: TapBar3,
            child: Image(image: LogoBar3,
              height: 30,
              width: 30,
              fit: BoxFit.fill,
            ),
          ),

        ],
      ),
    );
  }
}
