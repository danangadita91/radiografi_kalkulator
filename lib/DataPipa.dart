import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Cons.dart';
import 'CustomAppbar.dart';
import 'HomePage.dart';
import 'Pewaktu.dart';
import 'WaktuPaparan.dart';
import 'WaktuParo.dart';

class DataPipa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            //Custom AppBar
            CustomAppBar(
              WarnaBar: Colors.green,
              Title: 'Data Pipa',
              BackLogo: Icons.keyboard_backspace,
              PressBack: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
              LogoBar1: AssetImage('assets/images/half_circle.png'),
              TapBar1: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WaktuParo(),
                    ));
              },
              LogoBar2: AssetImage('assets/images/clock.png'),
              TapBar2: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WaktuPaparan(),
                    ));
              },
              LogoBar3: AssetImage('assets/images/hourglass.png'),
              TapBar3: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pewaktu(),
                    ));
              },
            ),
            //PhotoView
            Container(
              child: AspectRatio(
                aspectRatio: 24/20,
                child: ClipRect(
                  child: PhotoView(
                    imageProvider: AssetImage('assets/images/pipesch.png'),
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 4,
                    enableRotation: false,
                    backgroundDecoration: BoxDecoration(color: Colors.transparent),
                  ),
                ),
              ),
            ),
            //Tap2x
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Tap 2x to Zoom',
                style: TextStyle(
                  color: Colors.red
                ))
              ],
            ),
            SizedBox(height: 60),
            //Notes
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('*Notes :',
                    style: FormText,
                    textAlign: TextAlign.start
                ),
                SizedBox(width: 5),
                Icon(Icons.circle,
                    color: Colors.red
                ),
                Text('X2',
                    style: FormText
                ),
                SizedBox(width: 10),
                Icon(Icons.circle,
                    color: Colors.green
                ),
                Text('Standard',
                    style: FormText
                ),
                Spacer(),
                RichText(
                  text: TextSpan(
                      text: 'Unit :',
                      style: FormText,
                      children: <TextSpan>[
                        TextSpan(
                            text:'Schedule (mm)',
                            style: FormText
                        ),
                      ]
                  ),
                )
              ],
            ),
            //PipeData App
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      text: 'Source  :',
                      style: FormText,
                      children: <TextSpan>[
                        TextSpan(text: ' PipeData App',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async{
                                var url = "https://play.google.com/store/apps/details?id=b4a.example2&hl=in&gl=US";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
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
    );
  }
}
