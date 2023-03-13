import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storily/screens/dashboard/data/model/audiobook_model.dart';

class AudioBookAPI {
  List<AudioBookModel> audiobookList = <AudioBookModel>[];

  AudioBookAPI() {
    print("########CHECKKK!1");
    load();
  }

  void load() async {
    print("########CHECKKK!2");
    await getAudiobookList();
  }

  Future<void> getAudiobookList() async {
    print("########CHECKKK!3");
    var firebaseAudiobookData =
        await FirebaseFirestore.instance.collection("booksentity").get();

    // var videoList = <VideoModel>[];
    var modelList;
    print("##### Length => ${firebaseAudiobookData.docs.length}");
    if (firebaseAudiobookData.docs.length != 0) {
      modelList = firebaseAudiobookData;
    }

    modelList.docs.forEach((element) {
      print("##### Item => ${Map.from(element.data())}");
      audiobookList.add(AudioBookModel.fromMap(element.data()));
    });
    log("LIST LENGTH => ${audiobookList.length}");
    // return videoList;
  }
}
