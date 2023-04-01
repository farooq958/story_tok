import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/video_model.dart';
import '../../screens/dashboard/data/demo/video_demo_data.dart';

class VideosAPI {
  List<VideoModel> listVideos = <VideoModel>[];

  VideosAPI() {
    getVideoList();
  }

  Future<List<VideoModel>> getVideoList() async {
    var firebaseVideoData =
        await FirebaseFirestore.instance.collection("videos").get();
    firebaseVideoData.docs.forEach((element) {
      VideoModel video = VideoModel.fromJson(element.data());
      listVideos.add(video);
    });

    print("##### VIDEO Length => ${listVideos.length}");
    return listVideos;
  }

  Future<Null> addDemoVideoData() async {
    for (var video in videoDataList) {
      await FirebaseFirestore.instance.collection("videos").add(video);
    }
  }
}
