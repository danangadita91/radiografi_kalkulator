import 'dart:async';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'Cons.dart';
import 'HomePage.dart';
import 'SplashImage.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        )
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SplashScreen> {
  @override
  //Pindah Layar
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 4),
            () {
          Navigator.push(
            context, MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(
              flex:4,
            ),
            SplashImage(
                LogoSplash: AssetImage(
                    'assets/images/hazardous.png'
                )),
            Text('Kalkulator Radiografi',
              style: SplashTitleLabel,
            ),
            SizedBox(
              height: 20,
            ),
            Text('Untuk Uji Radiografi Industri',
              style: SplashDetailLabel,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
