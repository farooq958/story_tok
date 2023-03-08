import 'package:storily/screens/dashboard/data/game_model.dart';
import 'package:video_player/video_player.dart';

class VideoModel extends DataModel {
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
      : id = json['id'],
        user = json['user'],
        userPic = json['user_pic'],
        videoTitle = json['video_title'],
        songName = json['song_name'],
        likes = json['likes'],
        comments = json['comments'],
        url = json['url'];

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

  Future<Null> loadController() async {
    controller = VideoPlayerController.network(url);
    await controller?.initialize();
    controller?.setLooping(true);
  }
}
