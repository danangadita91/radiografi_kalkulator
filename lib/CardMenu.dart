import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget {
  CardMenu({@required this.childCard});
  final Widget childCard;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 185,
      width: 145,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 2,
            color: Colors.grey.withOpacity(1)),
      ),
      child: childCard,
    );
  }
}
