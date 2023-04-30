import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:storily/cubit/LibraryCubits/library_books_cubit.dart';
import 'package:storily/cubit/load_main_data_cubit.dart';
import 'package:storily/cubit/load_recommended_events_cubit.dart';
import 'package:get/get.dart';
import 'package:storily/global/methods/methods.dart';
import 'package:storily/screens/dashboard/bootm_menu_screens/library_screens/libraryPageView.dart';
import 'package:storily/screens/dashboard/widgets/home_screen.dart';
import 'package:storily/screens/dashboard/bootm_menu_screens/event.dart';
import 'package:storily/screens/dashboard/bootm_menu_screens/home.dart';
//import 'data/video_model.dart';
import '../../cubit/load_upcoming_data_cubit.dart';
//import 'feed_model/feed_view_model.dart';
import '../../controllers/main_content_controller.dart';
import '../../controllers/repositories/videos_repository.dart';
import 'bootm_menu_screens/bookshelf.dart';
import 'data/model/video_model.dart';
import 'package:storily/cubit/LibraryCubits/library_books_this_month_cubit.dart';
import 'package:storily/cubit/LibraryCubits/library_featured_authors_cubit.dart';
import 'package:storily/cubit/LibraryCubits/library_not_owned_books_cubit.dart';
import '../../repo/repo.dart';
import 'package:storily/Utils/process_indicator.dart';

class FeedDashboard extends StatefulWidget {
  static String id = "/feedDashboard";
  String? uid = '';
   FeedDashboard({Key? key,this.uid}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedDashboard> {
  // final feedViewModel = GetIt.instance<FeedViewModel>();
  //
  // final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  late VideosAPI videoSource;
  List<CommonDataModel> currentItems = [];

  @override
  void initState() {
    super.initState();
    Get.find<MainContentController>().initializer();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Home(uid: widget.uid!);
      log("Home");
    }
    if (_selectedIndex == 1) {
      log("Explore");
      HomeScreen();
    }
    if (_selectedIndex == 2) {
     // var contentController = Get.find<MainContentController>().initializer();
      //
      // if (contentController!.videoSource.listVideos[contentController!.index].controller!.value.isPlaying) {
      //   contentController!.videoSource.listVideos[contentController!.index].controller!.pause();

      //goPage(context, MyBookshelfPage());
      log("Library");
      showToast("Library", context);
      LibraryPageView();


      //Get.to(()=>MyBookshelfPage());
    }
    if (_selectedIndex == 3) {
      // goPage(context, MyEventPage());
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

  Future gotoLib() async {
    Circle().show(context);
    await context.read<LibraryBooksCubit>().getLibraryBooksData();
    await context.read<LibraryBooksThisMonthCubit>().getLibraryThisMonthBooksData();
    await context.read<LibraryFeaturedAuthorsCubit>().getLibraryFeaturedAuthors();
    await context.read<LibraryNotOwnedBooksCubit>().getLibraryNotOwnedBooks();
    await Repository().getCategories();
    Circle().hide(context);
    //goPage(context, LibraryPageView());
    LibraryPageView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _selectedIndex == 0 ? Home(uid: widget.uid) : _selectedIndex == 1 ?HomeScreen() :  _selectedIndex == 2 ?LibraryPageView():_selectedIndex==3?MyEventPage():SizedBox(),
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

  // @override
  // void dispose() {
  //   feedViewModel.controller?.dispose();
  //   super.dispose();
  // }
}
