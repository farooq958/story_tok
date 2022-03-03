import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:storily/components/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify Clone',
      theme: ThemeData(
        fontFamily: 'Proxima Nova',
        //brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.cyan[600], brightness: Brightness.dark),
      ),
      home: SplashScreen(),
    );
  }
}
