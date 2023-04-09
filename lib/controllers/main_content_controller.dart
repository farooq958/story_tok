import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:storily/controllers/repositories/games_repository.dart';
import 'repositories/models/base_content_model.dart';
import 'repositories/models/video_model.dart';
import 'repositories/videos_repository.dart';
import 'repositories/audiobooks_repository.dart';

class MainContentController extends GetxController {
  late VideosAPI videoSource;
  late GameAPI gameSource;
  late AudioBookAPI bookSource;
  PageController contentPageController = PageController(
    initialPage: 0,
    keepPage: false,
    viewportFraction: 1,
  ).obs();

  List<CommonDataModel> currentItems = [];
  int get totalLength => currentItems.length;
  int get currentIndex => index;

  @override
  void onInit() {
    super.onInit();
    videoSource = VideosAPI();
    gameSource = GameAPI();
    bookSource = AudioBookAPI();
  }

  int index = 0;
  int? prev;

  initializer() async {
    currentItems.addAll(videoSource.listVideos);
    currentItems.addAll(gameSource.listGames);
    currentItems.addAll(bookSource.audiobookList);
    currentItems.shuffle(math.Random.secure());
    update();
  }

  CommonDataModel getItemByIndex(int newIndex) {
    currentItems[index].hold();
    if (prev != null && prev != index && prev != newIndex) {
      currentItems[prev!].dispose();
    }
    prev = index;
    index = newIndex;
    final item = currentItems[index];
    item.initiate(index).then((value) {
      if (item is VideoModel && value == currentIndex) item.controller!.play();
      update();
    });
    return item;
  }
}
