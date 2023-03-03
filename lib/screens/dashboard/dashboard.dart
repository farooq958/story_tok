import 'package:flutter/material.dart';

import '../../global/methods/methods.dart';
import '../drawer/drawer_screen.dart';
import 'pages/bookshelf.dart';
import 'pages/content.dart';
import 'pages/event.dart';
import 'widgets/flooting_menu.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  Color? color;
  bool _isSelected = false;
  String _title = "Dashboard";
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 0) {
        _title = "Feed";
        _isSelected = false;
      } else if (index == 1) {
        _title = "Add Content";
        _isSelected = true;
      } else if (index == 2) {
        _title = "My Event";
        _isSelected = true;
      } else {
        _title = "My Bookshelf";
        _isSelected = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPopExit(context, _key),
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        key: _key,
        // remove key if drawer needs to always open
        floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
          children: [
            likeFlootBtn,
            SizedBox(height: 5),
            commentFlootBtn,
            SizedBox(height: 5),
            buyFlootBtn,
          ],
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            title: Text(
              _title,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 15,
              ),
            ),
            backgroundColor: Colors.transparent,
            bottomOpacity: 0.0,
            elevation: 0.0,
          ),
        ),
        //
        drawer: SizedBox(
          width: 280,
          child: Drawer(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: 250,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    const DrawerScreen(),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (_selectedIndex == 0)
                const MyBookshelfPage()
              else if (_selectedIndex == 1)
                const AddContentPage()
              else if (_selectedIndex == 2)
                const MyEventPage()
              else
                const MyEventPage()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey.shade50,
          selectedItemColor: Colors.red.shade800,
          unselectedItemColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Feed',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: 'Add Content',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.groups_2_outlined),
              label: 'My Event',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              label: 'Bookshelf',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
