import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiografi_kalkulator/MyImages.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:radiografi_kalkulator/TextStyle.dart';
import 'package:radiografi_kalkulator/Pages/HomePage.dart';
import 'package:flutter/services.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: SplashScreen(),
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200, minWidth: 450, defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ]
        ));
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SplashScreen> {
  @override
  //Pindah Layar
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () => Get.off(HomePage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Spacer(flex:6),
            //Images
            Image(width: splashSize, image: AssetImage(MyImages.splashImage)),
            SizedBox(height: 15),
            //Title
            Text('Kalkulator Radiografi', style: splashTitle),
            SizedBox(height: 10),
            //Detail
            Text('Untuk Uji Radiografi Industri', style: SplashXForm),
            Spacer()
          ],
        ),
      ),
    );
  }
}