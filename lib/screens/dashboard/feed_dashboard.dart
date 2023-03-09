import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:storily/global/methods/methods.dart';
import 'data/video_model.dart';
import 'feed_model/feed_view_model.dart';
import 'icons/feed_icon_data.dart';
import 'bootm_menu_screens/bookshelf.dart';
import 'profile/creators_profile.dart';
import 'widgets/actions_toolbar.dart';
import 'package:video_player/video_player.dart';
import 'widgets/video_description.dart';

class FeedDashboard extends StatefulWidget {
  FeedDashboard({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedDashboard> {
  final locator = GetIt.instance;
  final feedViewModel = GetIt.instance<FeedViewModel>();
  int currentIndex=0;

  @override
  void initState() {
    feedViewModel.loadVideo(0);
    feedViewModel.loadVideo(1);
    GetIt.instance<FeedViewModel>().setActualScreen(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
        disposeViewModel: false,
        builder: (context, model, child) => videoScreen(),
        viewModelBuilder: () => feedViewModel);
  }

  Widget videoScreen() {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            itemCount: 2,
            onPageChanged: (value) {
              print(value);
            },
            itemBuilder: (context, index) {
              if (index == 0)
                return scrollFeed();
              else
                return profileView();
            },
          )
        ],
      ),
    );
  }

  Widget scrollFeed() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: feedVideos()),
        Container(
          color: Colors.grey,
          child: Column(
            children: [
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      if(feedViewModel.videoSource!.listVideos[currentIndex].controller!.value.isPlaying){ 
                          feedViewModel.videoSource!.listVideos[currentIndex].controller!.pause();
                      }
                      goPage(context, MyBookshelfPage());                                        
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FeedIcons.iconBookSelf,
                        Text(
                          'My Bookshelf',
                          style: TextStyle(
                            fontSize: 11.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FeedIcons.iconAddContect,
                      Text(
                        'Add Content',
                        style: TextStyle(
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FeedIcons.iconEvent,
                      Text(
                        'My Event',
                        style: TextStyle(
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: Platform.isIOS ? 40 : 10,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget feedVideos() {
    return Stack(
      children: [
        PageView.builder(
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
          ),
          itemCount: feedViewModel.videoSource?.listVideos.length,
          onPageChanged: (index) {
            index = index % (feedViewModel.videoSource!.listVideos.length);
            feedViewModel.changeVideo(index);
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            index = index % (feedViewModel.videoSource!.listVideos.length);
            currentIndex = index;
            return videoCard(feedViewModel.videoSource!.listVideos[index]);
          },
        ),
        SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Following',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(width: 7),
                Container(
                  color: Colors.white70,
                  height: 10,
                  width: 1.0,
                ),
                SizedBox(width: 7),
                Text(
                  'For You',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget videoCard(VideoModel video) {
    return Stack(
      children: [
        video.controller != null
            ? GestureDetector(
                onTap: () {
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
                  child: Text("Loading...."),
                ),
              ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                VideoDescription(video.user, video.videoTitle, video.songName),
                ActionsToolbar(video.likes, video.comments,
                    "https://www.andersonsobelcosmetic.com/wp-content/uploads/2018/09/chin-implant-vs-fillers-best-for-improving-profile-bellevue-washington-chin-surgery.jpg"),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    feedViewModel.controller?.dispose();
    super.dispose();
  }
}
