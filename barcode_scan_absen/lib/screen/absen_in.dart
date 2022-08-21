import 'dart:convert';

import 'package:barcode_scan_absen/component/result-absen.dart';
import 'package:barcode_scan_absen/model/absen.dart';
import 'package:barcode_scan_absen/screen/home-page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class AbsenIn extends StatefulWidget {
  const AbsenIn({Key? key}) : super(key: key);

  @override
  State<AbsenIn> createState() => _AbsenInState();
}

class _AbsenInState extends State<AbsenIn> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? fullname = "";
  String? result = "";

  @override
  void initState(){
    super.initState();

    getFullname();
  }


    void getFullname() async{
      final prefs = await SharedPreferences.getInstance();
      setState(() {
          fullname  = prefs.getString("fullname")!;
      });
    }
  

  void absenMasuk() async {
    final prefs = await SharedPreferences.getInstance();

    DateTime dateTime = DateTime.now();
    var body = {
      "fullname" : prefs.getString("fullname"),
      "nik" : prefs.getString("nik"),
      "address" : null,
      "dateIn" : formatISOTime(dateTime),
      "dateOut" : null
    };

    var url = await http.post(Uri.parse('http://192.168.100.29:9092/absensi'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body));

    var result = jsonDecode(url.body);
    var absen = Absen.fromJson(result['data']);
    int statusCode = result['statusCode'];
    if (statusCode == 201) {
      _saveIdTemp(absen.idAbsensi);
      _showMyDialog("absen berhasil");
    }else{
       Fluttertoast.showToast(
            msg: "Absen keluar gagal",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.white,
            textColor: Colors.red,
            fontSize: 18.0
        );
    }
  }

  Future<void> _showMyDialog(String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(text),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {return const BodyFirstPage();})
                );
              },
            ),
          ],
        );
      },
    );
  }

  _saveIdTemp(id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("idAbsen", id);
    final valId = prefs.getInt("idAbsen") ?? 0;
    setState(() {
      fullname = prefs.getString("fullname")!;
    });
  }

  String formatISOTime(DateTime date) {
    //converts date into the following format:
    // or 2019-06-04T12:08:56.235-0700
    var duration = date.timeZoneOffset;
    if (duration.isNegative)
      return (DateFormat("yyyy-MM-ddTHH:mm:ss").format(date));
    else
      return (DateFormat("yyyy-MM-ddTHH:mm:ss").format(date));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.10,),
            const Text(
              "SILAHKAN SCAN QR YANG SUDAH TERSEDIA UNTUK MELAKUKAN ABSEN MASUK",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              ),
              SizedBox(height: size.height * 0.30,),
              ElevatedButton(
                onPressed: () async  {
                  PermissionStatus allowCameraStat = await Permission.camera.request();
                  if(allowCameraStat.isGranted){
                      result = await scanner.scan();
                      setState(() {
                        if (result == "Absen Masuk") {
                            absenMasuk();
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) {
                                  return  ResultAbsen(
                                      textTop: const Text("Absensi Berhasil"),
                                      textBottom: Text("$fullname telah melakukan absen masuk"),
                                    );
                                }
                              )
                            );
                        }else {
                          _showMyDialog("Barcode bukan untuk absen masuk");
                        }
                      });
                  }else {
                    print("camera access request denied");
                  }
                  // Navigator.push(
                  //   context, 
                  //   MaterialPageRoute(builder: (context) {
                  //     return const BodyFirstPage();
                  //   })
                  // );
                }, 
                child: const Text("Scan QR Code"))
          ],
        ),
        )
    );
    
    
  }
}