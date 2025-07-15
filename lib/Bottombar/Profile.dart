import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:anihelp_trust/Bottombar/add_bank_details/bank_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class My_profile extends StatefulWidget {
  const My_profile({super.key});

  @override
  State<My_profile> createState() => _My_profileState();
}

class _My_profileState extends State<My_profile> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  String? loggedInEmail; // Store user email
  Map<String, dynamic>? userData; // Store user profile data
  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('loggedInEmail');


    if (email != null) {
      setState(() {
        loggedInEmail = email;
      });

      fetchUserProfile(email);
    }
  }

  Future<void> fetchUserProfile(String email) async {
    try {
      String api = "http://192.168.250.3:8000/trustregs/";
      final response = await http.get(Uri.parse(api));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data is List) {
          for (var user in data) {
            if (user['email'] == email) {
              setState(() {
                userData = user; // Store user profile data
                print(user);
                print(".................");
              });
              return;
            }
          }
        }
      }
    } catch (e) {
      print("Error fetching profile data: $e");
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      uploadProfileImage();
    }
  }

  Future<void> uploadProfileImage() async {
    if (_imageFile == null) return;

    try {
      String api = "http://192.168.2.6:8000/trustregs/${userData!['trust_id']}/";
      var request = http.MultipartRequest(
          'PATCH', Uri.parse(api) // Replace '2' with correct ID
      );
      request.files.add(await http.MultipartFile.fromPath(
        'profile_image',
        _imageFile!.path,
      ));
      var response = await request.send();

      var responseBody = await response.stream.bytesToString(); // Read response

      if (response.statusCode == 201 || response.statusCode == 200) {
        // ✅ Successfully uploaded
        fetchUserProfile(loggedInEmail!); // Refresh profile data
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile photo updated successfully!")),
        );
      } else {
        // ❌ Handle failure
        print("Failed to upload image. Status: ${response.statusCode}");
        // print("Response: $responseBody");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to upload image: $responseBody")),
        );
      }
    } catch (e) {
      print("Error uploading image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Stack(children: [
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  maxRadius: 70,
                  backgroundImage: userData?['profile_image'] != null
                      ? NetworkImage(
                          userData!['profile_image']) // Load from API
                      : NetworkImage(
                          "https://tse3.mm.bing.net/th?id=OIP.sDGudWbPLYyfB9reTqQ6kgHaHa&pid=Api&P=0&h=180"),
                  child: userData!['profile_image'] == null
                      ? Icon(Icons.person, size: 60, color: Colors.white)
                      : null,
                ),
                Positioned(
                    bottom: 1,
                    left: 100,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.edit, color: Colors.black, size: 18),
                      ),
                    ),),
              ]),
              SizedBox(
                height: 20,
              ),
              Text(
                userData?['trustname'] ?? "N/A",
                style: GoogleFonts.aclonica(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "+91 ${userData?['contact'] ?? "N/A"}",
                style: GoogleFonts.roboto(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    "TRUST REG. NO",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    userData?['trust_reg_no'] ?? "N/A",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Row(
                children: [
                  Text(
                    "TRUST NAME",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    userData?['trustname'] ?? "N/A",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Row(
                children: [
                  Text(
                    "EMAIL",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    userData?['email'] ?? "N/A",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Row(
                children: [
                  Text(
                    "ADDRESS",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      // height: 60,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          userData?['address'] ?? "N/A",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Row(
                children: [
                  Text(
                    "PINCODE NUMBER",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    userData?['pincode'] ?? "N/A",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Row(
                children: [
                  Text(
                    "ADD TRUST BANK DETAILS",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      fixedSize: Size(180, 10),
                      backgroundColor: Colors.blueAccent),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddBank(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Bank Details",
                        style: GoogleFonts.actor(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 20,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
