import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CardDetail.dart';
import 'CardMenu.dart';
import 'DataPipa.dart';
import 'Pewaktu.dart';
import 'TentangApp.dart';
import 'WaktuPaparan.dart';
import 'package:radiografi_kalkulator/WaktuParo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const snackBarDuration = Duration(seconds: 3);

  final snackBar = SnackBar(
    content: Text('Tekan Sekali Lagi Untuk Keluar'),
    duration: snackBarDuration,
  );

  DateTime backButtonPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
          builder: (context){
            return WillPopScope(
                onWillPop: () => handleWillPop(context),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //Baris 1
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Card 1 Waktu Paro
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    PageRouteBuilder(pageBuilder: (BuildContext context,
                                          Animation<double> animation, Animation<double> secondaryAnimation,
                                          ) => WaktuParo(), transitionsBuilder: (
                                          BuildContext context, Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                          Widget child) => ScaleTransition(scale: Tween<double>(
                                            begin: 0.0,
                                            end: 1.0).animate(
                                            CurvedAnimation(
                                              parent: animation,
                                              curve: Curves.fastOutSlowIn,
                                            )), child: child,
                                      ),
                                      transitionDuration: Duration(milliseconds: 100),
                                    ));
                              },
                              child: CardMenu(
                                childCard: CardDetail(
                                  Warna: Colors.blue,
                                  Logo: AssetImage('assets/images/half_circle.png'),
                                  LabelTitle: 'Waktu Paro',
                                  LabelDetail: 'Waktu Peluruhan\nSumber Radiasi',
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            //Card 2 Data Pipa
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    PageRouteBuilder(
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                          ) => DataPipa(),
                                      transitionsBuilder: (
                                          BuildContext context, Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                          Widget child) => ScaleTransition(
                                        scale: Tween<double>(
                                            begin: 0.0,
                                            end: 1.0
                                        ).animate(
                                            CurvedAnimation(
                                              parent: animation,
                                              curve: Curves.fastOutSlowIn,
                                            )), child: child,
                                      ),
                                      transitionDuration: Duration(milliseconds: 1000),
                                    ));
                              },
                              child: CardMenu(
                                childCard: CardDetail(
                                  Warna: Colors.green,
                                  Logo: AssetImage('assets/images/pipe.png'),
                                  LabelTitle: 'Data Pipa',
                                  LabelDetail: 'Data Ketebalan\nPipa',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        //Baris 2
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Card 3 Waktu Paparan
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    PageRouteBuilder(
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                          ) => WaktuPaparan(),
                                      transitionsBuilder: (
                                          BuildContext context, Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                          Widget child) => ScaleTransition(
                                        scale: Tween<double>(
                                            begin: 0.0,
                                            end: 1.0
                                        ).animate(
                                            CurvedAnimation(
                                              parent: animation,
                                              curve: Curves.fastOutSlowIn,
                                            )), child: child,
                                      ),
                                      transitionDuration: Duration(milliseconds: 1000),
                                    ));
                              },
                              child: CardMenu(
                                childCard: CardDetail(
                                  Warna: Colors.red,
                                  Logo: AssetImage('assets/images/clock.png'),
                                  LabelTitle: 'Waktu Penyinaran',
                                  LabelDetail: 'Hitung Waktu\nPenyinaran',
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            //Card 4 Pewaktu
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    PageRouteBuilder(
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                          ) => Pewaktu(),
                                      transitionsBuilder: (
                                          BuildContext context, Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                          Widget child) => ScaleTransition(
                                        scale: Tween<double>(
                                            begin: 0.0,
                                            end: 1.0
                                        ).animate(
                                            CurvedAnimation(
                                              parent: animation,
                                              curve: Curves.fastOutSlowIn,
                                            )), child: child,
                                      ),
                                      transitionDuration: Duration(milliseconds: 1000),
                                    ));
                              },
                              child: CardMenu(
                                childCard: CardDetail(
                                  Warna: Colors.indigo,
                                  Logo: AssetImage('assets/images/hourglass.png'),
                                  LabelTitle: 'Pewaktu\nMundur',
                                  LabelDetail: 'Pewaktu Mundur\nStopWatch',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    PageRouteBuilder(
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                          ) => TentangApp(),
                                      transitionsBuilder: (
                                          BuildContext context, Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                          Widget child) => ScaleTransition(
                                        scale: Tween<double>(
                                            begin: 0.0,
                                            end: 1.0
                                        ).animate(
                                            CurvedAnimation(
                                              parent: animation,
                                              curve: Curves.fastOutSlowIn,
                                            )), child: child,
                                      ),
                                      transitionDuration: Duration(milliseconds: 1000),
                                    )
                                );
                              },
                              child: CardMenu(
                                childCard: CardDetail(
                                  Warna: Colors.blueGrey,
                                  Logo: AssetImage('assets/images/about.png'),
                                  LabelTitle: 'Tentang\nAplikasi',
                                  LabelDetail: 'Tentang Aplikasi',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
            );
          },
        )
    );
  }

  Future <bool> handleWillPop (BuildContext context) async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            now.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(snackBar);
      return false;
    }
    return true;
  }
}

