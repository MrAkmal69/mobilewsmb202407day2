import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Image.network('https://visioncar.com.my/wp-content/uploads/2023/08/c5-01.png',height: 300,),
            SizedBox(height: 20,),
            Text(textAlign: TextAlign.center,'Welcome to Kongsi Ride',style: GoogleFonts.exo2(textStyle: TextStyle(fontSize: 60,fontWeight: FontWeight.bold,)),),
            SizedBox(height: 90,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){Navigator.pushReplacementNamed(context, '/register');},
                    child: const Text('Register')
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                    onPressed: (){Navigator.pushReplacementNamed(context, '/login');},
                    child: Text('Log In')
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
