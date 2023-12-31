import 'package:video_player/video_player.dart';

import 'base_content_model.dart';

class VideoModel extends CommonDataModel {
  String id;
  String user;
  String userPic;
  String videoTitle;
  String songName;
  String likes;
  String comments;
  String url;

  VideoPlayerController? controller;

  VideoModel(
      {required this.id,
      required this.user,
      required this.userPic,
      required this.videoTitle,
      required this.songName,
      required this.likes,
      required this.comments,
      required this.url});

  VideoModel.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'] != null ? json['id'] : '',
        user = json['user'] != null ? json['user'] : '',
        userPic = json['user_pic'] != null ? json['user'] : '',
        videoTitle = json['video_title'] != null ? json['video_title'] : '',
        songName = json['song_name'] != null ? json['song_name'] : '',
        likes = json['likes'] != null ? json['likes'] : '',
        comments = json['comments'] != null ? json['comments'] : '',
        url = json['url'] != null ? json['url'] : '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['user_pic'] = this.userPic;
    data['video_title'] = this.videoTitle;
    data['song_name'] = this.songName;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    data['url'] = this.url;
    return data;
  }

  Future<int> initiate(int index) async {
    controller = VideoPlayerController.network(url);
    await controller?.initialize();
    controller?.setLooping(true);
    return index;
  }

  @override
  Future<void> hold() {
    controller?.pause();
    return super.hold();
  }

  @override
  Future<void> dispose() {
    if (controller!.value.isPlaying) {
      controller!.pause().then((value) {
        controller = null;
      });
      controller = null;
    }
    return super.dispose();
  }
}

