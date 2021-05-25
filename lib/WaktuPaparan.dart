import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ClassButton.dart';
import 'TextStyle.dart';
import 'CustomAppbar.dart';
import 'DataPipa.dart';
import 'HomePage.dart';
import 'Pewaktu.dart';
import 'WaktuParo.dart';

class WaktuPaparan extends StatefulWidget {
  @override
  _WaktuPaparanState createState() => _WaktuPaparanState();
}

class _WaktuPaparanState extends State<WaktuPaparan> {
  final _formExpose = GlobalKey<FormState>();
  //Baris 1 Thickness
  TextEditingController _thk = TextEditingController();
  String ketThk = '';
  @override
  void dispose(){
    _thk.dispose();
    _sfd.dispose();
    _currie.dispose();
    super.dispose();
  }
  //Baris 2 Teknik Radiografi
  List<bool>isSelected = [false, true];
  double _wall;
  FocusNode focusNodeButton1 = FocusNode();
  FocusNode focusNodeButton2 = FocusNode();
  List<FocusNode> focusToggle;
  @override
  void initState(){
    super.initState();
    focusToggle = [focusNodeButton1,focusNodeButton2];
    _filmMenuItems = buildDropDownMenuItems(_dropFilm);
    _selectedFilm = _filmMenuItems[0].value;
  }

  //Baris 3 SFD
  TextEditingController _sfd = TextEditingController();
  String ketSfd = '';

  //Baris 4 Aktivitas
  TextEditingController _currie = TextEditingController();
  String ketCurrie = '';

  //Baris 5 Film
  List<ListItem> _dropFilm = [
    ListItem (0.7, '   D8'),
    ListItem (1, '   D7'),
    ListItem (1.5, '   D5'),
    ListItem (3, '   D4'),
    ListItem (5, '   D3'),
  ];
  List<DropdownMenuItem<ListItem>> _filmMenuItems;
  ListItem _selectedFilm;
  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(DropdownMenuItem(
        child: Text(listItem.name,
          textAlign: TextAlign.justify,),
        value: listItem,)
      );
    }
    return items;
  }
  //Baris 6
  //Calculate Brain
  String displayMenit = '0';
  String displayDetik = '0';
  double expTime;
  String lnFlutter(){
    double thkVal = double.tryParse(_thk.text) ?? 0;
    double wallVal = double.tryParse(_wall.toString()) ?? 0;
    double currieVal = double.tryParse(_currie.text)?? 0;
    double filmVal = double.tryParse(_selectedFilm.value.toString()) ?? 0;
    double sfdVal = double.tryParse(_sfd.text) ?? 0;
    double natLog = thkVal/ 25.4 *wallVal;
    double logN = exp(natLog);
    expTime = logN*(6.5*sfdVal*sfdVal/currieVal/60*filmVal);
    return expTime.toStringAsFixed(4);
  }

  int meNit;
  String menitSexaGesimal(){
   double derajat = double.tryParse(lnFlutter());
   meNit = derajat.toInt();
   return meNit.toString();
  }
  int seCon;
  double minutFrac;
  String detikSexaGesimal(){
    minutFrac = 60 * (expTime-meNit);
    seCon = minutFrac.toInt();
    return seCon.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formExpose,
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(15)),
              //Custom AppBar
              CustomAppBar(
                bayangan: Colors.red,
                warnaBar: Colors.transparent,
                judul: 'Waktu Paparan',
                logoBalik: Icons.keyboard_backspace,
                pencetBalik: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                },
                logoBar1: AssetImage('assets/images/pipe.png'),
                tapBar1: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DataPipa(),
                      ));
                },
                logoBar2: AssetImage('assets/images/half_circle.png'),
                tapBar2: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WaktuParo(),
                      ));
                },
                logoBar3: AssetImage('assets/images/hourglass.png'),
                tapBar3: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pewaktu(),
                      ));
                },
              ),
              SizedBox(height: 10),
              //Thickness
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(15)),
                  Text('Tebal Dinding',
                      style: FormText),
                  Spacer(),
                  Expanded(flex:2,
                    child: TextFormField(
                      controller: _thk,
                      onChanged: (value){
                        setState(() {
                          ketThk = value;
                        });
                      },
                      validator: (value){
                        if (value ==null || value.isEmpty){
                          return 'Thickness Tidak Boleh Kosong';
                        }
                        return null;
                      },
                      maxLength: 6,
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(6),
                          ),
                        ),
                        labelText: 'Thickness',
                        suffixText: 'mm',                    // Added this
                        contentPadding: EdgeInsets.all(10),
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      // Only numbers can be entered
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
              SizedBox(height: 15),
              //Teknik Radiograf
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(15)),
                  Text('Teknik Radiografi',
                    style: FormText,
                  ),
                  Spacer(),
                  ToggleButtons(
                    children: <Widget>[
                      Text('Single Wall'),
                      Text('Double Wall'),
                    ],
                    constraints: BoxConstraints.expand(
                        width: MediaQuery.of(context).size.width/4.85,
                        height: MediaQuery.of(context).size.height/20
                    ),
                    focusNodes: focusToggle,
                    focusColor: Colors.red,
                    borderColor: Colors.grey,
                    borderRadius: BorderRadius.circular(6),
                    fillColor: Colors.red,
                    borderWidth: 1,
                    selectedColor: Colors.white,
                    isSelected: isSelected,
                    onPressed: (int index){
                      setState(() {
                        for (int indexBtn = 0;indexBtn < isSelected.length;indexBtn++) {
                          if (indexBtn == index) {
                            isSelected[indexBtn] = true;
                          } else {
                            isSelected[indexBtn] = false;
                          }
                        }
                        switch(index){
                          case 0 :
                            _wall = 1.2;
                            break;
                          case 1:
                            _wall = 2.2;
                            break;
                        }
                      });
                    },
                  ),
                  SizedBox(width: 25),
                ],
              ),
              SizedBox(height: 15),
              //SFD
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(15)),
                  Expanded(
                    child: Text('SFD',
                      style: FormText,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _sfd,
                      onChanged: (value){
                        setState(() {
                          ketSfd = value;
                        });
                      },
                      validator: (value){
                        if (value ==null || value.isEmpty){
                          return 'SFD Tidak Boleh Kosong';
                        }
                        return null;
                      },
                      maxLength: 5,
                      decoration:
                      InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(6),
                          ),
                        ),
                        labelText: 'Source to Film Distance',
                        suffixText: 'Inch',                    // Added this
                        contentPadding: EdgeInsets.all(10),
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      // Only numbers can be entered
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
              SizedBox(height: 15),
              //Aktivitas Sumber
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(15)),
                  Expanded(
                    child: Text('Aktivitas',
                        style: FormText
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _currie,
                      maxLength: 4,
                      onChanged: (value){
                        setState(() {
                          ketCurrie = value;
                        });
                      },
                      validator: (value){
                        if (value ==null || value.isEmpty){
                          return 'Currie Tidak Boleh Kosong';
                        }
                        return null;
                      },
                      decoration:
                      InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(6),
                          ),
                        ),
                        labelText: 'Aktivitas',
                        suffixText: 'Ci',                      // Added this
                        contentPadding: EdgeInsets.all(10),
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      // Only numbers can be entered
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
              SizedBox(height: 15),
              //Film
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(15)),
                  Text('Film',
                    style: FormText,
                  ),
                  Spacer(),
                  Container(
                    width: 190,
                    height: 47,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey.withOpacity(0.9),
                            width: 1),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<ListItem>(
                          elevation: 6,
                          value: _selectedFilm,
                          items: _filmMenuItems,
                          onChanged: (value){
                            setState(() {
                              _selectedFilm = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
              //Option Hitung
              // Container(
              //   margin: EdgeInsets.all(10),
              //   padding: EdgeInsets.all(15),
              //   height: MediaQuery.of(context).size.height*0.15,
              //   child: DecoratedBox(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(6),
              //       border: Border.all(
              //         color: Colors.grey.withOpacity(0.5),
              //         width: 1
              //       )
              //     ),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: <Widget>[
              //         Text('Option'),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: [
              //             //Film
              //             //XXS
              //             Column(
              //               children: <Widget>[
              //                 Text('XXS',
              //                   style: FormText,
              //                 ),
              //                 SizedBox(height: 5),
              //                 //Toggle
              //                 Container(
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(6.0),
              //                     border: Border.all(
              //                         color: Colors.grey, style: BorderStyle.solid, width: 0.80),
              //                   ),
              //                   child: ToggleSwitch(
              //                     minWidth: 55.0,
              //                     minHeight: 38,
              //                     cornerRadius: 6.0,
              //                     activeBgColor: Colors.green,
              //                     activeFgColor: Colors.white,
              //                     inactiveBgColor: Colors.transparent,
              //                     inactiveFgColor: Colors.transparent,
              //                     labels: ['NO', 'YES'],
              //                     onToggle: (index) {
              //                       print('switched to: $index');
              //                     },
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             //Chemical Developer
              //             Column(
              //               children: <Widget>[
              //                 Text('Developer',
              //                     style: FormText
              //                 ),
              //                 SizedBox(height: 5),
              //                 //DropDown
              //                 Container(
              //                   height: 40,
              //                   child: DecoratedBox(
              //                     decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(6),
              //                       border: Border.all(color: Colors.grey.withOpacity(0.5),
              //                       width: 1)
              //                     ),
              //                     child: DropdownButtonHideUnderline(
              //                       child: DropdownButton<String>(
              //                         isDense: false,
              //                         items: [
              //                           DropdownMenuItem<String>(
              //                             child: Text('<1000 Sheet'),
              //                             value: '1',
              //                           ),
              //                           DropdownMenuItem<String>(
              //                             child: Text('1200 Sheet'),
              //                             value: '1.2',
              //                           ),
              //                           DropdownMenuItem<String>(
              //                             child: Text('1300 Sheet'),
              //                             value: '1.3',
              //                           ),
              //                           DropdownMenuItem<String>(
              //                             child: Text('1500 Sheet'),
              //                             value: '1.5',
              //                           ),
              //                           DropdownMenuItem<String>(
              //                             child: Text('>2000 Sheet'),
              //                             value: '0',
              //                           ),
              //
              //                         ],
              //                         onChanged:(String value){
              //                           setState(() {
              //                             _devloper = value;
              //                             selecteddevloper = value;
              //                           });
              //                         },
              //                         hint: Text('  Chemical'),
              //                         value: _devloper,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: 40),
              //Tombol Hitung
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  hitung(
                      label: 'Hitung',
                      tekan: (){
                        if(_formExpose.currentState.validate()){
                          Get.snackbar(
                              'Menghitung Waktu Paparan',
                              'Kalkulator Radiografi',
                              backgroundColor: Colors.green
                          );
                          setState(() {
                            this.displayMenit = menitSexaGesimal();
                            this.displayDetik = detikSexaGesimal();
                          });
                        }
                      }),
                ],
              ),
              SizedBox(height: 30),
              TampilWaktuPaparan(
                menit: displayMenit ?? menitSexaGesimal(),
                detik: displayDetik ?? detikSexaGesimal(),
                warnaBorder: Colors.red,
                warnaLabel: Colors.red,
                warna: Colors.white,
              ),
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
