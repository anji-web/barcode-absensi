import 'dart:convert';

import 'package:barcode_scan_absen/model/absen.dart';
import 'package:barcode_scan_absen/screen/home-page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AbsenList extends StatefulWidget {
  const AbsenList({Key? key}) : super(key: key);

  @override
  State<AbsenList> createState() => _AbsenListState();
}

class _AbsenListState extends State<AbsenList> {
  late List<Absen> data = [];
  String name = "";

  @override
  void initState(){
    super.initState();
    getData();
  }

  Future<List<Absen>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final nik = prefs.getString("nik");
    final fullname = prefs.getString("fullname");
    var response = await http.get(Uri.parse("http://192.168.100.29:9092/absensi/$nik/$fullname"));
    var res = jsonDecode(response.body)['data'].cast<Map<String, dynamic>>();
    setState(() {
      data = res.map<Absen>((json) => Absen.fromJson(json)).toList();
      name = fullname!;
    });
    return data;
  }

  List<DataColumn> _createDataColumen(){
    return [
      const DataColumn(label: Text("Nama", textAlign: TextAlign.center,style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)),
      const DataColumn(label: Text("Absen Masuk", textAlign: TextAlign.center,style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)),
      const DataColumn(label: Text("Absen Keluar", textAlign: TextAlign.center,style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)),
      const DataColumn(label: Text("Tanggal", textAlign: TextAlign.center,style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)),
    ];
  }

  List<DataRow> _createDataRow(){
    DateTime dateNow = DateTime.now();
    if (data.isNotEmpty) {
      return data.map((e) => DataRow(
          cells: <DataCell>[
            DataCell(Text(e.fullname)),
            DataCell(Text(e.dateIn.toString())),
            DataCell(Text(e.dateOut.toString())),
            DataCell(Text(dateNow.day.toString()+ '-' +dateNow.month.toString()+ '-' +dateNow.year.toString()))
          ]
        )
      ).toList();
    }else{
      return data.map((e) => const DataRow(
          cells: <DataCell>[
            DataCell(Text("")),
            DataCell(Text("")),
            DataCell(Text("")),
            DataCell(Text(""))
          ]
        )
      ).toList();

    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 124.5),
                color: Colors.amberAccent,
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: size.height * 0.02,),
                        Text("Selamat Datang", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        SizedBox(height: size.height * 0.01,),
                        Text(name, style : TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: size.height * 0.01),
                        Text("02 Agustus 2022", style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02,),
              Padding(padding: EdgeInsets.all(6.0),child:Text("Riwayat Absen ($name)", ),),
              SizedBox(height: size.height * 0.01,),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: <Widget>[
                    DataTable(
                            showBottomBorder: true,
                            dividerThickness: 5,
                            headingTextStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                            headingRowColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.black
                            ),
                            dataRowHeight: 40,
                            headingRowHeight: 30,
                            horizontalMargin: 10,
                            columnSpacing: 50,
                            border: TableBorder.all(width: 1.0, color: Colors.blueGrey,style:BorderStyle.none  ),
                            columns: _createDataColumen(),
                            rows: _createDataRow(),
                        )
                    ]),
                ),
              SizedBox(height: size.height * 0.35,),
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrangeAccent,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) {
                            return const BodyFirstPage();
                          }
                        )
                      );
                    },
                    child: const Text(
                      "Kembali ke halaman utama",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      )
                  ),
                ),
              )
            ],
          ),
      )
    );
  }
}