import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobilewsmb202407day2/driverprofile.dart';
import 'package:mobilewsmb202407day2/first.dart';
import 'package:mobilewsmb202407day2/login.dart';
import 'package:mobilewsmb202407day2/register.dart';
import 'package:mobilewsmb202407day2/welcome.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    initialRoute: '/',
    routes: {
      '/': (context) => FirstPage(),
      '/register': (context) => RegisterPage(),
      '/login': (context) => LoginPage(),
      '/welcome': (context) => WelcomePage(),
      '/driver': (context) => DriverprofilePage()
      }
    );
  }
}
