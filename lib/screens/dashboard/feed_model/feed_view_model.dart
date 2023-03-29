import 'dart:math' as math;

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
  int? prev;

  initializer() async {
    currentItems.addAll(videoSource?.listVideos ?? []);
    currentItems.addAll(gameSource?.listGames ?? []);
    currentItems.addAll(bookSource?.audiobookList ?? []);
    currentItems.shuffle(math.Random.secure());
    notifyListeners();
  }

  CommonDataModel getItemByIndex(int newIndex) {
    currentItems[index].hold();
    if (prev != null && prev != index && prev != newIndex) {
      currentItems[prev!].dispose();
    }
    prev = index;
    index = newIndex;
    final item = currentItems[index];
    item.initiate().then((value) {
      if (item is VideoModel) item.controller!.play();
      notifyListeners();
    });
    return item;
  }
}
