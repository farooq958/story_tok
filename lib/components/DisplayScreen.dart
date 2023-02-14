import 'dart:typed_data';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_player/video_player.dart';
import 'package:storily/components/MazeGameScreen.dart';

class VideoDisplayScreen extends StatefulWidget {
  final String videoURL;

  VideoDisplayScreen({@required this.videoURL});

  @override
  _VideoDisplayScreenState createState() => _VideoDisplayScreenState();
}

class _VideoDisplayScreenState extends State<VideoDisplayScreen> {
  Uint8List videoData;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  _loadVideo() async {
    final ref = FirebaseStorage.instance.ref().child(widget.videoURL);
    final videoData = await ref.getData(10485760);
    setState(() {
      this.videoData = videoData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity > 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GameLoader()),
            );
          }
        },
        child: Center(
          child: videoData == null
              ? CircularProgressIndicator()
              : Container(
            child: videoData == null
                ? CircularProgressIndicator()
                : VideoPlayer(
              data: videoData,
            ),
          ),
        ),
      ),
    );
  }
}

class VideoPlayer extends StatefulWidget {
  final Uint8List data;

  VideoPlayer({@required this.data});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')//.memory(widget.data)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : Container();
  }
}