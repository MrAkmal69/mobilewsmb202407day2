import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var icController = TextEditingController();
  var passController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8ABDFC),
      appBar: AppBar(
        title: Text('Please Login', style: GoogleFonts.exo2(textStyle: TextStyle(fontWeight: FontWeight.bold)),),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80,),
            Image.network('https://cdni.iconscout.com/illustration/premium/thumb/login-page-2578971-2147152.png',height: 150,),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: icController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    labelText: 'Enter Your Ic Number',
                    hintText: 'Ic Number'
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)
                    ),
                    labelText: 'Enter Your Password',
                    hintText: 'Password'
                ),
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final Credential = await _auth.signInWithEmailAndPassword(
                        email: '${icController.text}@example.com',
                        password: passController.text
                    );

                    Navigator.pushReplacementNamed(context, '/welcome');
                  } catch(e){
                    print(e);

                    final snackBar = const SnackBar(
                      content: Text('Unsuccessfull'),
                      backgroundColor: Colors.red,
                      elevation: 1.5,
                      showCloseIcon: true,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text('Log In')
            ),
            SizedBox(height: 30,),
            TextButton(
                onPressed: (){Navigator.pushReplacementNamed(context,'/register');},
                child: Text("Doesn't Have Account Yet? Click Here To Register",style: GoogleFonts.exo2(textStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),)
            )
          ],
        ),
      ),
    );
  }
}
