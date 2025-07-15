import 'package:anihelp_trust/trust_signin_and_out/Sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstSplase extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstSplaseState();
  }
}

class _FirstSplaseState extends State<FirstSplase> with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationcontroller;

  @override
  void initState() {
    super.initState();
    animationcontroller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),  // Reduced the animation duration for a faster transition
    );
    animation = Tween(begin: 0.0, end: 200.0).animate(animationcontroller);
    animationcontroller.addListener(() {
      setState(() {});
    });
    animationcontroller.forward(); // Start animation

    animationcontroller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
       Navigator.push(context, MaterialPageRoute(builder: (context) => Sign_in(),));

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/travel-app-ne119c/assets/svwv5ligd1qx/splase.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Opacity(
              opacity: animationcontroller.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/travel-app-ne119c/assets/o2ov6zjya8d9/logo.png",
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20),  // Added spacing between logo and text
                  Text(
                    'Ani Help',
                    style: GoogleFonts.aclonica(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text("Trust",style:GoogleFonts.ubuntu(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.grey.shade700),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
