import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'TextStyle.dart';
import 'CustomAppbar.dart';
import 'HomePage.dart';
import 'Pewaktu.dart';
import 'WaktuPaparan.dart';
import 'WaktuParo.dart';

class TentangApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            //Custom AppBar
            CustomAppBar(
              bayangan: Colors.blueGrey,
              warnaBar: Colors.transparent,
              judul: 'Tentang Aplikasi',
              logoBalik: Icons.keyboard_backspace,
              pencetBalik: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
              logoBar1: AssetImage('assets/images/half_circle.png'),
              tapBar1: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WaktuParo(),
                    ));
              },
              logoBar2: AssetImage('assets/images/clock.png'),
              tapBar2: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WaktuPaparan(),
                    ));
              },
              logoBar3: AssetImage('assets/images/hourglass.png'),
              tapBar3: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pewaktu(),
                    ));
              },
            ),
            //Disclaimer
            SafeArea(
              minimum: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Text(''
                        'Kalkulator Radiografi',
                      style: TitleAbout,
                    ),
                    SizedBox(height: 25),
                    Text(
                        'Kalkulator Radiografi Adalah'
                            ' Aplikasi Pendukung'
                            ' Pengujian Radiografi Industri Untuk'
                            ' Menghitung Waktu Paparan, Waktu Paro, Melihat Data Pipa'
                            ' dan Pewaktu Mundur\n'
                            ' \nBerdasarkan Persyaratan Lapangan.',
                      style: DetailAbout,
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.4,
                    )
                  ],
                )
            ),
            //kritik
            Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  //Kritik dan Saran
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(10)),
                      Text('Kritik dan Saran',
                        style: TitleAbout,
                        textScaleFactor: 0.8,
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  //Email
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(10)),
                      //Icon Email
                      Icon(Icons.attach_email,
                        color: Colors.redAccent,
                      ),
                      //Link Text
                      RichText(
                        text: TextSpan(
                            text: '   ',
                            children: <TextSpan>[
                              TextSpan(text: ' k_radiografi@gmail.com',
                                  style: LinkEmail,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async{
                                final url = Mailto(
                                  to: [
                                    'K_Radiografi@gmail.com'
                                  ],
                                  cc: [
                                    'danang.aditarsd@gmail.com'
                                  ],
                                  bcc: [
                                    'danang.aditaras@mhs.pelitabangsa.ac.id'
                                  ],
                                  subject: 'Saran Untuk Aplikasi Anda (Kalkulator Radiografi)',
                                  body: 'Assalamualaikum  \nSalam Sejahtera\n\n'
                                ).toString();
                                if (await canLaunch(url)){
                                  await launch(url);
                                }else{
                                  showCupertinoDialog(
                                      context: context,
                                      builder: MailClientOpenErrorDialog(url:url).build,
                                  );
                                }
                                    },
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(10)),
                      Icon(Icons.location_searching_rounded,
                          color: Colors.red),
                      RichText(
                        text: TextSpan(
                            text: '   ',
                            children: <TextSpan>[
                              TextSpan(text: ' Jl. Mutiara 1 no 30, MBJ',
                                  style: LinkEmail,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async{
                                      var maps = "https://www.google.com/maps/dir//-6.4116486,107.093351/@-6.4116026,107.0932397,20z";
                                      if (await canLaunch(maps)) {
                                        await launch(maps);
                                      } else {
                                        throw 'Could not launch $maps';
                                      }
                                    }
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MailClientOpenErrorDialog extends StatelessWidget {
  final String url;
  const MailClientOpenErrorDialog({Key key, @required this.url})
  : assert(url !=null),
  assert(url != ''),
  super (key: key);
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Gagal Membuka'),
      content: Text('Aplikasi Tidak Bisa Membuka Url : \n$url'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

