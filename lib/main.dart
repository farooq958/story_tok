import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storily/provider/storage_provider.dart';
import 'package:storily/screens/splash/splash_screen.dart';

import 'screens/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setup();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StorageProvider(prefs)),
      ],
      child: MyApp(),
    ),
  );
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
        //primaryColor: Colors.lightBlue[800],
        // colorScheme: ColorScheme.fromSwatch()
        //     .copyWith(secondary: Colors.cyan[600], brightness: Brightness.dark),
      ),
      home: SplashScreen(),
    );
  }
}
