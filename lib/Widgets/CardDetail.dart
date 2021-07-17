import 'package:flutter/material.dart';
import '../TextStyle.dart';

class CardDetail extends StatelessWidget {
  CardDetail({@ required this.mainColor, this.logo,
    this.labelTitle, this.labelDetail});

  final Color mainColor; final AssetImage logo;
  final String labelTitle, labelDetail;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(padding: EdgeInsets.all(5), height: imageCard, width: imageCard,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(110),
              color: mainColor),
          child: Image(image: logo),
        ),
        SizedBox(height: 5),
        Text(labelTitle, style: CardTitle, textAlign: TextAlign.center,
            textScaleFactor: 0.75),
        SizedBox(height: 5),
        Divider(height: 10, thickness: 5),
        SizedBox(height: 5),
        Text(labelDetail, style: CardTextDetail, textScaleFactor: 0.71,
            textAlign: TextAlign.center)
      ],
    );
  }
}