import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storily/controllers/main_content_controller.dart';
import 'package:storily/screens/splash/splash_screen.dart';
import 'routes/routes.dart';
import 'screens/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializations();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.put(MainContentController());
  runApp(
   MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify Clone',
      theme: ThemeData(
        fontFamily: 'Proxima Nova',
        //brightness: Brightness.dark,
        //primaryColor: Colors.lightBlue[800],
        // colorScheme: ColorScheme.fromSwatch()
        //     .copyWith(secondary: Colors.cyan[600], brightness: Brightness.dark),
      ),
       routes: routes,
      initialRoute: SplashScreen.id,
      home: SplashScreen(),
    );
  }
}