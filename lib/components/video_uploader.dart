import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

enum ImageSourceType { gallery, camera }

class VideoUploader extends StatefulWidget {
  @override
  VideoUploaderState createState() => VideoUploaderState();
}

class VideoUploaderState extends State<VideoUploader> {
  final ImagePicker _picker = ImagePicker();
  File? _video;
  File? _cover;
  Uint8List? _thumbnail;

  void _addVideo(BuildContext context, var type) async {
    XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

    Uint8List? thumbnailData;
    if (video != null) {
      thumbnailData = await VideoThumbnail.thumbnailData(video: video!.path, maxWidth: 100, maxHeight: 100, quality: 10);
    }

    setState(() {
      if (video != null) {
        _video = File(video!.path);
        _thumbnail = thumbnailData;
      }
    });
  }

  void _addCover(BuildContext context, var type) async {

    // Delete the current photo if it exists
    if (_cover != null) {
      setState(() {
        _cover = null;
      });
      return;
    }

    XFile? cover = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (cover != null) {
        _cover = File(cover!.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
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
                  FilledButton(
                      onPressed: () async {
                        _addVideo(context, ImageSourceType.gallery);
                      },
                      child: Text("Choose video")),
                  Container(
                    padding: EdgeInsets.all(40),
                    child: _thumbnail != null ? Image.memory(_thumbnail!) : null,
                  )
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
                          child: TextFormField(
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
                          child: TextFormField(
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Video description',
                            ),
                          ))
                    ],
                  )),

              // Tags
              Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 100, child: Text("Tags:")),
                      SizedBox(
                          width: 200,
                          child: TextFormField(
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Start typing to add tags',
                            ),
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
                      IconButton(onPressed: () async {
                          _addCover(context, ImageSourceType.gallery);
                      },
                          icon: Icon(_cover == null ? Icons.add_a_photo_rounded : Icons.clear_rounded)),
                      SizedBox(
                          width: 70,
                          child: _cover != null ? Image.file(
                            _cover!,
                            width: 70,
                            height: 70,
                          ) : null,
                          )
                    ],
                  )),


              // Publish button
              FilledButton(
                  onPressed: () {},
                  child: Text("Publish"))
            ],
          ),
        ));
  }
}
