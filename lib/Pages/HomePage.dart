import 'package:flutter/material.dart';
import 'package:radiografi_kalkulator/Pages/Pewaktu.dart';
import 'package:radiografi_kalkulator/TextStyle.dart';
import 'package:radiografi_kalkulator/Widgets/CardDetail.dart';
import 'package:radiografi_kalkulator/Widgets/MyCard.dart';
import 'package:radiografi_kalkulator/Pages/DataPipa.dart';
import 'package:radiografi_kalkulator/MyImages.dart';
import 'package:radiografi_kalkulator/Pages/TentangApp.dart';
import 'package:radiografi_kalkulator/Pages/WaktuPenyinaran.dart';
import 'package:radiografi_kalkulator/Pages/WaktuParo.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final snackBar = SnackBar(content: Text('Tekan Sekali Lagi Untuk Keluar'),
      duration: snackBarDuration);

  DateTime backButtonPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(builder: (context){
            return WillPopScope(onWillPop: () => handleWillPop(context),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //Baris 1
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Card 1 Waktu Paro
                            GestureDetector(onTap: ()=> Get.to(()=> WaktuParo()),
                              child: MyCard(
                                childCard: CardDetail(mainColor: Colors.blue,
                                  logo: AssetImage(MyImages.halfTime),
                                  labelTitle: 'Waktu Paro',
                                  labelDetail: 'Waktu Peluruhan\nSumber Radiasi'),
                              ),
                            ),
                            SizedBox(width: 10),
                            //Card 2 Data Pipa
                            GestureDetector(onTap: ()=> Get.to(()=> DataPipa()),
                              child: MyCard(
                                childCard: CardDetail(mainColor: Colors.green,
                                  logo: AssetImage(MyImages.pipeData),
                                  labelTitle: 'Data Pipa',
                                  labelDetail: 'Data Ketebalan\nPipa'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        //Baris 2
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Card 3 Waktu Paparan
                            GestureDetector(
                              onTap: ()=> Get.to(()=> WaktuPenyinaran()),
                              child: MyCard(
                                childCard: CardDetail(mainColor: Colors.red,
                                  logo: AssetImage(MyImages.exposeTime),
                                  labelTitle: 'Waktu Penyinaran',
                                  labelDetail: 'Hitung Waktu\nPenyinaran'),
                              ),
                            ),
                            SizedBox(width: 10),
                            //Card 4 Pewaktu
                            GestureDetector(onTap: ()=> Get.to(()=> Pewaktu()),
                              child: MyCard(
                                childCard: CardDetail(mainColor: Colors.indigo,
                                  logo: AssetImage(MyImages.timerCount),
                                  labelTitle: 'Pewaktu\nMundur',
                                  labelDetail: 'Pewaktu Mundur\nStopWatch'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(onTap: ()=> Get.to(()=> TentangApp()),
                              child: MyCard(
                                childCard: CardDetail(mainColor: Colors.blueGrey,
                                  logo: AssetImage(MyImages.aboutApp),
                                  labelTitle: 'Tentang\nAplikasi',
                                  labelDetail: 'Tentang Aplikasi'),
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
        backButtonPressTime == null || now.difference(backButtonPressTime)
            > snackBarDuration;
    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      Get.snackbar('Tekan Sekali Lagi Untuk Keluar', 'Kalkulator Radiografi',
          backgroundColor: Colors.red, duration: Duration(seconds: 2),
          icon: Image(image: AssetImage(MyImages.logoSnackBar)));
      return false;
    }
    return true;
  }
}

