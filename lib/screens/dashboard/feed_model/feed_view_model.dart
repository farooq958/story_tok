import 'dart:math';

import 'package:stacked/stacked.dart';
import 'package:storily/screens/dashboard/data/game_model.dart';
import 'package:storily/screens/dashboard/data/games_firebase.dart';
import 'package:video_player/video_player.dart';
import '../data/video_model.dart';
import '../data/videos_firebase.dart';

class FeedViewModel extends BaseViewModel {
  VideoPlayerController? controller;
  VideosAPI? videoSource;
  GameAPI? gameSource;
  int? prevVideo;
  int? prevGame;
  int gameIndex = 0;
  int videoIndex = 0;

  int get totalLength =>
      (videoSource?.listVideos.length ?? 0) +
      (gameSource?.listGames.length ?? 0);

  int actualScreen = 0;

  FeedViewModel() {
    videoSource = VideosAPI();
    gameSource = GameAPI();
  }

  DataModel? nextItem() {
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
  }

  void loadVideo(int index) async {
    if (videoSource!.listVideos.length > index) {
      await videoSource!.listVideos[index].loadController();
      videoSource!.listVideos[index].controller?.play();
      notifyListeners();
    }
  }

  void setActualScreen(index) {
    actualScreen = 0;
    notifyListeners();
  }
}
