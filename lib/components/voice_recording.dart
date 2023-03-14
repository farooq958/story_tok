import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:audio_session/audio_session.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:record/record.dart';
import 'package:storily/components/recording_preview.dart';

/*final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];*/

typedef _Fn = void Function();

const theSource = AudioSource.microphone;

class VoiceRecorder extends StatefulWidget {
  List<File>? images = <File>[];
  var ref;
  var imageURL;
  var category;
  var subCategory;
  var title;
  var topic;

  VoiceRecorder(
      [this.images,
      this.ref,
      this.imageURL,
      this.category,
      this.subCategory,
      this.title,
      this.topic]);

  @override
  VoiceRecorderState createState() => VoiceRecorderState(cachedimages: images);
}

class VoiceRecorderState extends State<VoiceRecorder> {
  //recorder
  Codec _codec = Codec.aacMP4;
  var _mPath;
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  final _audioRecorder = Record();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  Stopwatch _timer = Stopwatch();
  File audioFile = File('');
  var _imagesPath = [];
  int _currentIndex = 0;

  //slider
  Map<int, int> _pageTime = Map();
  late List<Widget> imageSliders;
  List<File>? cachedimages = <File>[];

  VoiceRecorderState({this.cachedimages});

  @override
  void initState() {
    _mPlayer.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });

    InitImageSliders();
    super.initState();
  }

  @override
  void dispose() {
    _mPlayer.closePlayer();
    _mPlayer;

    _mRecorder.closeRecorder();
    _mRecorder;
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder.openRecorder();
    if (!await _mRecorder.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'tau_file.webm';
      if (!await _mRecorder.isEncoderSupported(_codec) && kIsWeb) {
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
  bool start = false;

  record() {
    _audioRecorder.start().then((value) {
      setState(() {
        start = true;
        _timer.start();
      });
    });
  }

  stop() async {
    _audioRecorder.stop().then((value) {
      try {
        setState(() {
          start = false;
          _imagesPath.add(value!);
          _mPath = value!;
          _mplaybackReady = true;
          _timer.stop();
        });
      } catch (e, stacktrace) {}
    });
  }

  void play() {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder.isStopped &&
        _mPlayer.isStopped);
    _mPlayer
        .startPlayer(
            fromURI: _imagesPath[_currentIndex].toString(),
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayer() {
    _mPlayer.stopPlayer().then((value) {
      setState(() {});
    });
  }

// ----------------------------- UI --------------------------------------------

  // _Fn? getRecorderFn() {
  //   if (!_mRecorderIsInited || !_mPlayer.isStopped) {
  //     return null;
  //   }
  //   return _mRecorder.isStopped ? record : stopRecorder;
  // }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder.isStopped) {
      return null;
    }
    return _mPlayer.isStopped ? play : stopPlayer;
  }

  //final CarouselController _controller = CarouselController();
  void InitImageSliders() {
    imageSliders = cachedimages!.map((item) {
      return Container(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
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
                        'No. ${cachedimages!.indexOf(item)} image',
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
                      });
                    _pageTime.addAll({index: _timer.elapsedMilliseconds});
                  }),
              items: imageSliders,
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
                onPressed: !start ? record : stop,
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(start ? 'Done' : 'Record'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(_mRecorder.isRecording
                  ? 'Recording in progress'
                  : 'Recorder is stopped'),
            ]),
          ),
          MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecordingPreview(
                              pageTime: _pageTime,
                              images: cachedimages!,
                              imagesPath: _imagesPath,
                            )));
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.mail_outline,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Preview",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              )),
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
                child: Text(_mPlayer.isPlaying ? 'Stop' : 'Play'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(_mPlayer.isPlaying
                  ? 'Playback in progress'
                  : 'Player is stopped'),
            ]),
          ),
          ElevatedButton(
              onPressed: () {
                saveFile();
              },
              child: Text("Submit"))
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Record your book'),
      ),
      body: makeBody(),
    );
  }

  Future<void> saveFile() async {
    try {
      var imagesUrlArray = [];
      var imageUrl = "";

      for (int i = 0; i < cachedimages!.length; i++) {
        var childPath = cachedimages![i].path.toString().split('/');
        var storageReferencePageUrls =
        FirebaseStorage.instance.ref().child('book_pages').child(childPath[childPath.length-1]);
        var upload = await storageReferencePageUrls
            .putFile(cachedimages![i]);
        imageUrl = await upload.ref.getDownloadURL();
        imagesUrlArray.add(imageUrl);
      }

      var audioPath = _mPath.toString().split('/');
      var storageReference =
          FirebaseStorage.instance.ref().child('audios').child(audioPath[audioPath.length-1]);
      UploadTask uploadTask = storageReference.putFile(File(_mPath));
      await uploadTask.then((res) {
        storageReference.getDownloadURL().then((audioURl) {


          widget.ref.set({
            "cover_url": widget.imageURL.toString(),
            "audio_doc_id": audioURl,
            "audio_Paging_time":_pageTime.values,
            "author_doc_id": "",
            "category_main": widget.category.toString(),
            "category_sub": widget.subCategory.toString(),
            "pages_url": imagesUrlArray,
            "title": widget.title.toString(),
            "topic": widget.topic.toString(),
          });
        });
      });
    } catch (e, stacktrace) {}
  }
}
