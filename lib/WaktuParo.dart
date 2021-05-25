import 'dart:math';
import 'package:flutter/material.dart';
import 'ClassButton.dart';
import 'TextStyle.dart';
import 'CustomAppbar.dart';
import 'DataPipa.dart';
import 'Pewaktu.dart';
import 'WaktuPaparan.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';

class WaktuParo extends StatefulWidget {
  @override
  _WaktuParoState createState() => _WaktuParoState();
}

class _WaktuParoState extends State<WaktuParo> {
  //Baris 1 DropDown Jenis Sumber
  List<ListItem> _dropJenis = [
    ListItem (75, '   Iridium 192 (Ir-192)'),
    ListItem (1934.5, '   Cobalt (Co-60)'),
    ListItem (120, '   Selenium (Se-75)'),
    ListItem (10986.5, '   Caesium (Cs-137)'),
    ListItem (32, '   Ytterbium (Yt-169)'),
    ListItem (130, '   Thulium (TM-170)'),
  ];
  List<DropdownMenuItem<ListItem>> _jenisMenuItems;
  ListItem _selectedJenis;

  void initState() {
    _tglAkhirController.text = formatDate(tglAkhir, [d, '-', M, '-',yy]);
    _tglAkhirController = TextEditingController();
    _tglAwalController.text = formatDate(tglAwal, [d, '-', M, '-',yy]);
    _tglAwalController = TextEditingController();
    super.initState();
    _jenisMenuItems = buildDropDownMenuItems(_dropJenis);
    _selectedJenis = _jenisMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(DropdownMenuItem(
        child: Text(listItem.name, textAlign: TextAlign.justify),
      value: listItem,)
      );
    }
    return items;
  }
  //Baris 2 Controler Aktifitas
  TextEditingController _aktivitas =  TextEditingController();
  String ketAktivitas = '';

  @override
  void dispose(){
    _aktivitas.dispose();
    super.dispose();
  }
  //Baris 3 DatePicker 1
  String setTglAwal= '';
  FocusNode focusTglAwal = FocusNode();
  TextEditingController _tglAwalController = TextEditingController();
  DateTime tglAwal = DateTime.now();
  Future<Null> _tglAwal(BuildContext context) async {
    final DateTime picked1 = await showDatePicker(
        context: context,
        initialDate: tglAwal,
        errorInvalidText: 'Tanggal di Luar Jangkauan',
        errorFormatText: 'Tanggal Salah',
        fieldLabelText: 'Plih Tanggal Awal',
        fieldHintText: 'Hari/Bulan/Tahun',
        helpText: 'Pilih Tanggal Awal',
        cancelText: 'Batal',
        confirmText: 'Set',
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked1 != null && picked1 != tglAwal){
      setState(() {
        tglAwal = picked1;
        dateDiff();
        _tglAwalController.text = formatDate(tglAwal, [d, '-', M, '-',yyyy]);
      });
    }
    if (focusTglAwal != null) {
      focusTglAwal.nextFocus();
    }
  }
  //Baris 4 DatePicker2
  FocusNode focusTglAkhir = FocusNode();
  String setTglAkhir= '';
  TextEditingController _tglAkhirController = TextEditingController();
  DateTime tglAkhir = DateTime.now();
  Future<Null> _tglAkhir(BuildContext context) async {
    final DateTime picked2 = await showDatePicker(
        context: context,
        initialDate: tglAkhir,
        errorInvalidText: 'Tanggal di Luar Jangkauan',
        errorFormatText: 'Tanggal Salah',
        fieldLabelText: 'Plih Tanggal Awal',
        fieldHintText: 'Hari/Bulan/Tahun',
        helpText: 'Pilih Tanggal Awal',
        cancelText: 'Batal',
        confirmText: 'Set',
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked2 != null && picked2 != tglAwal){
      setState(() {
        tglAkhir = picked2;
        dateDiff();
        _tglAkhirController.text = formatDate(tglAkhir, [d, '-', M, '-',yyyy]);
      });
    }
  }

  //baris 5 button Hitung

  int selisihTgl = 0;
  void dateDiff(){
    selisihTgl = tglAkhir.difference(tglAwal).inDays;
  }
  double half;
  String waktuParo() {
    double aktivitasVal = double.tryParse(_aktivitas.text) ?? 0;
    double jenisVal = double.tryParse(_selectedJenis.value.toString()) ?? 0;
    double selisih = double.tryParse(selisihTgl.toString()) ?? 0;
    double tParo = selisih/jenisVal;
    half = pow(0.5, tParo)*aktivitasVal;
    return half.toStringAsFixed(2);
  }
  String display ='0';

  final _formWaktuParo = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formWaktuParo,
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(15)),
              //Custom AppBar
              CustomAppBar(
                warnaBar: Colors.transparent,
                bayangan: Colors.blue,
                judul: 'Waktu Paro',
                logoBalik: Icons.keyboard_backspace,
                pencetBalik: (){
                  Get.back();
                },
                logoBar1: AssetImage('assets/images/pipe.png'),
                tapBar1: (){
                  Get.to(()=> DataPipa());
                },
                logoBar2: AssetImage('assets/images/clock.png'),
                tapBar2: (){
                  Get.to(()=> WaktuPaparan());
                },
                logoBar3: AssetImage('assets/images/hourglass.png'),
                tapBar3: (){
                  Get.to(()=> Pewaktu());
                },
              ),
              SizedBox(height: 15),
              //Baris 1(Jenis Sumber)
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(15)),
                  //Text Label
                  Text('Jenis Sumber', style: FormText),
                  Spacer(),
                  Container(
                    width: 190,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey.withOpacity(0.9),
                                width: 1)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<ListItem>(
                            value: _selectedJenis,
                            items: _jenisMenuItems,
                            onChanged: (value){
                              setState(() {
                                _selectedJenis = value;
                              });
                            },
                          ),
                        ),
                    ),
                  ),
                  SizedBox(width: 25,)
                ],
              ),
              SizedBox(height: 15),
              //Baris 2(Aktivitas Awal)
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(15)),
                  //Text Label
                  Text('Aktivitas Awal',
                      style: FormText),
                  Spacer(),
                  //TextInput
                  Container(
                    width: 190,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      maxLength: 4,
                      controller: _aktivitas,
                      onChanged: (value){
                        setState(() {
                          ketAktivitas = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Aktivitas Tidak Boleh Kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.9),width: 1)
                        ),
                        counterText: '',
                        hintText: 'Aktivitas',
                        suffixText: 'Ci',
                        contentPadding: EdgeInsets.all(8),
                      ), keyboardType: TextInputType.numberWithOptions(
                        decimal: true
                    ),
                      // Only numbers can be entered
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
              SizedBox(height: 15),
              //Baris 3 (Tanggal Awal)
              Row(
                children: <Widget>[
                  SizedBox(width: 28),
                  Text('Tanggal Awal',
                      style: FormText),
                  Spacer(),
                  Expanded(flex: 2,
                    child: TextFormField(
                      onTap: () {
                        Get.focusScope.requestFocus(FocusNode());
                        _tglAwal(context);
                      },
                      focusNode: focusTglAwal,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue),
                      controller: _tglAwalController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tanggal Tidak Boleh Kosong';
                        }
                        return null;
                      },
                      onChanged: (String val){
                        setState(() {
                          setTglAwal = val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Pilih Tanggal',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.9),width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6),
                          ),
                        ), // Added this
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                  SizedBox(width: 25)
                ],
              ),
              SizedBox(height: 15),
              //Baris 4(Tanggal Akhir)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(15)),
                  //Text Label
                  Text('Tanggal Akhir',
                      style: FormText),
                  Spacer(),
                  //DatePicker
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      onTap: () {
                        Get.focusScope.requestFocus(FocusNode());
                        _tglAkhir(context);
                      },
                      focusNode: focusTglAkhir,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue),
                      controller: _tglAkhirController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tanggal Tidak Boleh Kosong';
                        }
                        return null;
                      },
                      onChanged: (String val){
                        setState(() {
                          setTglAkhir = val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Pilih Tanggal',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.9),width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6),
                          ),
                        ), // Added this
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
              SizedBox(height: 40),
              //Baris 5(Button)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  hitung(
                    label: 'Hitung',
                    tekan: () {
                      if (_formWaktuParo.currentState.validate()) {
                        Get.snackbar(
                            'Menghitung Waktu Paro',
                            'Kalkulator Radiografi',
                            backgroundColor: Colors.green
                        );
                        setState(() {
                          this.display = waktuParo();
                        });
                      }
                    },
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              //DisplayBox
              DiplayCi(
                  label: display,
                warna: Colors.transparent,
                warnaBorder: Colors.blue,
                warnaLabel: Colors.red,
              )
            ],
          ),
        )
      ),
    );
  }
}

class ListItem {
  double value;
  String name;

  ListItem(this.value, this.name);
}

