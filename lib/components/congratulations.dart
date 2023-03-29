import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:record/record.dart';
import '../../global/constants/assets.dart';

const theSource = AudioSource.microphone;

class CongratulationsScreen extends StatefulWidget {
  @override
  CongratulationsScreenState createState() => CongratulationsScreenState();
}

class CongratulationsScreenState extends State<CongratulationsScreen> {
  List imagesPath = [];
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  final _audioRecorder = Record();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();

  Stopwatch _timer = Stopwatch();
  File audioFile = File('');
  List<Map<File, String>> _imagesPath = [];
  int length = 0;
  var title = 'Please Confirm Details.';
  String bookReviewInfo = '';

  //slider
  Map<int, int> _pageTime = Map();
  late List<Widget> imageSliders;
  List<File>? cachedimages = <File>[];

  CongratulationsScreenState({this.cachedimages});

  @override
  void initState() {
    super.initState();
    getTextFromFirebase();
  }

  getTextFromFirebase() {
    FirebaseFirestore.instance
        .collection('in_game_conditions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          bookReviewInfo = doc.get('book_review_Info').toString();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Confirmation Screen'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Image.asset(
                Assets.bookUploadRedIcon2,
                width: MediaQuery.of(context).size.width / 2,
              ),
              Image.asset(Assets.bookUploadRedIconCongratulations),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text(
                  "Thank you for submitting your book to Bitread!",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text(
                  bookReviewInfo,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                Assets.bookUploadRedIcon1,
                width: MediaQuery.of(context).size.width / 1.2,
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                Assets.standaloneGreenFinish,
                width: MediaQuery.of(context).size.width / 2,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
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
    } catch (e, stacktrace) {}
  }
}
