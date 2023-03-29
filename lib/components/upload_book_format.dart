import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:storily/components/page_uploader.dart';
import '../global/constants/assets.dart';
import 'common_upload_book_format.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_image_renderer/pdf_image_renderer.dart' as pdfRender;

enum ImageSourceType { gallery, camera }

class UploadBookFormat extends StatefulWidget {
  @override
  UploadBookFormatState createState() => UploadBookFormatState();
}

class UploadBookFormatState extends State<UploadBookFormat>
    with SingleTickerProviderStateMixin {
  static const int _initialPage = 2;
  int _actualPageNumber = _initialPage, _allPagesCount = 0;
  List imagesPath = [];
  var total = 0;
  var imagePicker;
  bool addFiles = false;
  bool addFilesForPDF = false;
  var images = <File>[];
  var pdf = pw.Document();

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

  late PdfControllerPinch _pdfController;

  fetch() async {}

  loadPdf(String path, var tempPath) async {
    var file = pdfRender.PdfImageRendererPdf(path: path);
    await file.open();
    var count = await file.getPageCount();

    for (var i = 0; i < count; i++) {
      try {
        var size = await file.getPageSize(pageIndex: i);
        var rawImage = await file.renderPage(
          x: 0,
          y: 0,
          width: size.width,
          height: size.height,
          scale: 1.0,
          pageIndex: i,
        );
        File tempFile = File('$tempPath/image$i.png');
        // var image = await tempFile.writeAsBytes(rawImage!., flush: true);

        var image = await tempFile.writeAsBytes(rawImage!.buffer
            .asUint8List(rawImage.offsetInBytes, rawImage.lengthInBytes));

        images.add(File(image.path));
        print("Images $images");
      } catch (e) {
        print("Exception e:::: $e");
      }
    }
    // return images;
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
                              textImageUrl: Assets.pdfTextImage,
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
                              textImageUrl: Assets.imageTextImage,
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

  var from;

  getEventList() async {
    if (addFiles) {
      setState(() {
        from = 'image';
        addFiles = false;
      });
    }
    if (addFilesForPDF) {
      setState(() {
        from = 'pdf';
        addFilesForPDF = false;
      });

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      PlatformFile file = result!.files.first;
      Directory tempDir = await getTemporaryDirectory();
      String dirPath = tempDir.path;
      await loadPdf(file.path.toString(), dirPath + '/' + 'file_picker');
    }



    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => PageUploader(path: images, from: from),
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
            imageHeight: MediaQuery.of(context).size.height * 0.06,
          ),
        ],
      ),
    );
  }
}
