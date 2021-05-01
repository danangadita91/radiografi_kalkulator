import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Cons.dart';

//Button Hitung
class Hitung extends StatelessWidget {
  // ignore: non_constant_identifier_names
  Hitung ({@required this.Tekan, this.Warna, this.Label});
  // ignore: non_constant_identifier_names
  final Function Tekan;
  // ignore: non_constant_identifier_names
  final Color Warna;
  // ignore: non_constant_identifier_names
  final String Label;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.5,
      height: MediaQuery.of(context).size.height*0.06,
      // ignore: deprecated_member_use
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.grey),
        ),
        onPressed: Tekan,
        child: Text(
          Label,
          style: FormText,
        ),
        color: Warna,
      ),
    );
  }
}

//DiplayBox
class DisplayBox extends StatelessWidget {
  // ignore: non_constant_identifier_names
  DisplayBox ({@required this.Warna, this.Label, this.WarnaLabel, this.WarnaBorder, this.displayket, this.WarnaLabelket});
  // ignore: non_constant_identifier_names
  final Color Warna;
  // ignore: non_constant_identifier_names
  final String Label;
  // ignore: non_constant_identifier_names
  final Color WarnaLabel;
  // ignore: non_constant_identifier_names
  final Color WarnaBorder;
  final String displayket;
  final Color WarnaLabelket;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.5,
      height: MediaQuery.of(context).size.height*0.07,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: WarnaBorder.withOpacity(0.7),
                width: 5
            ),
            color: Warna
        ),
        child: Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 8,
              child: Text(Label,
              //FIx waktu paparan
              style: GoogleFonts.orbitron(fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: WarnaLabel),
              textAlign: TextAlign.center,
            ),),
            Flexible(flex: 1,
                fit: FlexFit.loose,
                child: Text(
                  displayket,
                  style: GoogleFonts.orbitron(fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: WarnaLabelket),
                  textAlign: TextAlign.center,
                ),)
            //Button
          ],
        ),
      ),
    );
  }
}

//DisplayDetail
class detailDisplay extends StatelessWidget {
  detailDisplay({@required this.warna, this.detail});
  final Color warna;
  final Widget detail;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.75,
      height: MediaQuery.of(context).size.height*0.15,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: warna),
        ),
        child:detail,
      ),
    );
  }
}









