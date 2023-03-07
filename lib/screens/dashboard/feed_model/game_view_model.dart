
import 'package:stacked/stacked.dart';
import 'package:storily/screens/dashboard/data/games_firebase.dart';
import 'package:video_player/video_player.dart';
import '../data/videos_firebase.dart';

class GameViewModel extends BaseViewModel {
  
  GameAPI? gameSource;

  int prevVideo = 0;

  int actualScreen = 0;

  GameViewModel() {
    gameSource = GameAPI();
  }

  changeVideo(index) async {
  
    prevVideo = index;
    notifyListeners();

    print(index);
  }

  void loadGame (int index) async {
    if (gameSource!.listGames.length > index) {
      await gameSource!.listGames[index].likes;
      gameSource!.listGames[index].url;
      notifyListeners();
    }
  }

  void setActualScreen(index) {
    actualScreen = 0;
    notifyListeners();
  }
}
