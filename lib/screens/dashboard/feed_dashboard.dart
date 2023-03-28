import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:storily/cubit/load_main_data_cubit.dart';
import 'package:storily/cubit/load_recommended_events_cubit.dart';
import 'package:storily/global/methods/methods.dart';
import 'package:storily/screens/dashboard/widgets/home_screen.dart';
import 'package:storily/screens/dashboard/bootm_menu_screens/event.dart';
import 'package:storily/screens/kids_flow/bottomtab/home.dart';
//import 'data/video_model.dart';
import '../../cubit/load_upcoming_data_cubit.dart';
import 'feed_model/feed_view_model.dart';
import 'bootm_menu_screens/bookshelf.dart';

class FeedDashboard extends StatefulWidget {
  static String id = "/feedDashboard";
  const FeedDashboard({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedDashboard> {
  final feedViewModel = GetIt.instance<FeedViewModel>();

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    feedViewModel.initializer();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      HomeScreen();
      log("Home");
    }
    if (_selectedIndex == 1) {
      log("Explore");
      Home();
    }
    if (_selectedIndex == 2) {
      //goPage(context, MyBookshelfPage());
      log("Library");
      showToast("Library", context);
      // if (feedViewModel.videoSource!.listVideos[feedViewModel.index].controller!.value.isPlaying) {
      //   feedViewModel.videoSource!.listVideos[feedViewModel.index].controller!.pause();
      // }else{
      //   goPage(context, MyBookshelfPage());
      //   log("Library");
      // }
      // showToast("Library", context);
    }
    if (_selectedIndex == 3) {
      goPage(context, MyEventPage());
      context.read<LoadMainDataCubit>().getEventData();
      context.read<LoadUpcomingDataCubit>().getUpcomingEventData();
      context.read<LoadRecommendedEventsCubit>().getRecommendedEventData(readingLevel: 6);
     /* GestureDetector(
          onTap: (){
            goPage(context, MyEventPage());
            context.read<LoadMainDataCubit>().getEventData();
            context.read<LoadRecommendedEventsCubit>().getRecommendedEventData(readingLevel: 5);

          }
      ),*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0 ? HomeScreen() : Home(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber.shade800,
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.blueGrey,
            icon: Image.asset(
              "assets/icons/home.png",
              height: 25,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/explore.png",
              height: 25,
            ),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/library.png",
              height: 25,
            ),
            label: "Library",
          ),

          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/events.png", height: 25),
            label: "Event",
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    feedViewModel.controller?.dispose();
    super.dispose();
  }
}
