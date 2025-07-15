import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportResponse extends StatefulWidget {
  const ReportResponse({super.key});

  @override
  State<ReportResponse> createState() => _ReportResponseState();
}

class _ReportResponseState extends State<ReportResponse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
          color: Colors.grey.shade200,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.15,
                        // color: Colors.greenAccent,
                        child: Image.network(
                          "https://tse3.mm.bing.net/th?id=OIP.XEg5E3Pbumwi3f7_0qDqZAHaFj&pid=Api&P=0&h=180",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: SizedBox(
                          height: double.infinity,
                          child: Text(
                            "Jivdaya Charitable trust -ahmedabad",
                            style: GoogleFonts.aclonica(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  children: [
                    Text(
                      "Request Description",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text("This will ensure that the text moves to the next line when needed while keeping a proper layout. 🚀 Let me know if you need any more tweaks! 😊"),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            fixedSize: Size(MediaQuery.of(context).size.width*0.35, 10),
                            backgroundColor: Colors.green),
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => add_bank(),));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(FontAwesomeIcons.check,color:Colors.white,size: 15,),
                            Text(
                              "Accept",
                              style: GoogleFonts.actor(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),

                          ],
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            fixedSize: Size(MediaQuery.of(context).size.width*0.35, 10),
                            backgroundColor: Colors.redAccent),
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => add_bank(),));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(FontAwesomeIcons.cancel,color:Colors.white,size: 15,),
                            Text(
                              "Cancel",
                              style: GoogleFonts.actor(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),

                          ],
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
        itemCount: 5,
        padding: EdgeInsets.all(20),
      ),
    );
  }
}
