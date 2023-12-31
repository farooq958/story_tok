import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storily/controllers/repositories/models/video_model.dart';
import 'package:storily/controllers/main_content_controller.dart';
import 'package:storily/screens/dashboard/widgets/video_description.dart';
import 'package:video_player/video_player.dart';
import 'actions_toolbar.dart';

class VideoScreenWidget extends StatefulWidget {
  const VideoScreenWidget({Key? key, required this.videoController}) : super(key: key);
  final VideoModel videoController;
  @override
  State<VideoScreenWidget> createState() => _VideoScreenWidgetState();
}

class _VideoScreenWidgetState extends State<VideoScreenWidget> {
  late final VideoModel video;
  @override
  void initState() {
    super.initState();
    video = widget.videoController;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainContentController>(
      builder: (controller) => Stack(
        children: [
          video.controller != null
              ? GestureDetector(
                  onTap: () {
                    log("${video.controller!.value.isPlaying}");
                    if (video.controller!.value.isPlaying) {
                      video.controller?.pause();
                    } else {
                      video.controller?.play();
                    }
                  },
                  child: SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: video.controller?.value.size.width ?? 0,
                        height: video.controller?.value.size.height ?? 0,
                        child: VideoPlayer(video.controller!),
                      ),
                    ),
                  ),
                )
              : Container(
                  color: Colors.black,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  VideoDescription(
                      video.user, video.videoTitle, video.songName),
                  ActionsToolbar(
                    video.likes,
                    video.comments,
                    "https://www.andersonsobelcosmetic.com/wp-content/uploads/2018/09/chin-implant-vs-fillers-best-for-improving-profile-bellevue-washington-chin-surgery.jpg",
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
