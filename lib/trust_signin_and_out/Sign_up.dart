import 'dart:convert';

import 'package:anihelp_trust/trust_signin_and_out/Sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;

class Signup_trust extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => signup_trust();
}

class signup_trust extends State<Signup_trust> {


  Future<void> sendData() async {
    try {
      String api = "http://192.168.250.3:8000/trustregs/";
      final response = await http.post(
        Uri.parse(api),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'trust_reg_no': _trustrno.text.trim(), // Changed to lowercase 'firstname'
          'trustname': _trustname.text.trim(),
          'contact': _con_num.text.trim(),
          'email': _email.text.trim(),
          'address': _address.text.trim(),
          'pincode': int.tryParse(_pincode.text) ?? 0,
          'password': _pass.text.trim(),
        }),
      );

      if (response.statusCode == 201) {
        print("Data sent successfully!");
        Navigator.push(context, MaterialPageRoute(builder: (context) => Sign_in()));
      } else {
        print("Error: ${response.statusCode}, ${response.body}");
      }
    } catch (e) {
      print("Failed to connect: $e");
    }
  }


  TextEditingController _trustrno = TextEditingController();
  TextEditingController _trustname = TextEditingController();
  TextEditingController _con_num = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _copass = TextEditingController();
  bool _obsecure=true;
  bool _obsecure1=true;

  int _gender = 0; // Variable to hold selected radio button value

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;

    double con_width = screen_width * 0.84;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                            "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/travel-app-ne119c/assets/o2ov6zjya8d9/logo.png",
                          ))),
                ),
              ),
              Text("Trust Sign Up",
                  style: GoogleFonts.aclonica(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 40)),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: con_width,
                  child: Column(
                    children: [
                      TextField(
                        controller: _trustrno,
                        style: TextStyle(height: 1,),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide(color: Colors.blueAccent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black)),
                            label: Text(
                              "Trust Registration No",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            hintText: "Enter Trust Registration No",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _trustname,
                        style: TextStyle(height: 1),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide(color: Colors.blueAccent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black)),
                            label: Text(
                              "Trust Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            hintText: "Enter Trust Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _con_num,
                        style: TextStyle(height: 1),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide(color: Colors.blueAccent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black)),
                            label: Text(
                              "Contact No",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            hintText: "Enter Your Contact No",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _email,
                        style: TextStyle(height: 1),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide(color: Colors.blueAccent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black)),
                            label: Text(
                              "E-mail",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            hintText: "Enter E-mail",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        maxLines: 4,
                        controller:_address,
                        style: TextStyle(height: 1),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide(color: Colors.blueAccent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black)),
                            label: Text(
                              "Address",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            hintText: "Enter Address",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _pincode,
                        style: TextStyle(height: 1),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide(color: Colors.blueAccent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black)),
                            label: Text(
                              "Pincode",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            hintText: "Enter Pincode",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _pass,
                        obscureText: _obsecure,
                        style: TextStyle(height: 1),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {

                                  setState(() {
                                    _obsecure=!_obsecure;
                                  });
                                },
                                icon: _obsecure?Icon(Icons.visibility_off):Icon(Icons.visibility)),

                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide(color: Colors.blueAccent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black)),
                            label: Text(
                              "Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            hintText: "**********",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(

                        controller: _copass,
                        obscureText: _obsecure1,
                        style: TextStyle(height: 1),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {

                                  setState(() {
                                    _obsecure1=!_obsecure1;
                                  });
                                },
                                icon: _obsecure1?Icon(Icons.visibility_off):Icon(Icons.visibility)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide(color: Colors.blueAccent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black)),
                            label: Text(
                              "Confirm Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            hintText: "**********",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              fixedSize: Size(400, 50),
                              backgroundColor: Colors.blueAccent),
                          onPressed: () {

                           sendData();
                          },
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.actor(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
