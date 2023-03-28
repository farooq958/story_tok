import 'package:flutter/material.dart';
import 'package:storily/screens/kids_flow/bottomtab/events.dart';
import 'package:storily/screens/kids_flow/bottomtab/explore.dart';
import 'package:storily/screens/kids_flow/bottomtab/home.dart';
import 'package:storily/screens/kids_flow/bottomtab/library.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({Key? key}) : super(key: key);

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int pageIndex = 0;

  final pages = [
    const Home(),
    const Explore(),
    const Events(),
    const Library(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Color.fromRGBO(240, 243, 247, 1.0),
          // borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(20),
          //   topRight: Radius.circular(20),
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:5.0),
                    child: Container(
                        height: 35,
                        child: Image.asset('assets/images/bottomtab/home.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      height: 20,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: pageIndex == 0
                              ? BorderRadius.circular(10.0)
                              : BorderRadius.circular(0.0),
                          color: pageIndex == 0
                              ? Color.fromRGBO(255, 184, 173, 1.0)
                              : Colors.transparent),
                      child: Center(
                        child: Text(
                          "HOME",
                          style: TextStyle(
                            color: pageIndex == 0
                                ? Colors.black
                                : Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:5.0),
                    child: Container(
                        height: 35,
                        child: Image.asset('assets/images/bottomtab/explore.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: pageIndex == 1
                              ? BorderRadius.circular(10.0)
                              : BorderRadius.circular(0.0),
                          color: pageIndex == 1
                              ? Color.fromRGBO(255, 184, 173, 1.0)
                              : Colors.transparent),
                      child: Center(
                        child: Text(
                          "EXPLORE",
                          style: TextStyle(
                            color: pageIndex == 1
                                ? Colors.black
                                : Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:5.0),
                    child: Container(
                        height: 35,
                        child: Image.asset('assets/images/bottomtab/events.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: pageIndex == 2
                              ? BorderRadius.circular(10.0)
                              : BorderRadius.circular(0.0),
                          color: pageIndex == 2
                              ? Color.fromRGBO(255, 184, 173, 1.0)
                              : Colors.transparent),
                      child: Center(
                        child: Text(
                          "EVENTS",
                          style: TextStyle(
                            color: pageIndex == 2
                                ? Colors.black
                                : Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:5.0),
                    child: Container(
                        height: 35,
                        child: Image.asset('assets/images/bottomtab/library.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: pageIndex == 3
                              ? BorderRadius.circular(10.0)
                              : BorderRadius.circular(0.0),
                          color: pageIndex == 3
                              ? Color.fromRGBO(255, 184, 173, 1.0)
                              : Colors.transparent),
                      child: Center(
                        child: Text(
                          "LIBRARY",
                          style: TextStyle(
                            color: pageIndex == 3
                                ? Colors.black
                                : Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
