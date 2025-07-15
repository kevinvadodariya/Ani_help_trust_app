import 'dart:convert';

import 'package:anihelp_trust/Bottombar/Dash_bord.dart';
import 'package:anihelp_trust/trust_signin_and_out/Sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Sign_in extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => signin();
}

class signin extends State<Sign_in> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  bool _pass1 = true;

  Future<void> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email.text = prefs.getString('loggedInEmail') ?? ""; // Load saved email
    });
    print("Retrieved Logged-in Email: ${_email.text}"); // Debugging
  }

  void fetchData() async {
    if (_email.text.isEmpty || _pass.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter both email and password."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      String api =
          "http://192.168.250.3:8000/trustregs/"; // Use the correct API endpoint
      final response = await http.get(Uri.parse(api));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data is List) {
          for (var user in data) {
            if (user['email'] == _email.text &&
                user['password'] == _pass.text) {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setString('loggedInEmail', user['email']);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Login successful!"),
                  backgroundColor: Colors.green,
                ),
              );

              // Navigate to the dashboard
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashBord(),
                  ));
              return; // Exit function after successful login
            }
          }
        }

        // If no user matches, show an error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Invalid email or password."),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to fetch user data."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("Failed to connect: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Connection failed. Please check your internet."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar:  AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),
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
              SizedBox(
                height: 15,
              ),
              Text("Trust Sign In",
                  style: GoogleFonts.aclonica(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 40)),
              SizedBox(
                height: 25,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: [
                      TextField(
                        style: TextStyle(height: 1),
                        controller: _email,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.email_outlined),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.blueAccent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black)),
                            label: Text(
                              "Email",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            hintText: "Enter Your Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextField(
                        obscureText: _pass1,
                        style: TextStyle(height: 1),
                        controller: _pass,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _pass1 = !_pass1;
                                  });
                                },
                                icon: _pass1
                                    ? Icon((Icons.visibility_off))
                                    : Icon(Icons.visibility)),
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
                            hintText: "Enter Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fixedSize: Size(400, 50),
                              backgroundColor: Colors.blueAccent),
                          onPressed: () {
                            fetchData();
                          },
                          child: Text(
                            "Continue",
                            style: GoogleFonts.actor(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                      ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      TextButton(
                        style: ButtonStyle(),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup_trust()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "If You Are New User Sign Up",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
