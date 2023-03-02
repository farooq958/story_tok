import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../feed_model/feed_view_model.dart';
import '../icons/feed_icon_data.dart';

class BottomBar extends StatelessWidget {
  static const double NavigationIconSize = 20.0;
  static const double CreateButtonWidth = 38.0;

  const BottomBar({Key? key}) : super(key: key);

  Widget get customCreateIcon => Container(
        width: 45.0,
        height: 27.0,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.0),
              width: CreateButtonWidth,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 250, 45, 108),
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.0),
              width: CreateButtonWidth,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 32, 211, 234),
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
            Center(
              child: Container(
                height: double.infinity,
                width: CreateButtonWidth,
                decoration: BoxDecoration(
                    color: GetIt.instance<FeedViewModel>().actualScreen == 0
                        ? Colors.greenAccent
                        : Colors.black,
                    borderRadius: BorderRadius.circular(7.0)),
                child: Icon(
                  Icons.add,
                  color: GetIt.instance<FeedViewModel>().actualScreen == 0
                      ? Colors.black
                      : Colors.black,
                  size: 20.0,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              menuButton('My Bookshelf', FeedIcons.iconBookSelf, 0),
              menuButton('Add Content', FeedIcons.iconAddContect, 1),
              menuButton('My Event', FeedIcons.iconEvent, 2),
            ],
          ),
          SizedBox(
            height: Platform.isIOS ? 40 : 10,
          )
        ],
      ),
    );
  }

  Widget menuButton(String text, Icon icon, int index) {
    return GestureDetector(
      onTap: () {
        GetIt.instance<FeedViewModel>().setActualScreen(index);
      },
      child: Container(
        height: 45,
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,

            // Icon(icon,
            //     color: GetIt.instance<FeedViewModel>().actualScreen == 0
            //         ? GetIt.instance<FeedViewModel>().actualScreen == index
            //             ? Colors.white
            //             : Colors.white70
            //         : GetIt.instance<FeedViewModel>().actualScreen == index
            //             ? Colors.black
            //             : Colors.black54,
            //     size: NavigationIconSize),
            // SizedBox(
            //   height: 7
            // ),
            // Text(
            //   text,
            //   style: TextStyle(
            //       fontWeight:
            //           GetIt.instance<FeedViewModel>().actualScreen == index
            //               ? FontWeight.bold
            //               : FontWeight.normal,
            //       color: GetIt.instance<FeedViewModel>().actualScreen == 0
            //           ? GetIt.instance<FeedViewModel>().actualScreen == index
            //               ? Colors.white
            //               : Colors.white70
            //           : GetIt.instance<FeedViewModel>().actualScreen == index
            //               ? Colors.black
            //               : Colors.black54,
            //       fontSize: 11.0),
            // )
          ],
        ),
      ),
    );
  }
}
