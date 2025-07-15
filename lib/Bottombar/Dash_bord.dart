import 'package:anihelp_trust/Bottombar/Add_social_photo.dart';
import 'package:anihelp_trust/Bottombar/Profile.dart';
import 'package:anihelp_trust/Bottombar/report_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DashBord extends StatefulWidget {
  final int initialIndex;
  const DashBord({super.key, this.initialIndex = 0});

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  int _currentIndex = 0;

  final List<Widget> _pages = [

    ReportResponse(),
    add_social_photo(),
    My_profile(),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding:EdgeInsets.only(left: 8),
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
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.blueAccent),
        height: MediaQuery.of(context).size.height * 0.085,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: GNav(
            gap: 8,
            activeColor: Colors.white,
            color: Colors.black,
            tabBackgroundColor: Colors.black26,
            backgroundColor: Colors.blueAccent,
            // iconSize: MediaQuery.of(context).size.width * 0.05,
            padding: const EdgeInsets.all(9),
            tabs: [
              GButton(
                icon: FontAwesomeIcons.paw,
                text: "Report Response",
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              GButton(
                icon: Icons.add_a_photo,
                text: "Social Photo",
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              GButton(
                icon: Icons.person,
                text: "Profile",
                onPressed: (){
                  setState(() {
                    _currentIndex=2;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
