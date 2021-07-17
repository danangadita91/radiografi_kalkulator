import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  MyCard({@required this.childCard});
  final Widget childCard;
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height/4.5,
      width: MediaQuery.of(context).size.height/6,
      decoration: BoxDecoration(shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15), border: Border.all(
              width: 2, color: Colors.grey.withOpacity(1))
      ),
      child: childCard
    );
  }
}
