import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailto/mailto.dart';
import 'package:radiografi_kalkulator/MyImages.dart';
import 'package:radiografi_kalkulator/Pages/Pewaktu.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:radiografi_kalkulator/TextStyle.dart';
import 'package:radiografi_kalkulator/Widgets/CustomAppbar.dart';
import 'package:radiografi_kalkulator/Pages/WaktuPenyinaran.dart';
import 'package:radiografi_kalkulator/Pages/WaktuParo.dart';

class TentangApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            //Custom AppBar
            CustomAppBar(shadow: Colors.blueGrey, barColor: Colors.transparent,
              titleBar: 'Tentang Aplikasi', backLogo: Icons.keyboard_backspace,
              tapBack: () => Get.back(), logoBar1: AssetImage(MyImages.halfTime),
              tapBar1: () => Get.to(()=>WaktuParo()),
              logoBar2: AssetImage(MyImages.exposeTime),
              tapBar2: ()=> Get.to(()=> WaktuPenyinaran()),
              logoBar3: AssetImage(MyImages.timerCount),
              tapBar3: () => Get.to(()=>Pewaktu()),
            ),
            //Disclaimer
            SafeArea(minimum: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Text('Kalkulator Radiografi', style: TitleAbout),
                    SizedBox(height: 25),
                    Text('Kalkulator Radiografi Adalah'
                        ' Aplikasi Pendukung'
                        ' Pengujian Radiografi Industri Untuk'
                        ' Menghitung Waktu Paparan, Waktu Paro, Melihat Data Pipa'
                        ' dan Pewaktu Mundur\n'
                        ' \nBerdasarkan Persyaratan Lapangan.',
                      style: DetailAbout, textAlign: TextAlign.center,
                      textScaleFactor: 1.4)
                  ],
                )
            ),
            //kritik
            Container(height: MediaQuery.of(context).size.height/3,
              child: Column(mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  //Kritik dan Saran
                  Row(
                    children: <Widget>[Padding(padding: EdgeInsets.all(10)),
                      Text('Kritik dan Saran', style: TitleAbout)],
                  ),
                  SizedBox(height: 10),
                  //Email
                  Row(
                    children: <Widget>[Padding(padding: EdgeInsets.all(10)),
                      //Icon Email
                      Icon(Icons.attach_email,color: Colors.redAccent,size: 35),
                      //Link Text
                      RichText(text: TextSpan(text: '     ',
                            children: <TextSpan>[
                              TextSpan(text: ' k_radiografi@gmail.com',
                                style: LinkEmail,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async{
                                final url = Mailto(
                                    to: ['K_Radiografi@gmail.com'],
                                    cc: ['danang.aditarsd@gmail.com'],
                                    subject: 'Saran Untuk Aplikasi Anda'
                                ).toString();
                                if (await canLaunch(url)){await launch(url);
                                }else{showCupertinoDialog(context: context,
                                    builder: MailClientOpenErrorDialog(
                                      url:url).build);
                                }
                                    },
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
  final String url;const MailClientOpenErrorDialog({Key key, @required this.url})
  : assert(url !=null), assert(url != ''),
  super (key: key);
  Widget build(BuildContext context) {
    return AlertDialog(title: Text('Gagal Membuka'),
      content: Text('Aplikasi Tidak Bisa Membuka Url : \n$url'),
      actions: <Widget>[
        CupertinoDialogAction(isDefaultAction: true, child: Text('Ok'),
          onPressed: ()=>Navigator.of(context).pop(),
        ),
      ],
    );
  }
}