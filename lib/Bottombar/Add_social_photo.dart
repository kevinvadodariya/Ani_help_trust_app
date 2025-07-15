import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class add_social_photo extends StatefulWidget {
  const add_social_photo({super.key});

  @override
  State<add_social_photo> createState() => _add_social_photoState();
}

class _add_social_photoState extends State<add_social_photo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: NetworkImage("https://cdn.pixabay.com/photo/2019/12/27/08/36/coming-soon-person-4721934_960_720.png")),
            ],
          ),
        )
    );
  }
}
