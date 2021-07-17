import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiografi_kalkulator/CalculateBrain.dart';
import 'package:radiografi_kalkulator/Pages/Pewaktu.dart';
import 'package:radiografi_kalkulator/Widgets/MyButton.dart';
import 'package:radiografi_kalkulator/Widgets/MyDisplay.dart';
import 'package:radiografi_kalkulator/MyImages.dart';
import 'package:radiografi_kalkulator/TextStyle.dart';
import 'package:radiografi_kalkulator/Widgets/CustomAppbar.dart';
import 'package:radiografi_kalkulator/Pages/DataPipa.dart';
import 'package:radiografi_kalkulator/Pages/WaktuParo.dart';

class WaktuPenyinaran extends StatefulWidget {
  @override
  _WaktuPenyinaranState createState() => _WaktuPenyinaranState();
}

class _WaktuPenyinaranState extends State<WaktuPenyinaran> {
  //Key
  final _formExpose = GlobalKey<FormState>();
  //Type Double
  double _wall;
  //Type String
  String detSfd, detThk, detCurrie= '';
  String displayMin = '0';  String displaySec = '0';
  //Controller
  TextEditingController _sfd = TextEditingController();
  TextEditingController _currie = TextEditingController();
  TextEditingController _thk = TextEditingController();
  //Dispose
  @override
  void dispose(){
    _thk.dispose();
    _sfd.dispose();
    _currie.dispose();
    super.dispose();
  }
  //Baris 2 Teknik Radiografi
  List<bool>isSelected = [false, false];
  FocusNode focusNodeButton1 = FocusNode();
  FocusNode focusNodeButton2 = FocusNode();
  List<FocusNode> focusToggle;
  //InitState
  @override
  void initState(){
    super.initState();
    focusToggle = [focusNodeButton1, focusNodeButton2];
    _filmMenuItems = buildDropDownMenuItems(_dropFilm);
    _selectedFilm = _filmMenuItems[0].value;
  }
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
    for (ListItem listItem in listItems) {items.add(DropdownMenuItem(
        child: Text(listItem.name, textAlign: TextAlign.justify), value: listItem)
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(key: _formExpose,
          child: Column(
            children: <Widget>[Padding(padding: EdgeInsets.all(10)),
              //Custom AppBar
              CustomAppBar(shadow: Colors.red, barColor: Colors.transparent,
                titleBar: 'Waktu Paparan', backLogo: Icons.keyboard_backspace,
                tapBack: ()=> Get.back(),
                logoBar1: AssetImage(MyImages.pipeData),
                tapBar1: ()=> Get.to(()=>DataPipa()),
                logoBar2: AssetImage(MyImages.halfTime),
                tapBar2: ()=> Get.to(()=>WaktuParo()),
                logoBar3: AssetImage(MyImages.timerCount),
                tapBar3: ()=> Get.to(()=>Pewaktu()),
              ),
              SizedBox(height: 10),
              //Thickness
              Row(
                children: <Widget>[Padding(padding: EdgeInsets.all(15)),
                  Text('Tebal Dinding', style: SplashXForm),
                  Spacer(),
                  Container(width: MediaQuery.of(context).size.width/2.4,
                    child: TextFormField(controller: _thk, maxLength: 6,
                        decoration: InputDecoration(labelText: 'Thickness',
                            counterText: '', suffixText: 'mm',
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(borderSide: BorderSide(
                                color: Colors.grey.withOpacity(1),width: 1),
                            )
                        ),
                        onChanged: (value){
                          setState(()=>detThk = value);
                        },
                        validator: (value){
                          if (value ==null || value.isEmpty){
                            return 'Thickness Tidak Boleh Kosong';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true)
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
              SizedBox(height: 15),
              //Teknik Radiograf
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Padding(padding: EdgeInsets.all(15)),
                  Text('Teknik Radiografi', style: SplashXForm),
                  Spacer(),
                  ToggleButtons(
                    children: <Widget>[Text('Single Wall'), Text('Double Wall')],
                    constraints: BoxConstraints.expand(
                        width: MediaQuery.of(context).size.width/4.85,
                        height: MediaQuery.of(context).size.height/19.4),
                    focusNodes: focusToggle, focusColor: Colors.red,
                    borderColor: Colors.grey.withOpacity(1), borderWidth: 1,
                    borderRadius: BorderRadius.circular(6),
                    fillColor: Colors.red, selectedColor: Colors.white,
                    isSelected: isSelected,
                    onPressed: (int index){
                      setState(() {
                        for(int indexBtn=0;indexBtn<isSelected.length;indexBtn++) {
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
                children: <Widget>[Padding(padding: EdgeInsets.all(15)),
                  Text('SFD', style: SplashXForm),
                  Spacer(),
                  Container(width: MediaQuery.of(context).size.width/2.4,
                    child: TextFormField(controller: _sfd, maxLength: 5,
                        decoration: InputDecoration(counterText: '',
                          border: OutlineInputBorder(borderSide: BorderSide(
                              color: Colors.grey.withOpacity(1),width: 1)
                        ),
                          labelText: 'Source to Film Distance', suffixText: 'Inch',
                          contentPadding: EdgeInsets.all(8),
                        ),
                        onChanged: (value){
                          setState(()=>detSfd = value);
                        },
                        validator: (value){
                          if (value ==null || value.isEmpty){
                            return 'SFD Tidak Boleh Kosong';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true)
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
              SizedBox(height: 15),
              //Aktivitas Sumber
              Row(
                children: <Widget>[Padding(padding: EdgeInsets.all(15)),
                  Text('Aktivitas', style: SplashXForm),
                  Spacer(),
                  Container(width: MediaQuery.of(context).size.width/2.4,
                    child: TextFormField(controller: _currie, maxLength: 4,
                        decoration: InputDecoration(counterText: '',
                          border: OutlineInputBorder(borderSide: BorderSide(
                              color: Colors.grey.withOpacity(1),width: 1)
                          ),
                          labelText: 'Aktivitas', suffixText: 'Ci',
                          contentPadding: EdgeInsets.all(8),
                        ),
                      onChanged: (value){
                        setState(()=>detCurrie = value);
                      },
                      validator: (value){
                        if (value ==null || value.isEmpty){
                          return 'Currie Tidak Boleh Kosong';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true),
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
              SizedBox(height: 15),
              //Film
              Row(
                children: <Widget>[Padding(padding: EdgeInsets.all(15)),
                  Text('Film', style: SplashXForm),
                  Spacer(),
                  FrameDropdown(childDrop: DropdownButton<ListItem>(
                    elevation: 6, value: _selectedFilm, items: _filmMenuItems,
                    onChanged: (value){
                      setState(()=>_selectedFilm = value);},
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
              SizedBox(height: 40),
              //Tombol Hitung
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonCalculate(label: 'Hitung',primaryColor: Colors.red,
                      onTap: (){
                        if(_formExpose.currentState.validate()){
                          Get.snackbar('Menghitung Waktu Paparan',
                              'Kalkulator Radiografi',
                              backgroundColor: Colors.green);
                          ExposeTime exposeT = ExposeTime(
                            thickness: double.parse(_thk.text),
                            wall: _wall, sfd: double.parse(_sfd.text),
                            currie: double.parse(_currie.text),
                            film: _selectedFilm.value);
                          setState(() {
                            this.displayMin = exposeT.showMinSexagesimal();
                            this.displaySec = exposeT.showSecSexagesimal();
                          });
                        }
                      }),
                ],
              ),
              SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DisplayExposeTime(mainColor: Colors.red, label: 'Menit',
                    value: displayMin.padLeft(2,'0')),
                  SizedBox(width: 10),
                  DisplayExposeTime(mainColor: Colors.red, label: 'Detik',
                    value: displaySec.padLeft(2,'0'))
                ],
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
