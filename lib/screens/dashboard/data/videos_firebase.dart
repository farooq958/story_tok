import 'package:cloud_firestore/cloud_firestore.dart';

import 'video_model.dart';
import 'video_demo_data.dart';

class VideosAPI {
  List<VideoModel> listVideos = <VideoModel>[];

  VideosAPI() {
    load();
  }

  void load() async {
    listVideos = await getVideoList();
  }

  Future<List<VideoModel>> getVideoList() async {
    var data = await FirebaseFirestore.instance.collection("videos").get();

    var videoList = <VideoModel>[];
    var videos;

    if (data.docs.length == 0) {
      await addDemoData();
      videos = (await FirebaseFirestore.instance.collection("videos").get());
    } else {
      videos = data;
    }

    videos.docs.forEach((element) {
      VideoModel video = VideoModel.fromJson(element.data());
      videoList.add(video);
    });

    return videoList;
  }
  /*
  * manually add vieos in firestore
  */ 
  Future<Null> addDemoData() async {
    for (var video in videoData) {
      await FirebaseFirestore.instance.collection("videos").add(video);
    }
  }
}