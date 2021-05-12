import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ClassButton.dart';
import 'Cons.dart';
import 'CustomAppbar.dart';
import 'DataPipa.dart';
import 'HomePage.dart';
import 'Pewaktu.dart';
import 'WaktuPaparan.dart';


class WaktuParo extends StatefulWidget {
  @override
  _WaktuParoState createState() => _WaktuParoState();
}

class _WaktuParoState extends State<WaktuParo> {
  //Baris 1
  //DropDown Jenis Sumber
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
    super.initState();
    _jenisMenuItems = buildDropDownMenuItems(_dropJenis);
    _selectedJenis = _jenisMenuItems[0].value;
  }
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
  //Baris 2
  //Controler Aktifitas
  TextEditingController _aktivitas =  TextEditingController();
  String ketAktivitas = '';
  @override
  void dispose(){
    _aktivitas.dispose();
    super.dispose();
  }
  //Baris 3
  //DatePicker 1
  int selisihTgl = 0;
  DateTime selectedDate1 = DateTime.now();
  //Select Date Awal
  Future<Null> _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate1,
        errorInvalidText: 'Tanggal di Luar Jangkauan',
        errorFormatText: 'Tanggal Salah',
        fieldLabelText: 'Plih Tanggal Awal',
        fieldHintText: 'Bulan/Hari/Tahun',
        helpText: 'Pilih Tanggal Awal',
        cancelText: 'Batal',
        confirmText: 'Set',
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate1)
      setState(() {
        selectedDate1 = picked;
        dateDiff();
      });
  }
  //Baris 4
  //DatePicker2
  DateTime selectedDate2 = DateTime.now();
  //Select Date Akhir
  Future<Null> _selectDate2(BuildContext context) async {
    final DateTime picked2 = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        errorInvalidText: 'Tanggal di Luar Jangkauan',
        errorFormatText: 'Tanggal Salah',
        fieldLabelText: 'Plih Tanggal Akhir',
        fieldHintText: 'Bulan/Hari/Tahun',
        helpText: 'Pilih Tanggal Akhir',
        cancelText: 'Batal',
        confirmText: 'Set',
        lastDate: DateTime(2101),
        firstDate: DateTime(2015, 8));
    if (picked2 != null && picked2 != selectedDate2)
      setState(() {
        selectedDate2 = picked2;
        dateDiff();
      });
  }
  //baris 5 button Hitung
  void dateDiff(){
    selisihTgl = selectedDate2.difference(selectedDate1).inDays;
  }
  String calculateDecay() {
    double aktivitasVal = double.tryParse(_aktivitas.text) ?? 0;
    double jenisVal = double.tryParse(_selectedJenis.value.toString()) ?? 0;
    double selisih = double.tryParse(selisihTgl.toString()) ?? 0;
    double _decay = aktivitasVal * (jenisVal / selisih) * 0.5;
    String result = '$_decay '+' Ci';
    return result.substring(0,5);
  }
  String display ='0';

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(15)),
            //Custom AppBar
            CustomAppBar(
              WarnaBar: Colors.blue,
              Title: 'Waktu Paro',
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
              LogoBar3: AssetImage('assets/images/hourglass.png'),
              TapBar3: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pewaktu(),
                    ));
              },
            ),
            SizedBox(height: 15),
            //Baris 1(Jenis Sumber)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(15)),
                //Text Label
                Text('Jenis Sumber',
                    style: FormText),
                Spacer(),
                Container(
                  width: 185,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.withOpacity(0.9),
                              width: 1)
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<ListItem>(
                        elevation: 6,
                        value: _selectedJenis,
                        items: _jenisMenuItems,
                        onChanged: (value){
                          setState(() {
                            _selectedJenis = value;
                          });
                        },
                      ),
                      )
                  ),
                ),
                SizedBox(width: 25),
              ],
            ),
            SizedBox(height: 10),
            //Baris 2(Aktivitas Awal)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(15)),
                //Text Label
                Text('Aktivitas Awal',
                    style: FormText),
                Spacer(),
                //TextInput
                Expanded(flex: 2,
                    child: TextFormField(
                      maxLength: 4,
                      controller: _aktivitas,
                      onChanged: (value){
                        setState(() {
                          ketAktivitas = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harus di Isi Angka Yang Valid';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(6),
                          ),
                        ),
                        labelText: 'Aktivitas',
                        suffixText: 'Ci', // Added this
                        contentPadding: EdgeInsets.all(10),
                      ), keyboardType: TextInputType.numberWithOptions(
                        decimal: true
                    ),
                      textInputAction: TextInputAction.done,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                      // Only numbers can be entered
                    ),
                ),
                SizedBox(width: 25),
              ],
            ),
            SizedBox(height: 15),
            //Baris 3(Tanggal Awal)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(15)),
                //Text Label
                Text('Tanggal Awal',
                  style: FormText),
                Spacer(),
                //DatePicker
                Column(
                  children: <Widget>[
                    Container(
                      height: 45,
                      width: 185,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.grey),
                        ),
                        onPressed: () => _selectDate1(context),
                        child: Text('  Pilih Tanggal Awal  ',
                            style: ShadowText
                        ),
                        color: Colors.white,
                      ),
                    ),
                    Text("${selectedDate1.toLocal()}".split(' ')[0],
                      style: TextStyle(
                        color: Colors.blue
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 25),
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
                  style: FormText,),
                Spacer(),
                //DatePicker
                Column(
                  children: <Widget>[
                    Container(
                      height: 45,
                      width: 185,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.grey),
                        ),
                        onPressed: () => _selectDate2(context),
                        child: Text('  Pilih Tanggal Awal  ',
                            style: ShadowText
                        ),
                        color: Colors.white,
                      ),
                    ),
                    Text("${selectedDate2.toLocal()}".split(' ')[0],
                      style: TextStyle(
                          color: Colors.blue
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 25),
              ],
            ),
            SizedBox(height: 20),

            SizedBox(height: 20),
            //Baris 5(Button)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hitung(
                  Label: 'Hitung',
                  Tekan: () {
                    setState(() {
                      this.display = calculateDecay();
                    });
                  },
                  Warna: Colors.redAccent,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            //DisplayBox
            DisplayBox(
              Label: display,
              Warna: Colors.white,
                WarnaBorder: Colors.blue,
                WarnaLabel: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}

class ListItem {
  double value;
  String name;

  ListItem(this.value, this.name);
}

