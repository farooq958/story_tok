/* import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/video_model.dart';
import '../demo/video_demo_data.dart';

class AudioBookAPI {
  List<VideoModel> audiobookListt = <VideoModel>[];

  AudioBookAPI() {
    load();
  }

  void load() async {
    audiobookListt = await getAudiobookList();
  }

  Future<List<VideoModel>> getAudiobookList() async {
    var firebaseAudiobookData = await FirebaseFirestore.instance.collection("videos").get();

    var videoList = <VideoModel>[];
    var videos;

    if (firebaseAudiobookData.docs.length == 0) {
      await addDemoAudiobookData();
      videos = (await FirebaseFirestore.instance.collection("videos").get());
    } else {
      videos = firebaseAudiobookData;
    }

    videos.docs.forEach((element) {
      VideoModel video = VideoModel.fromJson(element.data());
      videoList.add(video);
    });

    return videoList;
  }
  /*
  * manually add addDemoAudiobookData in firestore
  */ 
  Future<Null> addDemoAudiobookData() async {
    for (var video in videoDataList) {
      await FirebaseFirestore.instance.collection("videos").add(video);
    }
  }
} */