import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'TextStyle.dart';

//Button Hitung
// ignore: camel_case_types
class hitung extends StatelessWidget {
  hitung ({@required this.tekan, this.label});
  final Function tekan;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.5,
      height: MediaQuery.of(context).size.height*0.06,
      // ignore: deprecated_member_use
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey),
        ),
        onPressed: tekan,
        child: Text(
          label,
          style: btnText,
        ),
        color: Colors.red,
      ),
    );
  }
}

class DiplayCi extends StatelessWidget {
  DiplayCi({@required this.label, this.warnaLabel, this.warnaBorder, this.warna});
  final Color warna;
  final Color warnaLabel;
  final String label;
  final Color warnaBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.5,
      height: MediaQuery.of(context).size.height*0.07,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: warnaBorder.withOpacity(0.7),
                width: 5
            ),
            color: warna
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 8,
              child: Text(label,
                //FIx waktu paparan
                style: GoogleFonts.orbitron(fontSize: 30,
                    fontWeight: FontWeight.w500, color: warnaLabel),
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(
                child: Text(
                  'Ci',style: textDisplay,
                ))
            //Button
          ],
        ),
      ),
    );
  }
}

class TampilTimer extends StatelessWidget {
  TampilTimer ({@required this.warna, this.warnaBorder, this.warnaLabel, this.jamTimer, this.menitTimer, this.detikTimer});
  final Color warna;
  final Color warnaBorder;
  final Color warnaLabel;
  final String jamTimer;
  final String menitTimer;
  final String detikTimer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.5,
      height: MediaQuery.of(context).size.height*0.1,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: warnaBorder.withOpacity(0.7),
                width: 5
            ),
            color: warna
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  jamTimer,style: GoogleFonts.orbitron(fontSize: 40,
                    color: warnaLabel),
                ),
                Text(
                  'Jam',style: TextKetTimer,
                )
              ],
            ),
            SizedBox(width: 10),
            Text(':',style: TextKetTimer,textScaleFactor: 2),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  menitTimer,style: GoogleFonts.orbitron(fontSize: 40,
                    color: warnaLabel),
                ),
                Text(
                  'Menit',style: TextKetTimer,
                )
              ],
            ),
            SizedBox(width: 10),
            Text(':',style: TextKetTimer,textScaleFactor: 2),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    detikTimer,style: GoogleFonts.orbitron(fontSize: 40,
                    color: warnaLabel)
                ),
                Text(
                  'Detik',style: TextKetTimer,
                )
              ],
            ),
            //Button
          ],
        ),
      ),
    );
  }
}


class TampilWaktuPaparan extends StatelessWidget {
  TampilWaktuPaparan ({@required this.menit, this.detik, this.warna, this.warnaLabel, this.warnaBorder});
  final String menit;
  final String detik;
  final Color warna;
  final Color warnaLabel;
  final Color warnaBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.5,
      height: MediaQuery.of(context).size.height*0.1,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: warnaBorder.withOpacity(0.7),
                width: 5
            ),
            color: warna
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  menit,style: GoogleFonts.orbitron(fontSize: 55,
                    color: warnaLabel),
                ),
                Text(
                    'Menit',style: TextKetTimer,
                )
              ],
            ),
            SizedBox(width: 10),
            Text(':',style: TextKetTimer,textScaleFactor: 2),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  detik,style: GoogleFonts.orbitron(fontSize: 55,
                    color: warnaLabel)
                ),
                Text(
                    'Detik',style: TextKetTimer,
                )
              ],
            ),
            //Button
          ],
        ),
      ),
    );
  }
}

//DiplayBox
class DisplayBox extends StatelessWidget {
  // ignore: non_constant_identifier_names
  DisplayBox ({@required this.Warna, this.Label, this.WarnaLabel, this.WarnaBorder});
  // ignore: non_constant_identifier_names
  final Color Warna;
  // ignore: non_constant_identifier_names
  final String Label;
  // ignore: non_constant_identifier_names
  final Color WarnaLabel;
  // ignore: non_constant_identifier_names
  final Color WarnaBorder;
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
            //Button
          ],
        ),
      ),
    );
  }
}









