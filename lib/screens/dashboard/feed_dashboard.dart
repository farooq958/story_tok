import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:storily/global/methods/methods.dart';
import 'package:storily/screens/dashboard/data/game_model.dart';
import 'package:storily/screens/dashboard/widgets/game_screen.dart';
import 'data/video_model.dart';
import 'feed_model/feed_view_model.dart';
import 'icons/feed_icon_data.dart';
import 'bootm_menu_screens/bookshelf.dart';
import 'profile/creators_profile.dart';
import 'widgets/video_screen.dart';

class FeedDashboard extends StatefulWidget {
  FeedDashboard({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedDashboard> {
  final feedViewModel = GetIt.instance<FeedViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              if (index == 0)
                return scrollFeed();
              else
                return profileView();
            },
          )
        ],
      ),
    );
  }

  Widget scrollFeed() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: feedVideos()),
        Container(
          color: Colors.grey,
          child: Column(
            children: [
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (feedViewModel
                          .videoSource!
                          .listVideos[feedViewModel.videoIndex]
                          .controller!
                          .value
                          .isPlaying) {
                        feedViewModel.videoSource!
                            .listVideos[feedViewModel.videoIndex].controller!
                            .pause();
                      }
                      goPage(context, MyBookshelfPage());
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FeedIcons.iconBookSelf,
                        Text(
                          'My Bookshelf',
                          style: TextStyle(
                            fontSize: 11.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FeedIcons.iconAddContect,
                      Text(
                        'Add Content',
                        style: TextStyle(
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FeedIcons.iconEvent,
                      Text(
                        'My Event',
                        style: TextStyle(
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: Platform.isIOS ? 40 : 10,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget feedVideos() {
    return Stack(
      children: [
        PageView.builder(
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
          ),
          itemCount: feedViewModel.totalLength,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = feedViewModel.nextItem();
            if (data != null) {
              if (data is GameModel) {
                return GameScreenWidget(
                  gameModel: data,
                );
              } else {
                return VideoScreenWidget(
                  video: data as VideoModel,
                );
              }
            }
            return SizedBox();
          },
        ),
        SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Following',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(width: 7),
                Container(
                  color: Colors.white70,
                  height: 10,
                  width: 1.0,
                ),
                SizedBox(width: 7),
                Text(
                  'For You',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    feedViewModel.controller?.dispose();
    super.dispose();
  }
}
