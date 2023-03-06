
import 'package:stacked/stacked.dart';
import 'package:storily/screens/dashboard/data/games_firebase.dart';
import 'package:video_player/video_player.dart';
import '../data/videos_firebase.dart';

class FeedViewModel extends BaseViewModel {
  VideoPlayerController? controller;
  VideosAPI? videoSource;

  int prevVideo = 0;

  int actualScreen = 0;

  FeedViewModel() {
    videoSource = VideosAPI();
  }

  changeVideo(index) async {
    if (videoSource!.listVideos[index].controller == null) {
      await videoSource!.listVideos[index].loadController();
    }
    videoSource!.listVideos[index].controller!.play();

    if (videoSource!.listVideos[prevVideo].controller != null)
      videoSource!.listVideos[prevVideo].controller!.pause();

    prevVideo = index;
    notifyListeners();

    print(index);
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
