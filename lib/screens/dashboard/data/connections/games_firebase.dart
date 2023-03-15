import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storily/screens/dashboard/data/model/game_model.dart';
import '../demo/game_demo_data.dart';
import '../model/video_model.dart';

class GameAPI {
  List<GameModel> listGames = <GameModel>[];

  GameAPI() {
    load();
  }

  void load() async {
    listGames = await getGameList();
  }

  Future<List<GameModel>> getGameList() async {
    var data = await FirebaseFirestore.instance.collection("game_list").get();

    var videoList = <GameModel>[];
    var games;

    if (data.docs.length == 0) {
      await addDemoData();
      games = (await FirebaseFirestore.instance.collection("game_list").get());
    } else {
      games = data;
    }

    games.docs.forEach((element) {
      GameModel game = GameModel.fromJson(element.data());
      videoList.add(game);
    });

    return videoList;
  }
  /*
  * manually add vieos in firestore
  */ 
  Future<Null> addDemoData() async {
    for (var game in gameData) {
      await FirebaseFirestore.instance.collection("game_list").add(game);
    }
  }
}