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

import '../global/constants/assets.dart';
import 'common_upload_book_format.dart';

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
  List<Map<File, String>> _imagesPath =
      []; //page as key and path for audio as value
  int _currentIndex = 0;

  //slider
  Map<int, int> _pageTime = Map();
  late List<Widget> imageSliders;
  List<File>? cachedimages = <File>[];

  VoiceRecorderState({this.cachedimages});

  @override
  void initState() {
    int length = widget.images!.length;
    _imagesPath = List<Map<File, String>>.filled(length, {File(""): ""});
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
          var imageVoicePair = {
            widget.images![_currentIndex]: value!,
          };
          _imagesPath[_currentIndex] = imageVoicePair;
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
            fromURI: _imagesPath[_currentIndex].values.first.toString(),
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

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder.isStopped) {
      return null;
    }
    return _mPlayer.isStopped ? play : stopPlayer;
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
                    setState(() {
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
                              images: widget.images!,
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
    DocumentReference sightingRef =
    FirebaseFirestore.instance.collection('booksentity').doc();

    try {
      var imagesUrlArray = [];
      var imageUrl = "";
      var audioUrl = "";

      for (int i = 0; i < _imagesPath!.length; i++) {
        var childPath = _imagesPath![i].keys.first.path.toString().split('/');
        var storageReferencePageUrls = FirebaseStorage.instance
            .ref()
            .child('book_pages')
            .child(childPath[childPath.length - 1]);
        var upload =
            await storageReferencePageUrls.putFile(_imagesPath![i].keys.first);
        imageUrl = await upload.ref.getDownloadURL();

        var audioPath = _imagesPath![i].values.first.toString().split('/');
        var storageReference = FirebaseStorage.instance
            .ref()
            .child('audios')
            .child(audioPath[audioPath.length - 1]);
        var uploadTask =
            await storageReference.putFile(File(_imagesPath![i].values.first));
        audioUrl = await uploadTask.ref.getDownloadURL();

        var audioImagePair = {
          "page": imageUrl,
          "audio": audioUrl,
        };
        imagesUrlArray.add(audioImagePair);
      }

      sightingRef.set({
        "cover_url": widget.imageURL.toString(),
        // "audio_doc_id": audioURl,
        // "audio_Paging_time": _pageTime.values,
        "author_doc_id": "",
        "category_main": widget.category.toString(),
        "category_sub": widget.subCategory.toString(),
        "pages_url": imagesUrlArray,
        "title": widget.title.toString(),
        "topic": widget.topic.toString(),
      });
    } catch (e, stacktrace) {}
  }
}
