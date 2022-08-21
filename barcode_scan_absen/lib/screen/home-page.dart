import 'package:barcode_scan_absen/component/background.dart';
import 'package:barcode_scan_absen/screen/absen_in.dart';
import 'package:barcode_scan_absen/screen/absen_out.dart';
import 'package:barcode_scan_absen/screen/izin.dart';
import 'package:barcode_scan_absen/screen/list_absen.dart';
import 'package:barcode_scan_absen/screen/login-page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BodyFirstPage extends StatefulWidget {
  const BodyFirstPage({Key? key}) : super(key: key);

  @override
  State<BodyFirstPage> createState() => _BodyFirstPageState();
}

class _BodyFirstPageState extends State<BodyFirstPage> {
    String fullname = "";
    

    @override
    void initState(){
      super.initState();

      getFullname();

    }

    void getFullname() async{
      final prefs = await SharedPreferences.getInstance();
      setState(() {
          fullname  = prefs.getString("fullname")!;
          print('fullname is : $fullname');
      });
    }
  

    @override
    Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
      
      return Scaffold(
          body:  Background(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("SELAMAT DATANG",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(fullname,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return const AbsenIn();
                                  }
                              )
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Ink.image(
                              image :const AssetImage("assets/images/qr-log.png"),
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                          const Text("Absen Masuk", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),)
                          ],
                        )
                    ),
                    InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return const AbsenOUT();
                                  }
                              )
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Ink.image(
                              image: const AssetImage("assets/images/qr-log.png"),
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            const Text("Absen Keluar", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),)
                          ],
                        )
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return const AbsenList();
                                  }
                              )
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Ink.image(
                              image :const AssetImage("assets/images/history.png"),
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                          const Text("Riwayat Absensi", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),)
                          ],
                        )
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                // row 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                        splashColor: Colors.black,
                        onTap: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context){
                              return const SickForm();
                            })
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Ink.image(
                              image: const AssetImage("assets/images/sick-leave.jpg"),
                              height: 90,
                              width: 90,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            const Text("Sakit/Izin", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),)
                          ],
                        )
                    ),
                    InkWell(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context){
                              return const LoginPage();
                            })
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Ink.image(
                              image:const AssetImage("assets/images/logout.png"),
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            const Text("Logout", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24
                            ),)
                          ],
                        )
                    ),
                  ],
                ),
              ],
            )
          )
        ),
      );
    }
  }

