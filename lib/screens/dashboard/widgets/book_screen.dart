import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:storily/screens/dashboard/data/model/audiobook_model.dart';

class BookScreenWidget extends StatefulWidget {
  const BookScreenWidget({Key? key, required this.bookData}) : super(key: key);
  final AudioBookModel bookData;
  @override
  State<BookScreenWidget> createState() => _BookScreenWidgetState();
}

class _BookScreenWidgetState extends State<BookScreenWidget> {
  late PageController controller;
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState? currentPlayerState;

  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (currentPlayerState == null) {
        currentPlayerState = event;
      } else {
        currentPlayerState = event;
        setState(() {});
      }
    });

    controller = PageController(initialPage: 0);
    setUpAudioPlayer();
  }

  setUpAudioPlayer() async {
    if (widget.bookData.pageUrl.length >= pageIndex) {
      final data = widget.bookData.pageUrl[pageIndex - 1];

      if (audioPlayer.state == PlayerState.playing) {
        audioPlayer.pause();
      }
      await audioPlayer.setSource(
        UrlSource(data.audioUrl!),
      );
    } else {
      log("INDEX OR NULL PLAYER ERROR!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 24,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                widget.bookData.title ?? "",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Proxima Nova Bold'),
              ),
            ),
          ),
          Positioned(
            top: 24,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Page : $pageIndex / ${widget.bookData.pageUrl.length}",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Proxima Nova Bold'),
              ),
            ),
          ),
          PageView(
            controller: controller,
            onPageChanged: (value) {
              pageIndex = (value + 1);
              setUpAudioPlayer();
              setState(() {});
            },
            children: widget.bookData.pageUrl
                .map(
                  (pageData) => Image.network(
                    pageData.pageUrl!,
                    loadingBuilder: (context, child, loadingProgress) =>
                        (loadingProgress != null)
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : child,
                  ),
                )
                .toList(),
          ),
          Positioned(
            bottom: 24,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  print("clicked");
                  if (audioPlayer.state == PlayerState.playing) {
                    audioPlayer.pause();
                  } else if (audioPlayer.state == PlayerState.completed) {
                    // audioPlayer.release();
                    audioPlayer.resume();
                    // audioPlayer.play(source)
                  } else {
                    audioPlayer.resume();
                  }
                },
                // iconSize: 32,
                icon: Icon(
                  (audioPlayer.state == PlayerState.playing)
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                label: Text("Book Audio"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
