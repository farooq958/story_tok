import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storily/models/video_upload.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

enum ImageSourceType { gallery, camera }

class VideoUploader extends StatefulWidget {
  @override
  VideoUploaderState createState() => VideoUploaderState();
}

class VideoUploaderState extends State<VideoUploader> {
  final ImagePicker _picker = ImagePicker();
  final VideoUpload _videoUpload = VideoUpload();
  final _videoDescriptionController = TextEditingController();
  final _videoTitleController = TextEditingController();

  var isUploading = false;
  bool? validInput;
  List<DropDownValueModel> topicsList = [];
  Uint8List? _thumbnail;

  void _addVideo(BuildContext context, var type) async {
    XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

    Uint8List? thumbnailData;
    if (video != null) {
      thumbnailData = await VideoThumbnail.thumbnailData(
          video: video!.path, maxWidth: 100, maxHeight: 100, quality: 10);
    }

    setState(() {
      if (video != null) {
        _videoUpload.video = File(video!.path);
        _thumbnail = thumbnailData;
      }
    });
  }

  void _addCover(BuildContext context, var type) async {
    if (_videoUpload.cover != null) {
      setState(() {
        _videoUpload.cover = null;
      });
      return;
    }
    XFile? cover = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (cover != null) {
        setState(() {
          _videoUpload.cover = File(cover!.path);
        });
      }
    });
  }

  Future<void> _publish() async {
    setState(() {
      isUploading = true;
    });

    if (await _videoUpload.publish()) {
      print("Published video");
      Navigator.pop(
          context); // TODO: should probably show user confirmation of successful upload
    } else {
      print("Error publishing video");
      setState(() {
        isUploading = false;
      });
    }
  }

  List<DropDownValueModel> getTopics() {
    List<DropDownValueModel> res = [];

    FirebaseFirestore.instance
        .collection("categories")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        res.add(DropDownValueModel(name: doc['name'], value: doc['name']));
      });
    });

    return res;
  }

  @override
  void initState() {
    super.initState();
    this.topicsList = getTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pick video"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // FilledButton(
                  //     onPressed: () async {
                  //       _addVideo(context, ImageSourceType.gallery);
                  //     },
                  //     child: Text("Choose video")),
                  // Container(
                  //   padding: EdgeInsets.all(40),
                  //   child: _thumbnail != null ? Image.memory(_thumbnail!) : null,
                  // )
                ],
              ),

              // Title
              Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text("Title:"),
                      ),
                      SizedBox(
                          width: 200,
                          child: TextField(
                            onChanged: (text) {
                              _videoUpload.videoTitle = text;
                            },
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Video title',
                            ),
                          ))
                    ],
                  )),

              // Description
              Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text("Description:"),
                      ),
                      SizedBox(
                          width: 200,
                          child: TextField(
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Video description',
                            ),
                            onChanged: (text) {
                              _videoUpload.videoDescription = text;
                            },
                          ))
                    ],
                  )),

              // Tags
              Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 100, child: Text("Topic:")),
                      SizedBox(
                          width: 200,
                          child: DropDownTextField(
                            dropDownList: this.topicsList,
                            enableSearch: true,
                            onChanged: (val) {
                              _videoUpload.videoTopic = val;
                            },
                          ))
                    ],
                  )),

              // Cover
              Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 100, child: Text("Cover:")),
                      IconButton(
                          onPressed: () async {
                            _addCover(context, ImageSourceType.gallery);
                          },
                          icon: Icon(_videoUpload.cover == null
                              ? Icons.add_a_photo_rounded
                              : Icons.clear_rounded)),
                      SizedBox(
                        width: 70,
                        child: _videoUpload.cover != null
                            ? Image.file(
                                _videoUpload.cover!,
                                width: 70,
                                height: 70,
                              )
                            : null,
                      )
                    ],
                  )),

              // Publish button
              // FilledButton(
              //     onPressed: isUploading ? () {print("uploading already in progress.");} : () {_publish();},
              //     child: isUploading ? Text("Uploading...") : Text("Publish")
              // )
            ],
          ),
        ));
  }
}
