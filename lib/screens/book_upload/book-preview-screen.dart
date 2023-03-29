import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:audio_session/audio_session.dart';
import 'package:record/record.dart';
import 'package:storily/components/add_author_description.dart';
import '../../components/common_upload_book_format.dart';
import '../../global/constants/assets.dart';

typedef _Fn = void Function();

const theSource = AudioSource.microphone;

class VoiceRecorder extends StatefulWidget {
  List<File>? images = <File>[];
  var imagesPath;
  var flag;
  var ref;
  var imageURL;
  var category;
  var subCategory;
  var title;
  var topic;

  VoiceRecorder(
      [this.images,
      this.imagesPath,
      this.flag,
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
  List imagesPath = [];
  bool recordingStart = false;
  bool withAudio = false;

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
  List<Map<File, String>> _audioPaths =
      []; //page as key and path for audio as value
  int _currentIndex = 0;
  int length = 0;
  var title = 'Audio Recording';

  Map<int, int> _pageTime = Map();
  List<File>? cachedimages = <File>[];

  VoiceRecorderState({this.cachedimages});

  @override
  void initState() {
    length = widget.images!.length;
    _audioPaths = List<Map<File, String>>.filled(length, {File(""): ""});
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
    await session.configure(
      AudioSessionConfiguration(
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
      ),
    );

    _mRecorderIsInited = true;
  }

  record() {
    _audioRecorder.start().then((value) {
      setState(() {
        recordingStart = true;
        _timer.start();
      });
    });
  }

  recordStop() async {
    _audioRecorder.stop().then((value) {
      try {
        setState(() {
          withAudio = true;
          recordingStart = false;
          var imageVoicePair = {
            widget.images![_currentIndex]: value!,
          };
          _audioPaths[_currentIndex] = imageVoicePair;
          _mPath = value!;
          _mplaybackReady = true;
          _timer.stop();
        });
      } catch (e, stacktrace) {}
    });
  }

  bool startPlaying = false;

  void play() {
    if (startPlaying) {
      stopPlayer();
    } else {
      assert(_mPlayerIsInited &&
          _mplaybackReady &&
          _mRecorder.isStopped &&
          _mPlayer.isStopped);
      _mPlayer
          .startPlayer(
              fromURI: _audioPaths[_currentIndex].values.first.toString(),
              //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
              whenFinished: () {
                setState(() {});
              })
          .then((value) {
        setState(() {
          startPlaying = true;
        });
      });
    }
  }

  playUploadedFile() {
    if (startPlaying) {
      stopPlayer();
    } else {
      _mPlayer
          .startPlayer(
              fromURI: _audioPaths[_currentIndex].values.first.toString(),
              //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
              whenFinished: () {
                setState(() {});
              })
          .then((value) {
        setState(() {
          startPlaying = true;
        });
      });
    }
  }

  void stopPlayer() {
    _mPlayer.stopPlayer().then((value) {
      setState(() {
        startPlaying = false;
      });
    });
  }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder.isStopped) {
      return null;
    }
    return _mPlayer.isStopped ? play : stopPlayer;
  }

  @override
  build(BuildContext context) {
    makeBody() {
      return SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        Assets.backgroundCircleDots,
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.height / 8,
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    uploadBookFormatHeader(
                      '12/03/2023',
                      'Hi, Team',
                      'Welcome to your board',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        addNewBookWidget(context, Assets.subMenuRedBox,
                            MediaQuery.of(context).size.width * 0.90),
                        addNewBookWidget(context, Assets.subMenuRedText,
                            MediaQuery.of(context).size.width * 0.90),
                        addNewBookWidget(context, Assets.subMenuExit,
                            MediaQuery.of(context).size.width * 0.90),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 6,
                              child:
                                  Image.asset(Assets.backgroundRectangleDots),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  child: Image.asset(
                                      Assets.backgroundRectangleDots),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                uploadText(
                                  context: context,
                                  label: widget.flag == 'press continue'
                                      ? 'Book Preview'
                                      : title.toString(),
                                  fontSize: 20.0,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 2.5),
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ), //<-- SEE HERE
                                      ),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          child: Image.file(
                                            widget.images![_currentIndex],
                                            fit: BoxFit.cover,
                                          )),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 30),
                                      child: IconButton(
                                        onPressed: () {
                                          if (length - 1 > _currentIndex) {
                                            setState(() {
                                              _currentIndex++;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          Icons.arrow_right,
                                          size: 50,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.flag == 'audio' ||
                                widget.flag == 'recordnow')
                              InkWell(
                                child: Image.asset(
                                  Assets.audioUploadRedPreviousPage,
                                  height: 100,
                                  width: 100,
                                ),
                                onTap: () {
                                  if (_currentIndex > 0) {
                                    setState(() {
                                      _currentIndex--;
                                    });
                                  }
                                },
                              ),
                            SizedBox(
                              width: 10,
                            ),
                            if (widget.flag == 'audio')
                              InkWell(
                                child: Stack(
                                  children: [
                                    addNewBookWidget(
                                        context,
                                        Assets.directionalRedBox,
                                        MediaQuery.of(context).size.width *
                                            0.30),
                                    addNewBookWidget(
                                        context,
                                        Assets.standAloneRedAdd,
                                        MediaQuery.of(context).size.width *
                                            0.30),
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    uploadAudio();
                                  });
                                },
                              ),
                            if (widget.flag == 'recordnow')
                              InkWell(
                                child: Image.asset(
                                  Assets.audioUploadRedAudioIcon,
                                  height: 100,
                                  width: 100,
                                ),
                                onTap: () {
                                  print("Next Button");
                                },
                              ),
                            SizedBox(
                              width: 10,
                            ),
                            if (widget.flag == 'audio' ||
                                widget.flag == 'recordnow')
                              InkWell(
                                child: Image.asset(
                                  Assets.audioUploadRedNextPage,
                                  height: 100,
                                  width: 100,
                                ),
                                onTap: () {
                                  print("length :: $length");
                                  print("currentIndex :: $_currentIndex");
                                  if (length - 1 > _currentIndex) {
                                    setState(() {
                                      _currentIndex++;
                                    });
                                  }
                                },
                              )
                          ],
                        ),
                        if (widget.flag == 'audio')
                          Column(
                            children: [
                              uploadText(
                                context: context,
                                label: "ADD VOICE OVER FOR THIS PAGE.",
                                fontSize: 12.0,
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        if (widget.flag == 'recordnow' ||
                            widget.flag == 'audio')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  recordStop();
                                },
                                child: Image.asset(
                                  Assets.audioUploadRedPauseIcon,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  uploadAudioFile ? playUploadedFile() : play();
                                },
                                child: Image.asset(
                                  Assets.audioUploadRedPlayIcon,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  if (!recordingStart) {
                                    record();
                                  } else {
                                    recordStop();
                                  }
                                },
                                child: Image.asset(
                                  Assets.audioUploadRedUploadIcon,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: Stack(
                                children: [
                                  addNewBookWidget(
                                      context,
                                      Assets.directionalRedDropDownBox,
                                      MediaQuery.of(context).size.width * 0.30),
                                  addNewBookWidget(
                                      context,
                                      Assets.directionalRedBox,
                                      MediaQuery.of(context).size.width * 0.30),
                                  addNewBookWidget(
                                      context,
                                      Assets.directionalTextBack,
                                      MediaQuery.of(context).size.width * 0.30),
                                ],
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            InkWell(
                              child: Stack(
                                children: [
                                  addNewBookWidget(
                                    context,
                                    Assets.directionalRedDropDownBox,
                                    MediaQuery.of(context).size.width * 0.30,
                                  ),
                                  addNewBookWidget(
                                    context,
                                    Assets.directionalRedBox,
                                    MediaQuery.of(context).size.width * 0.30,
                                  ),
                                  addNewBookWidget(
                                    context,
                                    Assets.directionalTextContinue,
                                    MediaQuery.of(context).size.width * 0.30,
                                  ),
                                ],
                              ),
                              onTap: () {
                                if (widget.flag != 'press continue') {
                                  setState(() {
                                    widget.flag = widget.flag == 'continue'
                                        ? 'press continue'
                                        : 'continue';
                                    title = 'Book Preview';
                                  });
                                }

                                if (widget.flag == 'press continue') {
                                  // saveFile();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddAuthorDescription(
                                              images: widget.images,
                                              imagesPath: widget.imagesPath,
                                              audioPaths: _audioPaths,
                                              withAudio: withAudio,
                                            )
                                        /*AudioRecorder(*/ /*images: [imagePath],*/ /*),*/
                                        ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
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

      for (int i = 0; i < _audioPaths!.length; i++) {
        var childPath = _audioPaths![i].keys.first.path.toString().split('/');
        var storageReferencePageUrls = FirebaseStorage.instance
            .ref()
            .child('book_pages')
            .child(childPath[childPath.length - 1]);
        var upload =
            await storageReferencePageUrls.putFile(_audioPaths![i].keys.first);
        imageUrl = await upload.ref.getDownloadURL();

        var audioPath = _audioPaths![i].values.first.toString().split('/');
        var storageReference = FirebaseStorage.instance
            .ref()
            .child('audios')
            .child(audioPath[audioPath.length - 1]);
        var uploadTask =
            await storageReference.putFile(File(_audioPaths![i].values.first));
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
        "audio_Paging_time": _pageTime.values,
        "author_doc_id": "",
        "category_main": widget.category.toString(),
        "category_sub": widget.subCategory.toString(),
        "pages_url": imagesUrlArray,
        "title": widget.title.toString(),
        "topic": widget.topic.toString(),
      });
    } catch (e, stacktrace) {}
  }

  bool uploadAudioFile = false;

  uploadAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mp4'],
      allowMultiple: false,
    );

    PlatformFile file = result!.files.first;
    Directory tempDir = await getTemporaryDirectory();
    String dirPath = tempDir.path;
    // await loadPdf(file.path.toString(), dirPath + '/' + 'file_picker');

    setState(() {
      uploadAudioFile = true;
      withAudio = true;
      recordingStart = false;
      var imageVoicePair = {
        widget.images![_currentIndex]: file!.path.toString(),
      };
      _audioPaths[_currentIndex] = imageVoicePair;
      _mPath = imageVoicePair!;
      _mplaybackReady = true;
    });
  }
}
