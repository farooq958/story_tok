import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:record/record.dart';
import 'package:storily/components/congratulations.dart';
import '../../components/common_upload_book_format.dart';
import '../../global/constants/assets.dart';

const theSource = AudioSource.microphone;

class ConfirmBookDetails extends StatefulWidget {
  final images;
  final imagesPath;
  final coverImage;
  final title;
  final authorName;
  final bookDescription;
  final price;
  final topic;
  final bookGenre;

  const ConfirmBookDetails({
    Key? key,
    required this.images,
    required this.imagesPath,
    this.coverImage,
    this.title,
    this.authorName,
    this.bookDescription,
    this.price,
    this.topic,
    this.bookGenre,
  }) : super(key: key);

  @override
  ConfirmBookDetailsState createState() => ConfirmBookDetailsState();
}

class ConfirmBookDetailsState extends State<ConfirmBookDetails> {
  List imagesPath = [];
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  final _audioRecorder = Record();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();

  Stopwatch _timer = Stopwatch();
  File audioFile = File('');
  List<Map<File, String>> _imagesPath = [];
  int length = 0;
  var title = 'Please Confirm Details.';

  //slider
  Map<int, int> _pageTime = Map();
  late List<Widget> imageSliders;
  List<File>? cachedimages = <File>[];

  ConfirmBookDetailsState({this.cachedimages});

  @override
  void initState() {
    print(widget.images);
    print(widget.title);
    print(widget.price);
    print(widget.authorName);
    print(widget.topic);
    print(widget.bookGenre);
    print(widget.bookDescription);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget makeBody() {
      return SingleChildScrollView(
        child: Stack(
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
                          child: Image.asset(Assets.backgroundRectangleDots),
                        ),
                      ],
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
                        Column(
                          children: [
                            uploadText(
                              context: context,
                              label: title.toString(),
                              fontSize: 30.0,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2.5),
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ), //<-- SEE HERE
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(7.0),
                                      child: Image.file(
                                        widget.coverImage,
                                        fit: BoxFit.cover,
                                      )),
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2.5),
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ), //<-- SEE HERE
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    7,
                                                child: Text('Genres')),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                child: Text(widget.bookGenre)),
                                            SizedBox(
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    7,
                                                child: Text('Topics')),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                child: Text(widget.topic)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2.5),
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ), //<-- SEE HERE
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 5.0, right: 5.0),
                                            child: Text(
                                              widget.title,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  12,
                                              child: SingleChildScrollView(
                                                child: Text(
                                                  widget.bookDescription,
                                                  maxLines: 999999,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
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
                            setState(() {});
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CongratulationsScreen()
                                  /*AudioRecorder(*/ /*images: [imagePath],*/ /*),*/
                                  ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ],
            ),
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

      // widget.ref.set({
      //   "cover_url": widget.imageURL.toString(),
      //   // "audio_doc_id": audioURl,
      //   "audio_Paging_time": _pageTime.values,
      //   "author_doc_id": "",
      //   "category_main": widget.category.toString(),
      //   "category_sub": widget.subCategory.toString(),
      //   "pages_url": imagesUrlArray,
      //   "title": widget.title.toString(),
      //   "topic": widget.topic.toString(),
      // });

    } catch (e, stacktrace) {}
  }
}
