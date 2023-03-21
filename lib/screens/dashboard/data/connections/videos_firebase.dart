import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/video_model.dart';
import '../demo/video_demo_data.dart';

class VideosAPI {
  List<VideoModel> listVideos = <VideoModel>[];

  VideosAPI() {
    load();
  }

  void load() async {
    listVideos = await getVideoList();
  }

  Future<List<VideoModel>> getVideoList() async {
    var firebaseVideoData = await FirebaseFirestore.instance.collection("videos").get();

    var videoList = <VideoModel>[];
    var videos;
    print("##### VIDEO Length => ${firebaseVideoData.docs.length}");

    if (firebaseVideoData.docs.length == 0) {
      await addDemoVideoData();
      videos = (await FirebaseFirestore.instance.collection("videos").get());
    } else {
      videos = firebaseVideoData;
    }

    videos.docs.forEach((element) {
      VideoModel video = VideoModel.fromJson(element.data());
      videoList.add(video);
    });

    return videoList;
  }
  /*
  * manually add videos in firestore
  */ 
  Future<Null> addDemoVideoData() async {
    for (var video in videoDataList) {
      await FirebaseFirestore.instance.collection("videos").add(video);
    }
  }
}