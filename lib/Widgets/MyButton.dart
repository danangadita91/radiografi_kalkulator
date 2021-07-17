import 'package:flutter/material.dart';
import 'package:radiografi_kalkulator/TextStyle.dart';

//For Dropdown
class FrameDropdown extends StatelessWidget {
  FrameDropdown({@required this.childDrop});
  final Widget childDrop;

  @override
  Widget build(BuildContext context) {
    return Container(width: MediaQuery.of(context).size.width/2.4,
      child: DecoratedBox(decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), border: Border.all(
          color: Colors.grey.withOpacity(1),width: 1),
        ),
        child: DropdownButtonHideUnderline(child: childDrop),
      ),
    );
  }
}
//Button Calculate
class ButtonCalculate extends StatelessWidget {
  ButtonCalculate ({@required this.onTap, this.label, this.primaryColor});
  final Function onTap; final String label; final Color primaryColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(onPressed: onTap, style: ElevatedButton.styleFrom(
          elevation: 4, primary: primaryColor, padding: EdgeInsets.symmetric(
          horizontal: 54, vertical: 18)),
          child: Text(label, style: TextButtons)),
    );
  }
}
//Button Page Pewaktu
class ButtonForTimer extends StatelessWidget {
  ButtonForTimer({@required this.onPress, this.iconButton, this.title,
    this.primaryColor});
  final Function onPress; final Widget iconButton;
  final Color primaryColor; final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(elevation: 4, primary: primaryColor,
              shape: StadiumBorder(), padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10)), onPressed: onPress,
          icon: iconButton, label: Text(title,style: TextButtons)),
    );
  }
}
