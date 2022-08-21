import 'package:barcode_scan_absen/screen/login-page.dart';
import 'package:barcode_scan_absen/screen/register-page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.amberAccent,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.amberAccent,
            width: size.width * 1.0,
            child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  <Widget>
              [
                SizedBox(
                  height: size.height * 0.22 ,
                ),
                const Text(
                  "Selamat Datang di ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 SizedBox(
                  height: size.height * 0.01 ,
                ),
                const Text(
                  "Aplikasi Absensi QR Code PPSU",
                   style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                 SizedBox(
                  height: size.height * 0.01 ,
                ),
                 const Text(
                  "Sukabumi Utara ",
                   style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: size.height * 0.07 ,
                ),
                Image.asset(
                  "assets/logo.png",
                  width: size.width * 0.3,
                  alignment: Alignment.center,
                  ),
                SizedBox(
                  height: size.height * 0.07 ,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrangeAccent,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 90),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) {
                            return const LoginPage();
                          }
                        )
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      )
                  ),
                ),
                 SizedBox(
                  height: size.height * 0.02 ,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) {
                            return const BodyRegister();
                          }
                        )
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      )
                  ),
                )
              ]
            ),
          ) 
        )
    );
  }
}