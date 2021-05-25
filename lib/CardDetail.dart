import 'package:flutter/material.dart';
import 'TextStyle.dart';

class CardDetail extends StatelessWidget {
  CardDetail({@ required this.warna, this.logo, this.labelTitle, this.labelDetail});
  final Color warna;
  final AssetImage logo;
  final String labelTitle;
  final String labelDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
          height: 67,
          width: 67,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(110),
              color: warna
          ),
          child: Image(
            image: logo,
          ),
        ),
        SizedBox(height: 5),
        Text(
          labelTitle,
          style: CardTextTitle,
          textAlign: TextAlign.center,
          textScaleFactor: 0.75,
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          height: 10,
          thickness: 5,
        ),
        SizedBox(height: 5,),
        Text(labelDetail,
          style: CardTextDetail,
          textScaleFactor: 0.71,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
