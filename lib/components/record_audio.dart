import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../global/constants/assets.dart';
import '../screens/book_upload/book-preview-screen.dart';
import 'common_upload_book_format.dart';

class RecordAudio extends StatefulWidget {
  final images;
  final imagesPath;

  const RecordAudio({Key? key, required this.images, this.imagesPath})
      : super(key: key);

  @override
  RecordAudioState createState() => RecordAudioState();
}

class RecordAudioState extends State<RecordAudio>
    with SingleTickerProviderStateMixin {
  List imagesPath = [];
  var total = 0;
  var imagePicker;
  bool addFiles = false;
  bool addFilesForPDF = false;
  bool continueWithoutAudio = false;
  late double _scale;
  late AnimationController _controller;

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
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
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
                        label: "Add a Voice Over?",
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
                              textImageUrl: Assets.uploadRedTextRecordNow,
                              boxImageUrl: Assets.uploadRedBox,
                              addFilesImageUrl: Assets.redAddFiles,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              addFilesForPDF = true;
                            });
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
                              textImageUrl: Assets.uploadRedTextAudio,
                              boxImageUrl: Assets.uploadRedBox,
                              addFilesImageUrl: Assets.redAddFiles,
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
            SizedBox(height: 30),
            GestureDetector(
              onTapDown: _tapDown,
              onTapUp: _tapUp,
              child: Transform.scale(
                scale: _scale,
                child: Stack(
                  children: [
                    if (!continueWithoutAudio)
                      Container(
                        child: commonAddBookWidget(
                            context,
                            Assets.directionalRedBoxDropdownLong,
                            MediaQuery.of(context).size.width * 0.90),
                      ),
                    commonAddBookWidget(context, Assets.directionalRedBoxLong,
                        MediaQuery.of(context).size.width * 0.90),
                    commonAddBookWidget(
                        context,
                        Assets.directionalTextWithoutAudio,
                        MediaQuery.of(context).size.width * 0.90),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  continueWithoutAudio = true;
                });
              },
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
    if (addFilesForPDF) {
      setState(() {
        addFilesForPDF = false;
      });
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                VoiceRecorder(widget.images, widget.imagesPath, 'recordnow'),
            transitionDuration: Duration(milliseconds: 700),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          ),
        );
      });
    }
    if (addFiles) {
      setState(() {
        addFiles = false;
      });
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                VoiceRecorder(widget.images, widget.imagesPath, 'audio'),
            transitionDuration: Duration(milliseconds: 700),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          ),
        );
      });
    }
    if (continueWithoutAudio) {
      setState(() {
        continueWithoutAudio = false;
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) =>
                  VoiceRecorder(widget.images, widget.imagesPath, 'press continue'),
              transitionDuration: Duration(milliseconds: 700),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            ),
          );
        });
      });
    }
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
}
