import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:storily/components/record_audio.dart';
import 'package:storily/global/constants/assets.dart';
import '../utils.dart';
import 'common_upload_book_format.dart';

enum ImageSourceType { gallery, camera }

class PageUploader extends StatefulWidget {
  final path;
  final from;

  const PageUploader({Key? key, required this.path, required this.from})
      : super(key: key);

  @override
  PageUploaderState createState() => PageUploaderState();
}

class PageUploaderState extends State<PageUploader> {
  var _images = <File>[];
  List imagesPath = [];
  var total = 0;
  var imagePicker;
  List<bool> _selected = [];

  _addImage(BuildContext context, var type, int index) async {
    await _handleURLButtonPress(context, type, total, 'addMethod');
  }

  _handleURLButtonPress(
      BuildContext context, var type, var i, String verifyText) async {
    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    XFile image = await imagePicker.pickImage(
      source: source,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.front,
    );

    bool imageExist = false;
    if (_images.length > 0) {
      for (int i = 0; i < _images.length; i++) {
        if (_images[i].path == image.path) {
          setState(() {
            imageExist = true;
          });
          Utils().showToastMessage(
            "You can't choose the same image.",
            context,
          );
          break;
        }
      }
    }

    if (!imageExist) {
      setState(() {
        _images.add(File(''));
        imagesPath.add(image.path);
        _images[i] = File(image.path);
      });
    }

    if (!imageExist && verifyText == "addMethod") {
      total++;
      _selected.add(false);
    }
  }

  List selectedImages = [];

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
    if (widget.from == 'pdf') {
      setState(() {
        _images.addAll(widget.path);
        total = _images.length;
        _selected.addAll(List.filled(total, false));
      });
    }
    initBgMusic();
  }

  initBgMusic() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.delete(key: 'bg_music');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            backgrondSquareMethod(context),
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
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Image.asset(Assets.backgroundRectangleDots),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            uploadText(
                                context: context,
                                label: "Current Pages: $total",
                                fontSize: 20.0),
                            InkWell(
                              onTap: () {
                                for (int i = 0;
                                    i < selectedImages.length;
                                    i++) {
                                  setState(() {
                                    _images.removeAt(selectedImages[i]);
                                    total--;
                                  });
                                }

                                _selected
                                    .removeWhere((element) => element == true);
                                selectedImages.clear();
                              },
                              child: Stack(
                                children: [
                                  commonAddBookWidget(
                                      context,
                                      Assets.editPagesRedBox,
                                      MediaQuery.of(context).size.width * 0.30),
                                  commonAddBookWidget(
                                      context,
                                      Assets.editPagesRedDeleteText,
                                      MediaQuery.of(context).size.width * 0.30),
                                  commonAddBookWidget(
                                      context,
                                      Assets.editPagesRedAdd,
                                      MediaQuery.of(context).size.width * 0.30),
                                  commonAddBookWidget(
                                      context,
                                      Assets.editPagesRedMinus,
                                      MediaQuery.of(context).size.width * 0.30),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30, top: 40),
                          child: Expanded(
                            flex: 9,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 2.15,
                              child: GridView.count(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                crossAxisCount: 3,
                                children: List.generate(
                                  widget.from == 'pdf' ? total : total + 1,
                                  (index) {
                                    if (index == total) {
                                      return Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              await _addImage(
                                                  context,
                                                  ImageSourceType.gallery,
                                                  index);
                                            },
                                            child: Image.asset(
                                                'assets/images/pagepreview_red_page.png'),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              await _handleURLButtonPress(
                                                  context,
                                                  ImageSourceType.gallery,
                                                  index,
                                                  'buttonPress');
                                            },
                                            child: Container(
                                              child: _images[index] != null
                                                  ? SelectableContainer(
                                                      unselectedBackgroundColor:
                                                          Colors.transparent,
                                                      unselectedBorderColor:
                                                          Colors.transparent,
                                                      selectedBorderColor:
                                                          Colors.transparent,
                                                      unselectedOpacity: 1.0,
                                                      selected:
                                                          _selected[index],
                                                      // selectedValues[index],
                                                      onValueChanged: (value) {
                                                        try {
                                                          setState(() {
                                                            _selected[index] =
                                                                value;
                                                            if (!selectedImages
                                                                .contains(
                                                                    index)) {
                                                              selectedImages
                                                                  .add(index);
                                                            }
                                                          });
                                                        } catch (e, stacktrace) {
                                                          print(stacktrace);
                                                        }
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 10),
                                                        height: 120,
                                                        width: 75,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 2.5),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  8.0), //<-- SEE HERE
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      7.0),
                                                          child: Image.file(
                                                            _images[index],
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 140,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 5,
                                                        ),
                                                      ),
                                                      child: Image.asset(
                                                          'assets/images/pagepreview_red_page.png'),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
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
                                      MediaQuery.of(context).size.width * 0.30),
                                  commonAddBookWidget(
                                      context,
                                      Assets.directionalRedBox,
                                      MediaQuery.of(context).size.width * 0.30),
                                  commonAddBookWidget(
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
                              onTap: () {
                                if (_images.length < 1) {
                                  Utils().showToastMessage(
                                      "Book has at least 4 pages.", context);
                                } else {

                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => RecordAudio(
                                        imagesPath: imagesPath,
                                        images: _images,
                                      ),
                                      transitionDuration: Duration(milliseconds: 700),
                                      transitionsBuilder: (_, a, __, c) =>
                                          FadeTransition(opacity: a, child: c),
                                    ),
                                  );


                                }
                              },
                              child: Stack(
                                children: [
                                  commonAddBookWidget(
                                      context,
                                      Assets.directionalRedDropDownBox,
                                      MediaQuery.of(context).size.width * 0.30),
                                  commonAddBookWidget(
                                      context,
                                      Assets.directionalRedBox,
                                      MediaQuery.of(context).size.width * 0.30),
                                  commonAddBookWidget(
                                      context,
                                      Assets.directionalTextContinue,
                                      MediaQuery.of(context).size.width * 0.30),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),

                    /*Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VoiceRecorder(
                                        _images,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  // margin: EdgeInsets.fromLTRB(50.0, 0.0, 90.0, 0.0),
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
                                        "RECORD STORIES",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  if (_images.length < 4) {
                                    Utils().showToastMessage(
                                        "Book has at least 4 pages.", context);
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddAuthorDescription(
                                            imagesPath: imagesPath,
                                            images: _images),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  child: Text(
                                    "Done",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),*/
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
