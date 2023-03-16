import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'video_model.dart';

class GameModel extends CommonDataModel{
  String id;
  String user;
  String userPic;
  String videoTitle;
  String songName;
  String likes;
  String comments;
  String url;

  WebViewController? controller;

  GameModel(
      {required this.id,
      required this.user,
      required this.userPic,
      required this.videoTitle,
      required this.songName,
      required this.likes,
      required this.comments,
      required this.url});

  GameModel.fromJson(Map<dynamic, dynamic> json)
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

  Future<Null> loadController(BuildContext context) async {
    controller = WebViewController();
    controller!.setJavaScriptMode(JavaScriptMode.unrestricted);
    await controller!.loadRequest(Uri.parse(url));
  }
}
