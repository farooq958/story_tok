import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class VideoUpload {
  var isUploading = false;
  final storageRef = FirebaseStorage.instance.ref();
  final fireStoreRef = FirebaseFirestore.instance.collection("Videos");
  var uuid = Uuid();

  String user;

  File? video;
  File? cover;

  String? videoTitle;
  String? videoDescription;
  List<String>? tags = ['tag1', 'tag2', 'tag3'];

  VideoUpload(this.user);

  Future<bool> publish() async {

    var videoRef = storageRef.child("videos").child(uuid.v1());
    await videoRef.putFile(video!);

    var coverRef = storageRef..child("video_covers").child(uuid.v1());
    await coverRef.putFile(video!);

    this.isUploading = true;
    return fireStoreRef.add({
      "video_title": this.videoTitle,
      "video_description": this.videoDescription,
      "tags": this.tags,
      "url": await videoRef.getDownloadURL(),
      "coverUrl": await coverRef.getDownloadURL()
    })
        .then((v) {this.isUploading = false; return true;})
        .catchError((error) {this.isUploading = false; return false;});
  }
}