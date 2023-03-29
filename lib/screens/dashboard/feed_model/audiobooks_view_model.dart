import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storily/screens/dashboard/data/model/audiobook_model.dart';

class AudioBookAPI {
  List<AudioBookModel> audiobookList = <AudioBookModel>[];

  AudioBookAPI() {
    getAudiobookList();
  }

  Future<void> getAudiobookList() async {
    try {
      var firebaseAudiobookData =
          await FirebaseFirestore.instance.collection("booksentity").get();
      var modelList;
      if (firebaseAudiobookData.docs.length != 0) {
        modelList = firebaseAudiobookData;
      }

      modelList.docs.forEach((element) {
        log(element.data().toString());
        audiobookList.add(AudioBookModel.fromMap(element.data()));
      });
    } catch (e, s) {
      log("AudioBooks Error!", error: e, stackTrace: s);
    }
  }
}
