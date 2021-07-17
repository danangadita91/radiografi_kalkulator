import 'dart:math';

const double inch =25.4;
const double minToSec = 60;
const double tParo  =0.5;

//Calculate HalfLife
class HalfLife{
  HalfLife({this.currie,this.diffDate,this.source});
  final double currie, source; final int diffDate;
  double half;

  //HalfLife
  String calculateHalfTime(){
    half = pow(tParo, diffDate/source)*currie;
    return half.toStringAsFixed(2);
  }
}
//Calculate Exposure Time
class ExposeTime{
  ExposeTime({this.thickness, this.wall, this.sfd, this.currie, this.film});
  final double thickness, wall, sfd, currie, film;

  double expose, minFraction, befLog, antLog;
  int minSexagesimal,secSexagesimal;
  //Before Log
  String beforeLog(){
    befLog = thickness/inch*wall;
    return befLog.toString();
  }
  //AntiLog
  String antiLogaritma(){
    antLog = exp(double.parse(beforeLog()));
    return antLog.toString();
  }
  String calculateExpose(){
    expose = double.parse(antiLogaritma())*(6.5*sfd*sfd/currie/minToSec*film);
    return expose.toStringAsFixed(4);
  }

  //Result in Min
  String showMinSexagesimal(){
    double derajat = double.tryParse(calculateExpose());
    minSexagesimal = derajat.toInt();
    return minSexagesimal.toString();
  }
  //Result in Sec
  String showSecSexagesimal(){
    minFraction = minToSec * (expose-minSexagesimal);
    secSexagesimal = minFraction.toInt();
    return secSexagesimal.toString();
  }
}