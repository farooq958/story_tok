import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storily/components/voice_recording.dart';

import '../utils.dart';

enum ImageSourceType { gallery, camera }

class AddAuthorDescription extends StatefulWidget {
  final List<File> images;
  final imagesPath;

  const AddAuthorDescription({Key? key, required this.images, this.imagesPath})
      : super(key: key);

  @override
  AddAuthorDescriptionState createState() => AddAuthorDescriptionState();
}

class AddAuthorDescriptionState extends State<AddAuthorDescription> {
  IconData icon = Icons.add;
  String categoryValue = 'Traditional Genre';
  String subCategoryValue = 'Myths';
  String readingLevelValue = 'Kindergarten: 0.1 - 0.9';
  var data = [];
  List<String> category = [];

  List<String> subCategory = [];

  List<String> readingLevel = [
    'Kindergarten: 0.1 - 0.9',
    '1st Grade: 1.0 - 1.9',
    '2nd Grade: 2.0 - 2.9',
    '3rd Grade: 3.0 - 3.9',
    '4th Grade: 4.0 - 4.9',
    '5th Grade: 5.0 - 5.9',
    '6th Grade: 6.0 - 6.9'
  ];

  final recorder = FlutterSoundRecorder();
  final player = FlutterSoundPlayer();
  var fileName;

  var traditionalData;
  var realisticData;
  var poetryData;
  var pictureData;
  var nonFictionData;
  var historicalFictionGenresData;
  var fantasyData;

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  var imagePath;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _tagController = TextEditingController();

  //initstate
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCollection("categories");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Description'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              textContainer('Title', _titleController),
              SizedBox(
                height: 20.0,
              ),
              textContainer('Description', _descriptionController),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  children: [
                    Text("Cover"),
                    if (image != null)
                      Container(
                        height: 90,
                        width: 90,
                        child: Image.file(imagePath),
                      ),
                    iconButton(icon),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              textContainer('Topic', _tagController),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 40.0, right: 40.0),
                child: Row(
                  children: [
                    Text("Category"),
                    SizedBox(
                      width: 15.0,
                    ),
                    DropdownButton(
                      value: categoryValue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: category.map((String items) {
                        return DropdownMenuItem(
                            value: items,
                            child: Container(
                              width: 80.0,
                              child: Text(
                                items,
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          categoryValue = newValue!;
                          subCategoryValue = data[category.indexOf(newValue)]
                              [categoryValue][0];
                          subCategory =
                              data[category.indexOf(newValue)][categoryValue];
                        });
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      child: DropdownButton(
                        value: subCategoryValue,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: subCategory.map((String items) {
                          return DropdownMenuItem(
                              value: items,
                              child: Container(
                                width: 120.0,
                                child: Text(
                                  items,
                                  style: TextStyle(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            subCategoryValue = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 40.0, right: 40.0),
                child: Row(
                  children: [
                    Text("Reading Level"),
                    SizedBox(
                      width: 15.0,
                    ),
                    DropdownButton(
                      value: readingLevelValue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: readingLevel.map((String items) {
                        return DropdownMenuItem(
                            value: items,
                            child: Container(
                              width: 150.0,
                              child: Text(
                                items.toString(),
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          readingLevelValue = newValue.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    onPressed: () {
                      if (imagePath != null) {
                        // Record the screen
                        DocumentReference sightingRef = FirebaseFirestore
                            .instance
                            .collection('booksentity')
                            .doc();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VoiceRecorder(
                                    widget.images,
                                sightingRef,
                                    [imagePath],
                                    categoryValue.toString(),
                                    subCategoryValue.toString(),
                                    _titleController.text.toString(),
                                    _tagController.text.toString(),
                                  )
                              /*AudioRecorder(*/ /*images: [imagePath],*/ /*),*/
                              ),
                        );
                      } else {
                        Utils().showToastMessage(
                            "Please select cover image.", context);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Text(
                        "Record",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      // Publish the book
                      saveImages(imagePath, sightingRef);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Text(
                        "Publish",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  textContainer(String label, TextEditingController _controller) {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  iconButton(IconData icon) {
    return IconButton(
        onPressed: () {
          _addImage();
        },
        icon: Icon(icon));
  }

  void _addImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      icon = Icons.refresh;
      imagePath = File(image!.path);
    });
  }

  getCollection(String collectionName) {
    var collection = FirebaseFirestore.instance.collection("categories");
    FirebaseFirestore.instance
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          category.add(doc["name"].toString());
          List list = doc["subcategories"];
          data.add({doc["name"]: list.cast<String>()});
        });
      });
      subCategory = data[0][category[0]];
      subCategoryValue = data[0][category[0]][0];
    });
    return collection;
  }

  DocumentReference sightingRef =
      FirebaseFirestore.instance.collection('booksentity').doc();

  Future<void> saveImages(File _image, DocumentReference ref) async {
    var imagesUrlArray = [];
    var imageUrl = "";
    var storageReferencePageUrls =
        FirebaseStorage.instance.ref().child('pageUrls/$_image');

    for (int i = 0; i < widget.imagesPath.length; i++) {
      var upload = await storageReferencePageUrls.putString(widget.imagesPath[i]);
      imageUrl = await upload.ref.getDownloadURL();
      imagesUrlArray.add(imageUrl);
    }

    var storageReference =
        FirebaseStorage.instance.ref().child('images/$_image');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.then((res) {
      storageReference.getDownloadURL().then((imageURL) {
        ref.set({
          "cover_url": imageURL,
          "audio_doc_id": "",
          "author_doc_id": "",
          "category_main": categoryValue.toString(),
          "category_sub": subCategoryValue.toString(),
          "pages_url": imagesUrlArray,
          "title": _titleController.text.toString(),
          "topic": _tagController.text.toString(),
        });
      });
    });
  }
}
