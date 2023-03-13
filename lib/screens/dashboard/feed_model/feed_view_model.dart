import 'dart:math';

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
    print("########CHECKKK!0");
    bookSource = AudioBookAPI();
  }

  int index = 0;

  initializer() async {
    currentItems.addAll(videoSource?.listVideos ?? []);
    currentItems.addAll(gameSource?.listGames ?? []);
    currentItems.shuffle(Random.secure());
    notifyListeners();
  }

  CommonDataModel getItemByIndex(int newIndex) {
    index = newIndex;
    final item = currentItems[index];
    item.loadController().then((value) {
      notifyListeners();
    });
    return item;
  }

/*   CommonDataModel? nextItem() {
    ///[true] will send [VideoModel] & [false] will send GameModel;
    final option = Random(DateTime.now().microsecondsSinceEpoch).nextBool();
    if (option) {
      if (videoSource!.listVideos.length > videoIndex) {
        return getUpdatedVideo();
      } else {
        return getUpdatedGame();
      }
    } else {
      if (prevGame != null) {}
      if (gameSource!.listGames.length > gameIndex) {
        return getUpdatedGame();
      } else {
        return getUpdatedVideo();
      }
    }
  }

  VideoModel? getUpdatedVideo() {
    prevVideo = videoIndex;
    if (prevVideo != null) {
      videoSource?.listVideos[prevVideo!].controller?.dispose();
    }
    final videoModel = videoSource?.listVideos[videoIndex];
    videoModel?.loadController().then((value) {
      videoModel.controller!.play();
      notifyListeners();
    });
    videoIndex++;
    return videoModel;
  }

  GameModel? getUpdatedGame() {
    prevGame = gameIndex;
    final gameModel = gameSource?.listGames[gameIndex];
    gameModel?.loadController().then((value) {
      notifyListeners();
    });
    gameIndex++;
    return gameModel;
  } */

  /* void loadVideo(int index) async {
    if (videoSource!.listVideos.length > index) {
      await videoSource!.listVideos[index].loadController();
      videoSource!.listVideos[index].controller?.play();
      notifyListeners();
    }
  } */
}
