import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../data/model/audiobook_model.dart';
import '../data/model/game_model.dart';
import '../data/model/video_model.dart';
import '../feed_model/feed_view_model.dart';
import 'book_screen.dart';
import 'game_screen.dart';
import 'video_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final feedViewModel = GetIt.instance<FeedViewModel>();

  @override
  Widget build(BuildContext context) {
    return PageView.custom(
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          final data = feedViewModel.getItemByIndex(index, context);
          if (data is GameModel) {
            log('#GameScreen');
            return GameScreenWidget(gameModel: data);
          } else if (data is VideoModel) {
            log('#VideoScreen');
            return VideoScreenWidget(video: data);
          } else if (data is AudioBookModel) {
            log('#BookScreen');
            return BookScreenWidget(bookData: data);
          } else {
            log('#NoScreen');
            return SizedBox();
          }
        },
        childCount: feedViewModel.totalLength,
      ),
      controller: PageController(
        initialPage: 0,
        viewportFraction: 1,
      ),
      scrollDirection: Axis.vertical,
    );
  }
}
