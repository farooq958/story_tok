
import 'package:stacked/stacked.dart';
import 'package:storily/screens/dashboard/data/games_firebase.dart';

class GameViewModel extends BaseViewModel {
  
  GameAPI? gameSource;

  int prevGame = 0;

  GameViewModel() {
    gameSource = GameAPI();
  }

  changeVideo(index) async {
  
    prevGame = index;
    notifyListeners();

    print(index);
  }

  void loadGame (int index) async {
    if (gameSource!.listGames.length > index) {
      await gameSource!.listGames[index].loadController();
      notifyListeners();
    }
  }

  /* void setActualScreen(index) {
    actualScreen = 0;
    notifyListeners();
  } */
}
