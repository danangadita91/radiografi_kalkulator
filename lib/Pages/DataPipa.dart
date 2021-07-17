import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:radiografi_kalkulator/MyImages.dart';
import 'package:radiografi_kalkulator/Pages/Pewaktu.dart';
import 'package:url_launcher/url_launcher.dart';
import '../TextStyle.dart';
import '../Widgets/CustomAppbar.dart';
import 'package:radiografi_kalkulator/Pages/WaktuPenyinaran.dart';
import 'package:radiografi_kalkulator/Pages/WaktuParo.dart';

class DataPipa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            //Custom AppBar
            CustomAppBar(shadow: Colors.green, barColor: Colors.transparent,
              titleBar: 'Data Pipa', backLogo: Icons.keyboard_backspace,
              tapBack: ()=> Get.back(),
              logoBar1: AssetImage(MyImages.halfTime),
              tapBar1: ()=> Get.to(()=> WaktuParo()),
              logoBar2: AssetImage(MyImages.exposeTime),
              tapBar2: ()=> Get.to(()=> WaktuPenyinaran()),
              logoBar3: AssetImage(MyImages.timerCount),
              tapBar3: ()=> Get.to(()=> Pewaktu()),
            ),
            //PhotoView
            Container(
              child: AspectRatio(aspectRatio: 24/20,
                child: ClipRect(
                  child: PhotoView(imageProvider: AssetImage(MyImages.tableSch),
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 4,
                    enableRotation: false, backgroundDecoration: BoxDecoration(
                        color: Colors.transparent),
                  ),
                ),
              ),
            ),
            //Tap2x
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text('Tap 2x to Zoom', style: redFont)],
            ),
            SizedBox(height: 60),
            //Notes
            Row(
              children: <Widget>[
                Text('*Notes :', style: SplashXForm, textAlign: TextAlign.start),
                SizedBox(width: 5),
                Icon(Icons.circle, color: Colors.red),
                Text('X2', style: SplashXForm),
                SizedBox(width: 10),
                Icon(Icons.circle, color: Colors.green),
                Text('Standard', style: SplashXForm),
                Spacer(),
                RichText(text: TextSpan(text: 'Unit :', style: SplashXForm,
                      children: <TextSpan>[TextSpan(text:'Schedule (mm)',
                          style: SplashXForm)
                      ]
                  ),
                )
              ],
            ),
            //PipeData App
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(text: TextSpan(text: 'Source  :', style: SplashXForm,
                      children: <TextSpan>[TextSpan(text: ' PipeData App',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async{
                                var url = "https://play.google.com/store/apps/details?id=b4a.example2&hl=in&gl=US";
                                if (await canLaunch(url)) {await launch(url);
                                } else {throw 'Could not launch $url';}
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
