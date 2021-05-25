import 'package:flutter/material.dart';
import 'CardDetail.dart';
import 'CardMenu.dart';
import 'DataPipa.dart';
import 'Pewaktu.dart';
import 'TentangApp.dart';
import 'WaktuPaparan.dart';
import 'package:radiografi_kalkulator/WaktuParo.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const snackBarDuration = Duration(seconds: 5);

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
                                Get.to(()=>WaktuParo());
                              },
                              child: CardMenu(
                                childCard: CardDetail(
                                  warna: Colors.blue,
                                  logo: AssetImage('assets/images/half_circle.png'),
                                  labelTitle: 'Waktu Paro',
                                  labelDetail: 'Waktu Peluruhan\nSumber Radiasi',
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            //Card 2 Data Pipa
                            GestureDetector(
                              onTap: () {
                                Get.to(()=> DataPipa());
                              },
                              child: CardMenu(
                                childCard: CardDetail(
                                  warna: Colors.green,
                                  logo: AssetImage('assets/images/pipe.png'),
                                  labelTitle: 'Data Pipa',
                                  labelDetail: 'Data Ketebalan\nPipa',
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
                                Get.to(()=> WaktuPaparan());
                              },
                              child: CardMenu(
                                childCard: CardDetail(
                                  warna: Colors.red,
                                  logo: AssetImage('assets/images/clock.png'),
                                  labelTitle: 'Waktu Penyinaran',
                                  labelDetail: 'Hitung Waktu\nPenyinaran',
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            //Card 4 Pewaktu
                            GestureDetector(
                              onTap: () {
                                Get.to(()=> Pewaktu());
                              },
                              child: CardMenu(
                                childCard: CardDetail(
                                  warna: Colors.indigo,
                                  logo: AssetImage('assets/images/hourglass.png'),
                                  labelTitle: 'Pewaktu\nMundur',
                                  labelDetail: 'Pewaktu Mundur\nStopWatch',
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
                                Get.to(()=> TentangApp());
                              },
                              child: CardMenu(
                                childCard: CardDetail(
                                  warna: Colors.blueGrey,
                                  logo: AssetImage('assets/images/about.png'),
                                  labelTitle: 'Tentang\nAplikasi',
                                  labelDetail: 'Tentang Aplikasi',
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
      Get.snackbar(
          'Tekan Sekali Lagi Untuk Keluar Aplikasi',
          'Kalkulator Radiografi',
        backgroundColor: Colors.blue
      );
      return false;
    }
    return true;
  }
}

