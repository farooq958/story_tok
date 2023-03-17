import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storily/components/page_uploader.dart';
import '../global/constants/assets.dart';
import 'common_upload_book_format.dart';

class RecordAudio extends StatefulWidget {
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
                        label: "Please Select Upload Format",
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
                        child: addNewBookWidget(
                            context,
                            Assets.directionalRedBoxDropdownLong,
                            MediaQuery.of(context).size.width * 0.90),
                      ),
                    addNewBookWidget(context, Assets.directionalRedBoxLong,
                        MediaQuery.of(context).size.width * 0.90),
                    addNewBookWidget(
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
    if (addFiles) {
      setState(() {
        addFiles = false;
      });
      // Future.delayed(Duration(milliseconds: 500), () {
      //   Navigator.push(
      //     context,
      //     PageRouteBuilder(
      //       pageBuilder: (_, __, ___) => PageUploader(),
      //       transitionDuration: Duration(milliseconds: 700),
      //       transitionsBuilder: (_, a, __, c) =>
      //           FadeTransition(opacity: a, child: c),
      //     ),
      //   );
      // });
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
