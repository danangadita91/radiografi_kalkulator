import 'package:flutter/material.dart';
import 'package:radiografi_kalkulator/CalculateBrain.dart';
import 'package:radiografi_kalkulator/Pages/Pewaktu.dart';
import 'package:radiografi_kalkulator/Widgets/MyButton.dart';
import 'package:radiografi_kalkulator/Widgets/MyDisplay.dart';
import 'package:radiografi_kalkulator/MyImages.dart';
import 'package:radiografi_kalkulator/TextStyle.dart';
import 'package:radiografi_kalkulator/Widgets/CustomAppbar.dart';
import 'package:radiografi_kalkulator/Pages/DataPipa.dart';
import 'package:radiografi_kalkulator/Pages/WaktuPenyinaran.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';

class WaktuParo extends StatefulWidget {
  @override
  _WaktuParoState createState() => _WaktuParoState();
}

class _WaktuParoState extends State<WaktuParo> {
  //Key
  final _formHalfLife = GlobalKey<FormState>();
  //Type String
  String detCurrie, setStartDate, setEndDate, display = '';
  //Type Int
  int dateDifferences = 0;
  // Type DateTime
  DateTime startDate = DateTime.now(); DateTime endDate = DateTime.now();
  // FocusNode
  FocusNode focusStartDate, focusEndDate = FocusNode();
  //Controller
  TextEditingController _ci =  TextEditingController();
  TextEditingController _date1Control =  TextEditingController();
  TextEditingController _date2Control =  TextEditingController();
  //Type List
  ListItem _selectedSource;
  List<DropdownMenuItem<ListItem>> _sourceMenuItems;

  void initState() {
    _date2Control.text = formatDate(endDate, [d, '-', M, '-',yy]);
    _date2Control = TextEditingController();
    _date1Control.text = formatDate(startDate, [d, '-', M, '-',yy]);
    _date1Control = TextEditingController();
    super.initState();
    _sourceMenuItems = buildDropDownMenuItems(_dropSource);
    _selectedSource = _sourceMenuItems[0].value;
  }
  @override
  void dispose(){
    _ci.dispose();
    super.dispose();
  }

  //Baris 1 DropDown Jenis Sumber
  List<ListItem> _dropSource = [
    ListItem (75, '   Iridium 192 (Ir-192)'),
    ListItem (1934.5, '   Cobalt (Co-60)'),
    ListItem (120, '   Selenium (Se-75)'),
    ListItem (10986.5, '   Caesium (Cs-137)'),
    ListItem (32, '   Ytterbium (Yt-169)'),
    ListItem (130, '   Thulium (TM-170)'),
  ];
  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {items.add(DropdownMenuItem(
        child: Text(listItem.nameSource, textAlign: TextAlign.justify),
      value: listItem,));
    }
    return items;
  }

  Future<void> _startDate(BuildContext context) async {
    final DateTime picked1 = await showDatePicker(context: context,
        initialDate: startDate, fieldLabelText: 'Plih Tanggal Awal',
        errorFormatText: 'Tanggal Salah', helpText: 'Pilih Tanggal Awal',
        fieldHintText: 'DD/MM/YY', cancelText: 'Batal', confirmText: 'Set',
        firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked1 != null && picked1 != startDate){
      setState(() {
        startDate = picked1;
        dateDiff();
        _date1Control.text = formatDate(startDate, [d, '-', M, '-',yyyy]);
      });
    }
    if (focusStartDate != null) {
      focusStartDate.nextFocus();
    }
  }

  Future<void> _endDate(BuildContext context) async {
    final DateTime picked2 = await showDatePicker(context: context,
        initialDate: endDate, fieldLabelText: 'Plih Tanggal Akhir',
        errorFormatText: 'Tanggal Salah', helpText: 'Pilih Tanggal Akhir',
        fieldHintText: 'DD/MM/YY', cancelText: 'Batal', confirmText: 'Set',
        firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked2 != null && picked2 != endDate){
      setState(() {
        endDate = picked2;
        dateDiff();
        _date2Control.text = formatDate(endDate, [d, '-', M, '-',yyyy]);
      });
    }
  }
  void dateDiff(){dateDifferences = endDate.difference(startDate).inDays;}

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(key: _formHalfLife,
          child: Column(
            children: <Widget>[Padding(padding: EdgeInsets.all(10)),
              //Custom AppBar
              CustomAppBar(barColor: Colors.transparent, shadow: Colors.blue,
                titleBar: 'Waktu Paro', backLogo: Icons.keyboard_backspace,
                tapBack: ()=>Get.back(), logoBar1: AssetImage(MyImages.pipeData),
                tapBar1: ()=> Get.to(()=> DataPipa()),
                logoBar2: AssetImage(MyImages.exposeTime),
                tapBar2: ()=> Get.to(()=> WaktuPenyinaran()),
                logoBar3: AssetImage(MyImages.timerCount),
                tapBar3: ()=> Get.to(()=> Pewaktu()),
              ),
              SizedBox(height: 15),
              //Baris 1(Jenis Sumber)
              Row(
                children: <Widget>[Padding(padding: EdgeInsets.all(15)),
                  //Text Label
                  Text('Jenis Sumber', style: SplashXForm),
                  Spacer(),
                  FrameDropdown(
                      childDrop: DropdownButton<ListItem>(
                          value: _selectedSource, items: _sourceMenuItems,
                          onChanged: (value){
                            setState(()=>_selectedSource = value);
                          })
                  ),
                  SizedBox(width: 25)
                ],
              ),
              SizedBox(height: 15),
              //Baris 2(Aktivitas Awal)
              Row(
                children: <Widget>[Padding(padding: EdgeInsets.all(15)),
                  //Text Label
                  Text('Aktivitas Awal', style: SplashXForm),
                  Spacer(),
                  //TextInput
                  Container(width: MediaQuery.of(context).size.width/2.4,
                    child: TextFormField(maxLength: 4, controller: _ci,
                        onChanged: (value){
                          setState(()=>detCurrie = value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Aktivitas Tidak Boleh Kosong';
                          }
                          return null;
                        },
                        decoration: InputDecoration(hintText: 'Aktivitas',
                            suffixText: 'Ci', counterText: '',
                            border: OutlineInputBorder(borderSide: BorderSide(
                                color: Colors.grey.withOpacity(1),width: 1)
                            ),
                            contentPadding: EdgeInsets.all(8)),
                        keyboardType: TextInputType.numberWithOptions(
                            decimal:true)
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
              SizedBox(height: 15),
              //Baris 3 (Tanggal Awal)
              Row(
                children: <Widget>[Padding(padding: EdgeInsets.all(15)),
                  Text('Tanggal Awal', style: SplashXForm),
                  Spacer(),
                  Container(width: MediaQuery.of(context).size.width/2.4,
                    child: TextFormField(style: TextStyle(color: Colors.blue),
                        focusNode: focusStartDate, controller: _date1Control,
                        onTap: () {
                          Get.focusScope.requestFocus(FocusNode());
                          _startDate(context);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tanggal Tidak Boleh Kosong';
                          }
                          return null;
                        },
                        onChanged: (String val){
                          setState(()=>setStartDate = val);
                        },
                        decoration: InputDecoration(hintText: 'Pilih Tanggal',
                            border: OutlineInputBorder(borderSide: BorderSide(
                                color: Colors.grey.withOpacity(1),width: 1)
                            ),
                            contentPadding: EdgeInsets.all(8))
                    ),
                  ),
                  SizedBox(width: 25)
                ],
              ),
              SizedBox(height: 15),
              //Baris 4(Tanggal Akhir)
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Padding(padding: EdgeInsets.all(15)),
                  //Text Label
                  Text('Tanggal Akhir', style: SplashXForm),
                  Spacer(),
                  //DatePicker
                  Container(width: MediaQuery.of(context).size.width/2.4,
                    child: TextFormField(style: TextStyle(color: Colors.blue),
                        controller: _date2Control, focusNode: focusEndDate,
                        onTap: () {
                          Get.focusScope.requestFocus(FocusNode());
                          _endDate(context);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tanggal Tidak Boleh Kosong';
                          }
                          return null;
                        },
                        onChanged: (String val){
                          setState(()=>setEndDate = val);
                        },
                        decoration: InputDecoration(hintText: 'Pilih Tanggal',
                            border: OutlineInputBorder(borderSide: BorderSide(
                                color: Colors.grey.withOpacity(1),width: 1)
                            ),
                            contentPadding: EdgeInsets.all(8))
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
              SizedBox(height: 40),
              //Baris 5(Button)
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonCalculate(label: 'Hitung', primaryColor: Colors.red,
                    onTap: () {
                    if(endDate.isBefore(startDate) && startDate.isAfter(endDate)){
                      Get.snackbar('Pilih Tanggal Ulang',
                          'Tanggal Akhir Tidak Boleh Lebih Kecil',
                          icon: Image(image: AssetImage(MyImages.logoSnackBar)),
                          backgroundColor: Colors.red);
                      Get.focusScope.canRequestFocus;
                    }else if(_formHalfLife.currentState.validate()) {
                        Get.snackbar('Menghitung Waktu Paruh',
                            'Kalkulator Radiografi', backgroundColor: Colors.green);
                        HalfLife calc = HalfLife(diffDate: dateDifferences,
                            source: _selectedSource.valueSource,
                            currie: double.parse(_ci.text)??0);
                        setState(()=>this.display = calc.calculateHalfTime());
                      }
                    },
                  )
                ],
              ),
              SizedBox(height: 40),
              DisplayCurrie(mainColor: Colors.blue, label: 'Currie',
                value: display.padLeft(2,'0')),
            ],
          ),
        )
      ),
    );
  }
}

class ListItem {
  double valueSource;
  String nameSource;
  ListItem(this.valueSource, this.nameSource);
}

