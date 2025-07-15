import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Dash_bord.dart';
import '../Profile.dart';

class AddBank extends StatefulWidget {
  const AddBank({super.key});

  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNoController = TextEditingController();
  final TextEditingController _upiIdController = TextEditingController();
  File? _qrImage;
  String? loggedInEmail;
  int? trust_id;
  bool isLoading = false;
  bool isProfileLoading = false;  // New flag to handle profile loading

  // Retrieve trust_id from SharedPreferences
  Future<void> loadEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('loggedInEmail');

    if (savedEmail != null && savedEmail.isNotEmpty) {
      setState(() {
        loggedInEmail = savedEmail;
      });
      print("Saved email loaded: $loggedInEmail");
      await fetchUserProfile(savedEmail);
    } else {
      print("No saved email found.");
    }
  }

  Future<void> _pickQRImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _qrImage = File(pickedFile.path);
      });
    }
  }

  Future<void> fetchUserProfile(String email) async {
    setState(() {
      isProfileLoading = true;  // Set loading flag to true
    });
    String api = 'http://192.168.250.3:8000/trustregs/';
    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data is List) {
        for (var user in data) {
          if (user['email'] == email) {
            setState(() {
              trust_id = user['trust_id'];
            });
            print("User Found. ID: $trust_id");
            break;
          }
        }
      }
    }
    setState(() {
      isProfileLoading = false;  // Set loading flag to false
    });
  }

  Future<void> _uploadBankDetails(BuildContext context) async {
    if (trust_id == null) {
      print("User ID is null. Cannot submit the data.");
      return;
    }

    print('Bank Name: ${_bankNameController.text}');
    print('Account No: ${_accountNoController.text}');
    print('UPI ID: ${_upiIdController.text}');
    print('Trust ID: $trust_id');
    if (_qrImage != null) {
      print('QR Code selected: ${_qrImage!.path}');
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.250.3:8000/Bankdetails/'),
    );

    // Ensure that the field names match exactly what the server expects
    request.fields['bank_name'] = _bankNameController.text;
    request.fields['account_number'] = _accountNoController.text;  // Ensure this matches Django model field
    request.fields['upi_id'] = _upiIdController.text;
    request.fields['trust_id'] = trust_id.toString();  // Pass the trust_id

    if (_qrImage != null) {
      // Ensure 'qr_code_image' matches the Django model field name
      request.files.add(await http.MultipartFile.fromPath(
        'qr_code_image',  // The name should match the Django field
        _qrImage!.path,
        filename: basename(_qrImage!.path),
      ));
    }

    var response = await request.send();

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bank details uploaded successfully!')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const DashBord(initialIndex: 2)),
            (route) => false,
      );
    } else {
      String responseBody = await response.stream.bytesToString();
      print('Upload failed: ${response.statusCode}, Response: $responseBody');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: ${response.statusCode}, $responseBody')),
      );
    }
  }


  @override
  void initState() {
    super.initState();
    loadEmail();  // Load email on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Image.asset(
                "Assets/Image/logo-removebg.png.png",
                width: MediaQuery.of(context).size.width * 0.13,
                height: MediaQuery.of(context).size.height * 0.13,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "ANI HELP",
              style: GoogleFonts.aclonica(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.06,
        backgroundColor: Colors.grey.shade200,
      ),
      body: isProfileLoading
          ? Center(child: CircularProgressIndicator())  // Loading indicator for profile fetching
          : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _bankNameController,
                decoration: InputDecoration(
                  suffixIcon: Icon(FontAwesomeIcons.landmark),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: "Bank Name",
                  hintText: "Enter Bank Name",
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _accountNoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.numbers),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: "Bank Account No",
                  hintText: "Enter Account Number",
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _upiIdController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.qr_code),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: "UPI ID",
                  hintText: "Enter your UPI ID",
                ),
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Text(
                    "UPLOAD QR CODE",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: _pickQRImage,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _qrImage != null
                      ? Image.file(_qrImage!, fit: BoxFit.cover)
                      : Icon(
                    FontAwesomeIcons.qrcode,
                    size: 75,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: trust_id == null || isLoading
                    ? null
                    : () => _uploadBankDetails(context),  // Disable upload if trust_id is null or loading
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                  "UPLOAD",
                  style: GoogleFonts.actor(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
