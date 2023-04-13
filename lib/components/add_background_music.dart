import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:storily/components/record_audio.dart';
import '../global/constants/assets.dart';
import 'common_upload_book_format.dart';

class AddBackgroundMusic extends StatefulWidget {
  final images;
  final imagesPath;

  const AddBackgroundMusic({Key? key, required this.images, this.imagesPath})
      : super(key: key);

  @override
  AddBackgroundMusicState createState() => AddBackgroundMusicState();
}

class AddBackgroundMusicState extends State<AddBackgroundMusic>
    with SingleTickerProviderStateMixin {
  List imagesPath = [];
  var total = 0;
  var imagePicker;
  bool addFiles = false;
  bool addFilesForPDF = false;
  bool continueWithoutAudio = false;
  late double _scale;
  late AnimationController _controller;
  bool uploadAudioFile = false;
  bool recordingStart = false;
  bool withAudio = false;

  //recorder
  Stopwatch _timer = Stopwatch();
  File audioFile = File('');
  List<Map<File, String>> _audioPaths =
      []; //page as key and path for audio as value
  int _currentIndex = 0;
  int length = 0;
  var title = 'Audio Recording';

  Map<int, int> _pageTime = Map();
  List<File>? cachedimages = <File>[];

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1000,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
    imagePicker = new ImagePicker();
    initBgMusic();
  }

  initBgMusic() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.delete(key: 'bg_music');
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Stack(
          children: [
            backgroundSquare(context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Image.asset(Assets.backgroundRectangleDots),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        uploadText(
                            context: context,
                            label: "Add Background Music?",
                            fontSize: 30.0),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTapDown: _tapDown,
                              onTapUp: _tapUp,
                              child: Transform.scale(
                                scale: _scale,
                                child: _animatedButton(
                                  boolVal: addFilesForPDF,
                                  imageUrl: Assets.redDropShadow,
                                  context: context,
                                  textImageUrl: Assets.audioUploadRedMusic,
                                  boxImageUrl: Assets.uploadRedBox,
                                  addFilesImageUrl: '',
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  addFilesForPDF = true;
                                });
                                uploadAudio();
                              },
                            ),
                            GestureDetector(
                              onTapDown: _tapDown,
                              onTapUp: _tapUp,
                              child: Transform.scale(
                                scale: _scale,
                                child: _animatedButton(
                                  boolVal: addFiles,
                                  imageUrl: Assets.redDropShadow,
                                  context: context,
                                  textImageUrl: Assets.audioUploadRedNoMusic,
                                  boxImageUrl: Assets.uploadRedBox,
                                  addFilesImageUrl: '',
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  addFiles = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) async {
    await _controller.reverse();
    getEventList();
  }

  getEventList() {
    if (addFiles) {
      setState(() {
        addFiles = false;
      });
    }
    if (addFilesForPDF) {
      setState(() {
        addFilesForPDF = false;
      });
    }
    if (continueWithoutAudio) {
      setState(() {
        continueWithoutAudio = false;
      });
    }

    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => RecordAudio(
            imagesPath: widget.imagesPath,
            images: widget.images,
          ),
          transitionDuration: Duration(milliseconds: 700),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      );
    });
  }

  _animatedButton(
      {boolVal,
      imageUrl,
      context,
      boxImageUrl,
      textImageUrl,
      addFilesImageUrl}) {
    return Container(
      decoration: boxDecoration(),
      child: Stack(
        children: [
          if (!boolVal)
            dropShadowWidget(
              imageUrl: imageUrl,
              context: context,
            ),
          addFilesWidget(
            boxImageUrl: boxImageUrl,
            textImageUrl: textImageUrl,
            context: context,
            addFilesImageUrl: addFilesImageUrl,
            imageHeight: MediaQuery.of(context).size.height * 0.10,
          ),
        ],
      ),
    );
  }

  var bgAudioPath;
  uploadAudio() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
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
      bgAudioPath = file!.path.toString();
    });

    await storage.write(key: 'bg_music', value: bgAudioPath);
  }
}
