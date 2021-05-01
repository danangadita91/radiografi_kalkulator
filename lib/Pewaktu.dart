import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:numberpicker/numberpicker.dart';
import 'ClassButton.dart';
import 'Cons.dart';
import 'CustomAppbar.dart';
import 'DataPipa.dart';
import 'HomePage.dart';
import 'WaktuPaparan.dart';
import 'WaktuParo.dart';

class Pewaktu extends StatefulWidget {
  @override
  _PewaktuState createState() => _PewaktuState();
}

class _PewaktuState extends State<Pewaktu> with TickerProviderStateMixin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stoped = true;
  int timerForTImer = 0;
  String timetodisplay ='0';
  bool checktimer = true;
  //LocalNotification
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('k_radiograi');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
    flutterLocalNotificationsPlugin.initialize(initSetttings);
  }
  //Timer
  void start(){
    setState(() {
      started = false;
      stoped = false;});
    timerForTImer = ((hour * 60 * 60)+ (min*60)+ sec);
    Timer.periodic(Duration(seconds: 1
    ), (Timer t){
      setState(() {
        if(timerForTImer <1 || checktimer == false){
          t.cancel();
          timetodisplay = '0';
          showNotificationMediaStyle();
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Pewaktu()
          ));
        }else if(timerForTImer <60){
          timetodisplay = timerForTImer.toString();
          timerForTImer = timerForTImer -1;
        }else if(timerForTImer < 3600){
          int m = timerForTImer ~/60;
          int s = timerForTImer - (60*m);
          timetodisplay = m.toString() + ' : '+ s.toString();
          timerForTImer =timerForTImer -1;
        }else{
          int h = timerForTImer ~/3600;
          int t = timerForTImer -(3600*h);
          int m = t ~/ 60;
          int s = t - (60*m);
          timetodisplay =
              h.toString() + ':' + m.toString() + ':' + s.toString();
          timerForTImer = timerForTImer -1;
        }
      });
    });
  }
  void stop(){
    setState(() {
      cancelNotification();
      started = true;
      stoped = true;
      checktimer = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            //Custom AppBar
            CustomAppBar(
              WarnaBar: Colors.indigo,
              Title: 'Pewaktu',
              BackLogo: Icons.keyboard_backspace,
              PressBack: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
              LogoBar1: AssetImage('assets/images/pipe.png'),
              TapBar1: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataPipa(),
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
              LogoBar3: AssetImage('assets/images/half_circle.png'),
              TapBar3: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WaktuParo(),
                    ));
              },
            ),
            //Timer Piker
            Container(
              margin: EdgeInsets.all(40),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.indigo.withOpacity(0.8),
                  width: 5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Ja,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text('Jam',
                        style: FormTimer,
                      ),
                      NumberPicker.integer(
                          infiniteLoop: true,
                          selectedTextStyle: NumbPickerSelected,
                          textStyle: NumbPickerShadow,
                          initialValue: hour,
                          minValue: 0,
                          maxValue: 24,
                          listViewWidth: 60.0,
                          onChanged: (val){
                            setState(() {
                              hour = val;
                            });
                          }
                      ),
                    ],
                  ),
                  Text('-',
                    textScaleFactor: 4,
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                  //Menit
                  Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text('Menit',
                        style: FormTimer,
                      ),
                      NumberPicker.integer(
                          infiniteLoop: true,
                          selectedTextStyle: NumbPickerSelected,
                          textStyle: NumbPickerShadow,
                          initialValue: min,
                          minValue: 0,
                          maxValue: 59,
                          listViewWidth: 60.0,
                          onChanged: (val){
                            setState(() {
                              min = val;
                            });
                          }
                      ),
                    ],
                  ),
                  Text('-',
                    textScaleFactor: 4,
                    style: TextStyle(
                      color: Colors.black
                  ),
                  ),
                  //Detik
                  Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text('Detik',
                        style: FormTimer,
                      ),
                      NumberPicker.integer(
                          infiniteLoop: true,
                          selectedTextStyle: NumbPickerSelected,
                          textStyle: NumbPickerShadow,
                          initialValue: sec,
                          minValue: 0,
                          maxValue: 59,
                          listViewWidth: 60.0,
                          onChanged: (val){
                            setState(() {
                              sec = val;
                            });
                          }
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            //Display Timer
            DisplayBox(
              WarnaBorder: Colors.indigo,
              Warna: Colors.white,
              WarnaLabel: Colors.red,
              Label: timetodisplay,
            ),
            SizedBox(height: 30),
            //Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //Button Start
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: started? start :null,
                  padding: EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 17,
                  ),
                  color: Colors.green,
                  child: Text(
                      'Start',
                      style: TextButtons
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                //Button Stop
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: stoped? null : stop,
                  padding: EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 17,
                  ),
                  color: Colors.redAccent,
                  child: Text(
                      'Stop',
                      style: TextButtons
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  //Notification
  Future<void> showNotificationMediaStyle() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      'media channel description',
      color: Colors.red,
      enableLights: true,
      icon: 'k_radiograi',
      playSound: true,
      priority: Priority.high,
      importance: Importance.max,
      largeIcon: DrawableResourceAndroidBitmap("k_radiograi"),
      sound: RawResourceAndroidNotificationSound('alarm_tone'),
      styleInformation: MediaStyleInformation(),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'alarm_tone.mp3',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    NotificationDetails(iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Kalkulator Radiografi', 'notification body', platformChannelSpecifics,
    payload: 'Kalkulator Radiografi Local Notification');
    showNotification();
  }
  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0,tag: 'DiBatalkan');
  }

  showNotification() async {
    var android = AndroidNotificationDetails(
        'id', 'media channel name', 'media channel description',
        priority: Priority.high,
        importance: Importance.max,
        timeoutAfter: 50000,
        largeIcon: DrawableResourceAndroidBitmap("k_radiograi"));
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Notifikasi Pewaktu', 'Waktu Habis.. Engkol Broo !!!!!!!', platform,
        payload: 'Kalkulator Radiografi Local Notification');
  }
}

