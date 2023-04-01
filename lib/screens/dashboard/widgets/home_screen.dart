import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/repositories/models/audiobook_model.dart';
import '../../../controllers/repositories/models/game_model.dart';
import '../../../controllers/repositories/models/video_model.dart';
import '../../../controllers/main_content_controller.dart';
import 'book_screen.dart';
import 'game_screen.dart';
import 'video_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MainContentController contentController;

  @override
  void initState() {
    super.initState();
    contentController = Get.find<MainContentController>();
  }

  testingControllerFunctionality() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        int sensitivity = 8; //** This gives a ([sensitivity * 2]) depth of sensitivity to the swipe! **/
        if (details.delta.dy > sensitivity) {
          contentController.callDownwardSwipe();
        } else if (details.delta.dy < (-sensitivity)) {
          contentController.callUpwardSwipe();
        }
      },
      child: AbsorbPointer(
        absorbing: true,
        child: PageView.custom(
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
              final data = contentController.getItemByIndex(index);
              if (data is GameModel) {
                log('#GameScreen');
                return GameScreenWidget(gameModel: data);
              } else if (data is VideoModel) {
                log('#VideoScreen');
                return VideoScreenWidget(videoController: data);
              } else if (data is AudioBookModel) {
                log('#BookScreen');
                return BookScreenWidget(bookData: data);
              } else {
                log('#NoScreen');
                return SizedBox();
              }
            },
            childCount: contentController.totalLength,
          ),
          controller: contentController.contentPageController,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}
