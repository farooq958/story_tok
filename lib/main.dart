import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storily/provider/storage_provider.dart';
import 'package:storily/screens/splash/splash_screen.dart';

import 'AppProvider/app_main_provider.dart';
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
      child: DevicePreview(enabled: true, builder: (BuildContext context) {
        return MyApp();
      },),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: appProvider,
      child:  ScreenUtilInit(
        //scaleByHeight: true,
        designSize: const Size(320, 680),
        minTextAdapt: true,
        //  splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (BuildContext context, Widget? child) {

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
        },

      ),
    );
  }
}
