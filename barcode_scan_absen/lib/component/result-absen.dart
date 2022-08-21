import 'package:barcode_scan_absen/screen/home-page.dart';
import 'package:flutter/material.dart';

class ResultAbsen extends StatelessWidget {
  final Text textTop;
  final Text textBottom;
  const ResultAbsen({Key? key, required this.textTop, required this.textBottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/success-icon.png", width: size.width * 0.5,),
            SizedBox(
              height: size.height * 0.05,
            ),
            textTop,
            textBottom,
             SizedBox(
              height: size.height * 0.05,
            ),
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
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                      ),
                      )
                  ),
                ),
              )
        ],
      ),
    ),
    );
    
  }
}