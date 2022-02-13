import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum ImageSourceType { gallery, camera }

class VoiceRecorder extends StatefulWidget {


  @override
  VoiceRecorderState createState() => VoiceRecorderState();
}

class VoiceRecorderState extends State<VoiceRecorder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Record Your Book"),
      ),
    );
  }
}