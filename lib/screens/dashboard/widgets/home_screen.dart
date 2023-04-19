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
    return PageView.custom(
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          final data = contentController.getItemByIndex(index);
          if (data is GameModel) {
            log('common #GameScreen');
            return GameScreenWidget(gameModel: data);
          } else if (data is VideoModel) {
            log('common #VideoScreen');
            return VideoScreenWidget(videoController: data);
          } else if (data is AudioBookModel) {
            log('common #BookScreen');
            return BookScreenWidget(bookData: data);
          } else {
            log('common #NoScreen');
            return SizedBox();
          }
        },
        childCount: contentController.totalLength,
      ),
      controller: contentController.contentPageController,
      scrollDirection: Axis.vertical,
    );
  }
}
