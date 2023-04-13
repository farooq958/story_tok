import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:audio_session/audio_session.dart';
import 'package:record/record.dart';
import 'package:storily/components/add_author_description.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../components/common_upload_book_format.dart';
import '../../global/constants/assets.dart';

typedef _Fn = void Function();

const theSource = AudioSource.microphone;

class VoiceRecorder extends StatefulWidget {
  final manageFlagList;
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
      this.manageFlagList,
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

class VoiceRecorderState extends State<VoiceRecorder>
    with SingleTickerProviderStateMixin {
  double _value = 20;

  List imagesPath = [];
  bool recordingStart = false;
  bool withAudio = false;

  //recorder
  Codec _codec = Codec.aacMP4;
  var _mPath;
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  FlutterSoundPlayer _bgPlayer = FlutterSoundPlayer();
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
  late AnimationController _animationController;
  var manageFlagList = [];
  var title = 'Audio Recording';

  Map<int, int> _pageTime = Map();
  List<File>? cachedimages = <File>[];

  VoiceRecorderState({this.cachedimages});

  @override
  void initState() {
    if(widget.manageFlagList.length > 0) {
      manageFlagList = widget.manageFlagList;
    }else{
      manageFlagList.add(widget.flag);
    }

    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
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

  var bgMusic;

  playAutoBgAudio() async {
    print("heloooo : ${widget.flag}");
    FlutterSecureStorage storage = FlutterSecureStorage();
    bgMusic = await storage.read(key: 'bg_music');

    if (bgMusic != null) {
      _bgPlayer.openPlayer();
      _bgPlayer.setVolume(_value);
      _bgPlayer.startPlayer(
          fromURI: bgMusic.toString(),
          whenFinished: () {
            setState(() {
              playAutoBgAudio();
            });
          });
    }
  }

  @override
  void dispose() {
    _mPlayer.stopPlayer();
    _bgPlayer.stopPlayer();
    _mPlayer.closePlayer();
    _bgPlayer.closePlayer();
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
    try {
      _audioRecorder.start().then((value) {
        setState(() {
          recordingStart = true;
          _timer.start();
        });
      });
    } catch (e) {
      print(e);
    }
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

  playAutoAudio() async {
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

  stopBgMusic() {
    try {
      _bgPlayer.closePlayer().then((value) {
        _mPlayer.closePlayer();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddAuthorDescription(
                    images: widget.images,
                    imagesPath: widget.imagesPath,
                    audioPaths: _audioPaths,
                    withAudio: withAudio,
                manageFlagList: manageFlagList,
                  )
              /*AudioRecorder(*/ /*images: [imagePath],*/ /*),*/
              ),
        );
      });
      stopPlayer();
    } catch (e, stacktrace) {
      print("Exception: $stacktrace");
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
      return Stack(
        children: [
          backgroundSquare(context),
          SingleChildScrollView(
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
                            commonAddBookWidget(context, Assets.subMenuRedBox,
                                MediaQuery.of(context).size.width * 0.90),
                            commonAddBookWidget(context, Assets.subMenuRedText,
                                MediaQuery.of(context).size.width * 0.90),
                            commonAddBookWidget(context, Assets.subMenuExit,
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
                                  child: Image.asset(
                                      Assets.backgroundRectangleDots),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                        ),
                                        // add volume here
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
                            if (bgMusic != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('BG Volume'),
                                  SfSlider(
                                    activeColor: Color(0xffEF706C),
                                    min: 0.0,
                                    max: 100.0,
                                    value: _value,
                                    interval: 20,
                                    showTicks: true,
                                    showLabels: true,
                                    enableTooltip: true,
                                    minorTicksPerInterval: 1,
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        _value = value;
                                        _bgPlayer.setVolume(_value / 100);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // if (widget.flag == 'audio' ||
                                //     widget.flag == 'recordnow')
                                if (_currentIndex != 0)
                                  InkWell(
                                    child: Image.asset(
                                      Assets.audioUploadRedPreviousPage,
                                      height: 100,
                                      width: 100,
                                    ),
                                    onTap: () {
                                      if (_currentIndex > 0) {
                                        stopPlayer();
                                        setState(() {
                                          _currentIndex--;
                                        });
                                        if (widget.flag == 'continue') {
                                          playAutoAudio();
                                        }
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
                                        commonAddBookWidget(
                                            context,
                                            Assets.directionalRedBox,
                                            MediaQuery.of(context).size.width *
                                                0.30),
                                        commonAddBookWidget(
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
                                  startPlaying
                                      ? InkWell(
                                          child: Image.asset(
                                            Assets.audioUploadRedAudioIcon,
                                            height: 100,
                                            width: 100,
                                            opacity: _animationController,
                                          ),
                                          onTap: () {},
                                        )
                                      : InkWell(
                                          child: Image.asset(
                                            Assets.audioUploadRedAudioIcon,
                                            height: 100,
                                            width: 100,
                                          ),
                                          onTap: () {},
                                        ),
                                SizedBox(
                                  width: 10,
                                ),
                                // if (widget.flag == 'audio' ||
                                //     widget.flag == 'recordnow')
                                if (length - 1 > _currentIndex)
                                  InkWell(
                                    child: Image.asset(
                                      Assets.audioUploadRedNextPage,
                                      height: 100,
                                      width: 100,
                                    ),
                                    onTap: () {
                                      stopPlayer();
                                      if (length - 1 > _currentIndex) {
                                        setState(() {
                                          _currentIndex++;
                                        });
                                        print(widget.flag);
                                        if (widget.flag == 'continue') {
                                          playAutoAudio();
                                        }
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (widget.flag == 'recordnow')
                                    InkWell(
                                      onTap: () {
                                        if (!recordingStart) {
                                          record();
                                        } else {
                                          recordStop();
                                        }
                                      },
                                      child: Image.asset(
                                        !recordingStart
                                            ? Assets.audioUploadRedUploadIcon
                                            : Assets.audioUploadRedPauseIcon,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  /*InkWell(
                                    onTap: () {
                                      recordStop();
                                    },
                                    child: Image.asset(
                                      Assets.audioUploadRedPauseIcon,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),*/
                                  if (widget.flag == 'recordnow')
                                    SizedBox(
                                      height: 10,
                                    ),
                                  // if (widget.flag == 'recordnow')
                                  InkWell(
                                      onTap: () {
                                        uploadAudioFile
                                            ? playUploadedFile()
                                            : play();
                                      },
                                      child: Container(
                                          height: 40,
                                          width: 180,
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                Assets
                                                    .directionalRedDropDownBox,
                                                height: 40,
                                              ),
                                              Center(
                                                child: Text(
                                                  "Play Recording",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          )) /*Image.asset(
                                      Assets.audioUploadRedPlayIcon,
                                      height: 20,
                                      width: 20,
                                    ),*/
                                      ),
                                  if (widget.flag == 'recordnow')
                                    SizedBox(
                                      width: 10,
                                    ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  child: Stack(
                                    children: [
                                      commonAddBookWidget(
                                          context,
                                          Assets.directionalRedDropDownBox,
                                          MediaQuery.of(context).size.width *
                                              0.30),
                                      commonAddBookWidget(
                                          context,
                                          Assets.directionalRedBox,
                                          MediaQuery.of(context).size.width *
                                              0.30),
                                      commonAddBookWidget(
                                          context,
                                          Assets.directionalTextBack,
                                          MediaQuery.of(context).size.width *
                                              0.30),
                                    ],
                                  ),
                                  onTap: () {
                                    print(manageFlagList);
                                    if (manageFlagList.last == 'continue') {
                                      manageFlagList.removeLast();
                                      _bgPlayer.closePlayer();
                                      setState(() {
                                        widget.flag = manageFlagList.last;
                                      });
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                                InkWell(
                                  child: Stack(
                                    children: [
                                      commonAddBookWidget(
                                        context,
                                        Assets.directionalRedDropDownBox,
                                        MediaQuery.of(context).size.width *
                                            0.30,
                                      ),
                                      commonAddBookWidget(
                                        context,
                                        Assets.directionalRedBox,
                                        MediaQuery.of(context).size.width *
                                            0.30,
                                      ),
                                      commonAddBookWidget(
                                        context,
                                        Assets.directionalTextContinue,
                                        MediaQuery.of(context).size.width *
                                            0.30,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    print(
                                        "on continue button : ${widget.flag}");
                                    if (widget.flag != 'press continue') {
                                      setState(() {
                                        _currentIndex = 0;
                                        widget.flag = widget.flag == 'continue'
                                            ? 'press continue'
                                            : 'continue';
                                        title = 'Book Preview';
                                        manageFlagList.add(widget.flag);
                                      });
                                      playAutoAudio();
                                      playAutoBgAudio();
                                    }

                                    if (widget.flag == 'press continue') {
                                      manageFlagList.removeLast();
                                      stopBgMusic();
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Record your book'),
      ),
      body: makeBody(),
    );
  }

  bool uploadAudioFile = false;

  uploadAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mp4', '.wav', '.m4a'],
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
