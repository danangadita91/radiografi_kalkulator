import 'package:flutter/material.dart';
import 'package:radiografi_kalkulator/TextStyle.dart';

//Display Currie
class DisplayCurrie extends StatelessWidget {
  DisplayCurrie({@required this.label, this.value, this.mainColor});
  final Color mainColor; final String label, value;

  @override
  Widget build(BuildContext context) {
    return Container(width: MediaQuery.of(context).size.width/3,
      height: MediaQuery.of(context).size.height/9, padding: EdgeInsets.all(5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
        color: mainColor),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('$value', style: DisplayText),
          Text('$label', style: DisplayDetail),
        ],
      ),
    );
  }
}
//Display Time
class DisplayExposeTime extends StatelessWidget {
  DisplayExposeTime({@required this.label, this.value, this.mainColor});
  final Color mainColor; final String label, value;

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
        color: mainColor),
      child: Column(mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text('$value', style: DisplayText),
          Text('$label', style: DisplayDetail),
        ],
      ),
    );
  }
}