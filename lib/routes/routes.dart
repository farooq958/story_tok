import 'package:flutter/material.dart';

import '../screens/dashboard/feed_dashboard.dart';
import '../screens/splash/splash_screen.dart';


var routes = <String, WidgetBuilder>{
  //
  
  SplashScreen.id: (_) =>  SplashScreen(),
  FeedDashboard.id: (_) => const FeedDashboard(),
  

};
