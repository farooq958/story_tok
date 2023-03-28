import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:storily/screens/dashboard/data/model/audiobook_model.dart';

class BookScreenWidget extends StatefulWidget {
  const BookScreenWidget({Key? key, required this.bookData}) : super(key: key);
  final AudioBookModel bookData;
  @override
  State<BookScreenWidget> createState() => _BookScreenWidgetState();
}

class _BookScreenWidgetState extends State<BookScreenWidget> {
  late PageController controller;
  int pageIndex = 1;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
    widget.bookData.audioPlayer!.play();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1484176141566-3674cda218f0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mzh8fHJlYWRpbmclMjBlbnZpcmlvbm1lbnQlMjBkYXJrJTIwYm9va3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 24,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  widget.bookData.title ?? "",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Proxima Nova Bold',
                  ),
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
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Proxima Nova Bold'),
                ),
              ),
            ),
            PageView(
              controller: controller,
              onPageChanged: (value) {
                widget.bookData.setAudioPlayerSource(value);
                pageIndex = (value + 1);
                currentIndex = value;
                setState(() {});
              },
              children: widget.bookData.pageUrl
                  .map(
                    (pageData) => CachedNetworkImage(
                      imageUrl: pageData.pageUrl!,
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Positioned(
              bottom: 24,
              right: 0,
              child: StreamBuilder<PlayerState>(
                  stream: widget.bookData.audioPlayer!.playerStateStream,
                  builder: (context, snapshot) {
                    log(snapshot.data.toString());
                    return (snapshot.hasData)
                        ? InkWell(
                            onTap: () async =>
                                await controllerFunction(snapshot.data!)
                            /* if (snapshot.data != null) {
                                (snapshot.data!.playing)
                                    ? await widget.bookData.audioPlayer!.pause()
                                    : await widget.bookData.audioPlayer!.play();
                                return;
                              }
                              if (snapshot.data!.processingState ==
                                  ProcessingState.completed) {
                                widget.bookData
                                    .setAudioPlayerSource(currentIndex);
                              } */
                            ,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                (snapshot.data != null)
                                    ? getProperIcon(snapshot.data!)
                                    : Icons.network_check_sharp,
                              ),
                            ),
                          )
                        : const SizedBox();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  controllerFunction(PlayerState data) async {
    switch (data.processingState) {
      case ProcessingState.loading:
        {}
        break;
      case ProcessingState.idle:
        {
          await widget.bookData.setAudioPlayerSource(currentIndex);
        }
        break;
      case ProcessingState.buffering:
        {}
        break;
      case ProcessingState.ready:
        {
          if (data.playing) {
            await widget.bookData.audioPlayer!.pause();
          } else {
            await widget.bookData.audioPlayer!.play();
          }
        }
        break;
      case ProcessingState.completed:
        {
          await widget.bookData.setAudioPlayerSource(currentIndex);
        }
        break;
    }
  }

  IconData getProperIcon(PlayerState currentState) {
    switch (currentState.processingState) {
      case ProcessingState.loading:
        return Icons.network_check_sharp;
      case ProcessingState.idle:
        return Icons.warning_amber_outlined;
      case ProcessingState.buffering:
        return Icons.network_check_sharp;
      case ProcessingState.ready:
        return currentState.playing ? Icons.pause : Icons.play_arrow;
      case ProcessingState.completed:
        return Icons.replay_circle_filled_outlined;
    }
  }
}
