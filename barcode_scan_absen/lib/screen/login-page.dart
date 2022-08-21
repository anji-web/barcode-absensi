import 'dart:async';
import 'dart:convert';
import 'package:barcode_scan_absen/screen/home-page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool flagOpenPass = true;

  void timerOpenPass(){ 
    setState(() {
      flagOpenPass = false;
      Timer(const Duration(seconds: 1), (){
        setState(() {
          flagOpenPass = true;
        });
      });
    });
  }

  Future<User> loginProcess () async {

    var body = {
        "username" : username.text,
        "password" : password.text
    };

    var res = await http.post(
        Uri.parse("http://192.168.100.29:9092/barcode/login"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body)
    );

    var result = jsonDecode(res.body)['data'];
    User user =  User(statusCode: result['statusCode'],
        token: result['token'],
        id: result['id'],
        username: result['username'],
        fullname: result['fullname'],
        nik: result['nik'],
        roles: result['roles']);

    _saveTemp(result['id'], result['nik'], result['fullname']);
    return user;
  }

  _saveTemp(id, nik , fullname) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("id_user", id);
    prefs.setString("nik", nik);
    prefs.setString("fullname", fullname);
    
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.amberAccent,
          width: size.width * 1.0,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
          child: 
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                SizedBox(
                  height: size.height * 0.09,
                ),
                Image.asset(
                  "assets/logo.png",
                  width: size.width * 0.3,
                  alignment: Alignment.center,
                ),
                 SizedBox(
                  height: size.height * 0.09,
                ),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextFormField(
                  controller: username,
                  enableInteractiveSelection: true,
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: "username",
                    labelStyle:  TextStyle(color: Colors.black),
                    enabledBorder:   OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.black)
                    ),
                     focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1,color: Colors.black),
                    ),
                    ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextFormField(
                  controller: password,
                  enableInteractiveSelection: true,
                  autofocus: false,
                  obscureText: flagOpenPass,
                  decoration: InputDecoration(
                    labelText: "password",
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder:  const OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.black)
                    ),
                     focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1,color: Colors.black),
                    ),
                    suffixIcon:  IconButton(
                      onPressed: timerOpenPass,
                      icon: const Icon(Icons.remove_red_eye)),
                    ),
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrangeAccent,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 90),
                    ),
                    onPressed: () async {
                      User user = await loginProcess();
                      setState(() {

                        if (user.statusCode == 200) {
                            Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) {
                                return const BodyFirstPage();
                              }
                            )
                          );
                        }else {
                          Fluttertoast.showToast(
                                msg: "username atau password salah",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.white,
                                textColor: Colors.red,
                                fontSize: 18.0
                            );
                        }
                      });
                      
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      )
                  ),
                ),
            ],
          ),
        )
      ),
    );
    
  }
}