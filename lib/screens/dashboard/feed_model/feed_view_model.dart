import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:storily/screens/dashboard/data/connections/games_firebase.dart';
import 'package:video_player/video_player.dart';
import '../data/model/video_model.dart';
import '../data/connections/videos_firebase.dart';
import 'audiobooks_view_model.dart';

class FeedViewModel extends BaseViewModel {
  List<CommonDataModel> currentItems = [];

  VideoPlayerController? controller;
  VideosAPI? videoSource;
  GameAPI? gameSource;
  AudioBookAPI? bookSource;

  int get totalLength => currentItems.length;

  FeedViewModel() {
    videoSource = VideosAPI();
    gameSource = GameAPI();
    bookSource = AudioBookAPI();
  }

  int index = 0;

  initializer() async {
    log("Video => ${videoSource!.listVideos.length}");
    log("Game => ${gameSource!.listGames.length}");
    log("Book => ${bookSource!.audiobookList.length}");
    currentItems.addAll(videoSource?.listVideos ?? []);
    currentItems.addAll(gameSource?.listGames ?? []);
    currentItems.addAll(bookSource?.audiobookList ?? []);
    currentItems.shuffle(math.Random.secure());
    notifyListeners();
  }

  CommonDataModel getItemByIndex(int newIndex, BuildContext context) {
    currentItems[index].dispose();
    if (currentItems[index] is VideoModel &&
        (currentItems[index] as VideoModel).controller != null &&
        (currentItems[index] as VideoModel).controller!.value.isPlaying) {
      (currentItems[index] as VideoModel).controller!.pause();
    }
    index = newIndex;
    final item = currentItems[index];
    item.loadController().then((value) {
      if (item is VideoModel) item.controller!.play();
      notifyListeners();
    });
    return item;
  }
}
