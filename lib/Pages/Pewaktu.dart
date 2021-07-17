import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:radiografi_kalkulator/Pages/DataPipa.dart';
import 'package:radiografi_kalkulator/MyImages.dart';
import 'package:radiografi_kalkulator/TextStyle.dart';
import 'package:radiografi_kalkulator/Pages/WaktuParo.dart';
import 'package:radiografi_kalkulator/Pages/WaktuPenyinaran.dart';
import 'package:radiografi_kalkulator/Widgets/CustomAppbar.dart';
import 'package:radiografi_kalkulator/Widgets/MyButton.dart';
import 'package:radiografi_kalkulator/timer_status.dart';

class Pewaktu extends StatefulWidget {
  @override
  _Pewaktu createState() => _Pewaktu();
}

class _Pewaktu extends State<Pewaktu> with TickerProviderStateMixin{
  //Local Notification
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  //bool Type
  bool _backGround = true; bool isVisible = false;
  //Timer
  Timer _timer; TimerStatus _timerStat = TimerStatus.set;
  Duration _duration = const Duration(hours: 0, minutes: 0, seconds: 0);
  //Int Type
  int _restDuration = 3 * 60;
  //String Type
  String _timerDuration='0:0:0'; String _leftBtnText='Start';
  String _rightBtnText='Set Timer';
  //Icon Type
  IconData _leftBtnIcon = Icons.play_arrow;
  IconData _rightBtnIcon = Icons.restore;

  // Start Timer
  void _startTimer({seconds}) {
    const secondPeriod = const Duration(seconds: 1);
    // Check the null safety of the "_countdownTimer", then Check if it is active!
    if ((_timer != null) && (_timer.isActive)) {
      _timer.cancel(); // Cancel/stop the countdown timer
    }
    _timer = Timer.periodic(secondPeriod, (Timer t) {
        if (_timerStat == TimerStatus.started)
          setState(() {
            // Update UI
            _restDuration--;
            _timerDuration = _durationAsString(
                duration: Duration(seconds: _restDuration));
          });
        //finished (done)
        if (_restDuration == 0) {
          setState(() {
            // Update the UI
            showNotificationMediaStyle();
            _timerStat = TimerStatus.finished;
            _leftBtnText = 'Start';
            _leftBtnIcon = Icons.play_arrow;
            t.cancel(); // Cancel the countdown timer (it is not needed anymore)
          });
        }
      },
    );
  }

  String _durationAsString({@required Duration duration}) {
    // Hours
    String digitHrs = _twoDigits(number: duration.inHours);
    // Minutes
    String digitMin = _twoDigits(number: duration.inMinutes.remainder(60));
    // Seconds
    String digitSec = _twoDigits(number: duration.inSeconds.remainder(60));
    return '$digitHrs:$digitMin:$digitSec';
  }
  // 2 Digits provided number (as string)
  String _twoDigits({number}) {
    return number.toString().padLeft(2, '0');
  }
  //Left Control Button
  void _leftBtnControl() {
    // Set -> Start -> Pause -> Resume
    switch (_timerStat) {
      case TimerStatus.set: // Start Now
        _restDuration = _duration.inSeconds;
        _startTimer(seconds: _restDuration);
        _timerStat = TimerStatus.started;
        setState(() {
          _backGround = !_backGround;
          _timerDuration = _durationAsString(
              duration: Duration(seconds: _restDuration));
          _leftBtnText = 'Pause';
          _leftBtnIcon = Icons.pause;
        });
        break;
      case TimerStatus.started: // Stop Now
        _timerStat = TimerStatus.paused;
        setState(() {
          _backGround = !_backGround;
          _leftBtnText = 'Resume';
          _leftBtnIcon = Icons.play_arrow;
        });
        break;
      case TimerStatus.paused: // Resume Now
      // Pause the Timer Now (started -> paused)
        _timerStat = TimerStatus.started;
        setState(() {
          _backGround =!_backGround;
          _leftBtnText = 'Pause';
          _leftBtnIcon = Icons.pause;
        });
        break;
      case TimerStatus.finished: // Restart
        _restDuration = _duration.inSeconds;
        _startTimer(seconds: _restDuration);
        _timerStat = TimerStatus.started;
        cancelNotification();
        setState(() {
          _backGround=!_backGround;
          _leftBtnText = 'Pause';
          _leftBtnIcon = Icons.pause;
        });
        break;
    }
  }
  //Right Control Button
  void _rightBtnControl() {
    setState(() {
      _backGround = true;
      _timerStat = TimerStatus.set;
      _leftBtnText = 'Start';
      _leftBtnIcon = Icons.play_arrow;
    });
  }

  @override
  void initState() {
    super.initState();
    _backGround=true;
    isVisible=false;
    var initializationSettingsAndroid =
    AndroidInitializationSettings('k_radiograi');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings);
  }
  @override
  void dispose() {
    //cancel the countdown timer before disposing the screen
    _timer.cancel();
    super.dispose();
  }
  void visibleRow(){
    if(_duration.inHours==0||_duration.inMinutes==0||_duration.inSeconds==0){
      setState(()=>isVisible=false);
    }
  }
  void hideRow(){
    if(_duration.inHours>=1||_duration.inMinutes>=1||_duration.inSeconds>=1){
      setState(()=>isVisible=true);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = false;
    try {
      if ((Platform.isAndroid) || (Platform.isIOS)) {
        isMobile = true;
      } else {
        isMobile = false;
      }
    } catch (e) {
      isMobile = false;
    }
    double cpiDimensions=isMobile? MediaQuery.of(context).size.width-70:cpiForWeb;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            //Custom AppBar
            CustomAppBar(shadow: Colors.indigo, barColor: Colors.transparent,
              titleBar: 'Pewaktu', backLogo: Icons.keyboard_backspace,
              tapBack: ()=>Get.back(), logoBar1: AssetImage(MyImages.pipeData),
              tapBar1: () => Get.to(()=>DataPipa()),
              logoBar2: AssetImage(MyImages.exposeTime),
              tapBar2: ()=> Get.to(()=> WaktuPenyinaran()),
              logoBar3: AssetImage(MyImages.halfTime),
              tapBar3: () => Get.to(()=>WaktuParo()),
            ),
            Padding(padding: edgePadding,
              child: _timerStat == TimerStatus.set ? ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: cpiDimensions, maxWidth: double.infinity,
                  minHeight: cpiDimensions, maxHeight: double.infinity,
                ),
                child: CupertinoTimerPicker(initialTimerDuration: _duration,
                    mode: CupertinoTimerPickerMode.hms,
                    onTimerDurationChanged: (Duration duration) {
                      _duration = duration;
                      visibleRow();
                      hideRow();
                    }),
              ) : Stack(children: <Widget>[
                ConstrainedBox(constraints: BoxConstraints(
                    minWidth: cpiDimensions, maxWidth: double.infinity,
                    minHeight: cpiDimensions, maxHeight: double.infinity),
                  child: Center(
                      child: Text('$_timerDuration', style: DurationStyle)),
                ),
                Center(
                  child: ConstrainedBox(constraints: BoxConstraints(
                    minWidth: cpiDimensions, maxWidth: double.infinity,
                    minHeight: cpiDimensions, maxHeight: double.infinity),
                    child: CircularProgressIndicator(strokeWidth: 24,
                      backgroundColor: cpiBackgroundColor,
                      valueColor: AlwaysStoppedAnimation<Color>(cpiHeadColor),
                      value: 1 - (_restDuration / _duration.inSeconds) + 0.002,
                    ),
                  ),
                ),
                Center(
                  child: ConstrainedBox(constraints: BoxConstraints(
                    minWidth: cpiDimensions, maxWidth: double.infinity,
                    minHeight: cpiDimensions, maxHeight: double.infinity),
                    child: CircularProgressIndicator(strokeWidth: 24,
                      value: 1 - (_restDuration / _duration.inSeconds),
                      valueColor: AlwaysStoppedAnimation<Color>(
                          (_timerStat != TimerStatus.finished)
                              ? cpiValueColor : cpiDoneColor),
                      semanticsLabel: 'Counting down',
                      semanticsValue: '$_restDuration seconds left'),
                  ),
                ),
              ]),
            ),
            //Button
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Visibility(visible: isVisible,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Visibility(visible: (_timerStat == TimerStatus.finished)
                            ? false : true,
                          child: Padding(padding: btnPadding,
                            child: ButtonForTimer(iconButton: Icon(_leftBtnIcon),
                              title: _leftBtnText, onPress: _leftBtnControl,
                              primaryColor: _backGround?Colors.green:Colors.red),
                          ),
                        ),
                        Visibility(visible: (_timerStat==TimerStatus.set)
                            ? false : true,
                          child: Padding(padding: btnPadding,
                            child: ButtonForTimer(iconButton: Icon(_rightBtnIcon),
                              onPress: _rightBtnControl, title: _rightBtnText,
                              primaryColor: Colors.blueAccent),
                          ),
                        )
                      ],
                    )
                )
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
        0, 'Kalkulator Radiografi', 'Waktu Habis.. Engkol broo !!!!',
        platformChannelSpecifics,
        payload: 'Kalkulator Radiografi Local Notification');
    // showNotification();
  }
  //Cancel Notification
  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
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