import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverprofilePage extends StatefulWidget {
  const DriverprofilePage({super.key});

  @override
  State<DriverprofilePage> createState() => _DriverprofilePageState();
}

class _DriverprofilePageState extends State<DriverprofilePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text("Driver's Profile",style: GoogleFonts.exo2(textStyle: TextStyle(fontWeight: FontWeight.bold)),),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Image.network(''),
            SizedBox(height: 30,),
            Text('Name: mal'),
            SizedBox(height: 10,),
            Text('Phone:  1244567'),
            SizedBox(height: 10,),
            Text('akmal@gmail.com')
          ],
        ),
      ),
    );
  }
}
