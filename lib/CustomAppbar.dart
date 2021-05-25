import 'package:flutter/material.dart';
import 'TextStyle.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar ({@required this.judul, this.logoBalik, this.logoBar1, this.logoBar2, this.logoBar3,
    this.pencetBalik, this.tapBar1,this.tapBar2,this.tapBar3, this.warnaBar, this.bayangan
  });

  final String judul;
  final IconData logoBalik;
  final AssetImage logoBar1;
  final AssetImage logoBar2;
  final AssetImage logoBar3;
  final Function pencetBalik;
  final Function tapBar1;
  final Function tapBar2;
  final Function tapBar3;
  final Color warnaBar;
  final Color bayangan;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: bayangan,offset: Offset(2,2),blurRadius: 10)
        ],
        borderRadius: BorderRadius.circular(10),
      color: warnaBar
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 5),
          GestureDetector(
            onTap: pencetBalik,
            child: Icon(logoBalik,
              color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(width: 7),
          Text(judul,
          style: TextBar,
          ),
          Spacer(),
          GestureDetector(
            onTap: tapBar1,
            child: Image(image: logoBar1,
              height: 30,
              width: 30,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: tapBar2,
            child: Image(image: logoBar2,
              height: 30,
              width: 30,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: tapBar3,
            child: Image(image: logoBar3,
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
