import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:storily/deprecated_tobedelete/old_home_Deprecated.dart';
//import 'package:storily/components/old_home_Deprecated.dart';
import 'package:storily/logic/auth_logic.dart';
import 'package:storily/screens/auth/auth.dart';
import 'package:storily/screens/auth/screens/childauthorselection_screen.dart';
import 'package:storily/screens/main_home_screen.dart';

class SplashScreen extends StatefulWidget {
  static String id = "/splashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future onloadDecider() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("No User");
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Material(
      //               child: ChangeNotifierProvider(
      //                 create: (_) => SessionManagement(),
      //                 child: FirebaseSession(),
      //               ),
      //             )));
      Get.offAll(() => FirebaseSession());
    } else {
      print("Current User : " + user.uid);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Material(
      //               child: MultiProvider(
      //                 providers: [
      //                   ChangeNotifierProvider(
      //                     create: (_) => SessionManagement(),
      //                   ),
      //                 ],
      //                 // child: SpotifyHome(),
      //               ),
      //             )));
      Get.offAll(() => MainHomeScreen());
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      onloadDecider();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset("assets/images/spotify_logo_title.png"),
      ),
    );
  }
}
