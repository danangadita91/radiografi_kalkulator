import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Cons.dart';

class CardDetail extends StatelessWidget {
  // ignore: non_constant_identifier_names
  CardDetail({@ required this.Warna, this.Logo, this.LabelTitle, this.LabelDetail});
  // ignore: non_constant_identifier_names
  final AssetImage Logo;
  // ignore: non_constant_identifier_names
  final Color Warna;
  // ignore: non_constant_identifier_names
  final String LabelTitle;
  // ignore: non_constant_identifier_names
  final String LabelDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(3),
          height: 67,
          width: 67,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  110),
              color: Warna
          ),
          child: Image(
            image: Logo,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: 5),
        Text(
          LabelTitle,
          style: CardTextTitle,
          textAlign: TextAlign.center,
          textScaleFactor: 0.75,
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          height: 10,
          thickness: 7,
        ),
        SizedBox(height: 5,),
        Text(LabelDetail,
          style: CardTextDetail,
          textScaleFactor: 0.71,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
