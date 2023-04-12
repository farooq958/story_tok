import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:audio_session/audio_session.dart';
import 'package:carousel_slider/carousel_slider.dart';

typedef _Fn = void Function();

const theSource = AudioSource.microphone;

class RecordingPreview extends StatefulWidget {
  Map<int, int>? pageTime;
  List<File>? images = <File>[];
  List<Map<File, String>>?  imagesPath= [];

  RecordingPreview({this.pageTime, this.images, this.imagesPath}) : super();

  @override
  RecordingPreviewState createState() =>
      RecordingPreviewState(pageTime: pageTime, cachedImages: images!);
}

class RecordingPreviewState extends State<RecordingPreview> {
  //recorder
  Codec _codec = Codec.aacMP4;
  var _mPath;
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  StreamSubscription? _playerSubscription;
  int _currentIndex = 0;


  //slider
  final CarouselController _controller = CarouselController();
  List<File> cachedImages = <File>[];
  Map<int, int>? pageTime;
  List<Widget>? imageSliders;
  int currentPage = 1;

  RecordingPreviewState({required this.pageTime, required this.cachedImages})
      : super();

  @override
  void initState() {
    _mPlayer?.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });

    _mPlayer?.setSubscriptionDuration(Duration(milliseconds: 100));
    /*_playerSubscription = _mPlayer?.onProgress!.listen((e) {
      setState(() {
        if (pageTime![currentPage] != null &&
            (e.position.inMilliseconds > pageTime![currentPage]!)) {
          _controller.nextPage();
          currentPage++;
        }
        //pos = e.position.inMilliseconds;
      });
      //Duration maxDuration = e.duration;
      Duration position = e.position;
      *//*if(position.inMilliseconds > pageTime[currentPage])
          {
            _controller.nextPage();
            currentPage ++;
          }*//*
    });*/


    InitImageSliders();
    super.initState();
  }

  @override
  void dispose() {
    _mPlayer!.closePlayer();
    _mPlayer = null;

    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openRecorder();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _mRecorderIsInited = true;
  }

  // ----------------------  Here is the code for recording and playback -------

  void record() {
    _mRecorder!
        .startRecorder(
      toFile: _mPath,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      setState(() {});
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        //var url = value;
        _mplaybackReady = true;
      });
    });
  }

  void play() {
    assert(_mPlayerIsInited &&
        // _mplaybackReady &&
        //_mRecorder.isStopped &&
        _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
            fromURI: widget.imagesPath![_currentIndex].values.first,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              _controller.nextPage();
              currentPage++;
              setState((){});
            })
        .then((value) {
      setState(() {});
    });
  }

  void update(StatefulWidget newWidget)
  {

  }
  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      setState(() {
        //
      });
    });
  }

// ----------------------------- UI --------------------------------------------

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
      return null;
    }
    return _mRecorder!.isStopped ? record : stopRecorder;
  }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited) {
      //|| !_mplaybackReady || !_mRecorder.isStopped) {
      return null;
    }
    return _mPlayer!.isStopped ? play : stopPlayer;
  }

  var selectedIndex;
  //final CarouselController _controller = CarouselController();

  void InitImageSliders() {
    imageSliders = cachedImages.map((item) {
      setState(() {
        selectedIndex = cachedImages.indexOf(item);
      });
      return Container(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: [
                  Image.file(item, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        'No. ${cachedImages.indexOf(item)} image',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Widget makeBody() {
      return Column(
        children: [
          Container(
            child: CarouselSlider(
              options: CarouselOptions(
                //autoPlay: true,
                aspectRatio: 2.0,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState((){
                    _currentIndex = index;
                    play();
                  });
                },
              ),
              items: imageSliders,
              carouselController: _controller,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            height: 80,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: Row(children: [
              ElevatedButton(
                onPressed: getPlaybackFn(),
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(_mPlayer!.isPlaying ? 'Stop' : 'Play'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(_mPlayer!.isPlaying
                  ? 'Playback in progress'
                  : 'Player is stopped'),
            ]),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Recording Preview'),
      ),
      body: makeBody(),
    );
  }
}
