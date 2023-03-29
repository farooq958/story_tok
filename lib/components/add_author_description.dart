import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storily/components/confirm_book_details.dart';
import 'package:storily/components/voice_recording.dart';
import '../global/constants/assets.dart';
import 'common_upload_book_format.dart';

enum ImageSourceType { gallery, camera }

class AddAuthorDescription extends StatefulWidget {
  final images;
  final imagesPath;
  final audioPaths;
  final withAudio;

  const AddAuthorDescription({
    Key? key,
    required this.images,
    this.imagesPath,
    this.audioPaths,
    this.withAudio,
  }) : super(key: key);

  @override
  AddAuthorDescriptionState createState() => AddAuthorDescriptionState();
}

class AddAuthorDescriptionState extends State<AddAuthorDescription> {
  IconData icon = Icons.add;
  String categoryValue = 'Traditional Genre';
  String ageValue = '0-2';
  String languageValue = 'English';
  String contributorValue = 'Author';
  String subCategoryValue = 'Myths';
  String readingLevelValue = 'Kindergarten: 0.1 - 0.9';
  var data = [];
  var ageData = [];
  var languageData = [];
  var contributorData = [];

  List<String> category = [];
  List<String> ageRange = [];
  List<String> languages = [];
  List<String> contributors = [];
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
  TextEditingController _authorNameController = TextEditingController();
  TextEditingController _keyWordsController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _tagController = TextEditingController();

  SingleValueDropDownController _cnt = SingleValueDropDownController();
  late MultiValueDropDownController _cntMulti;

  //initstate
  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    _cntMulti = MultiValueDropDownController();
    // TODO: implement initState
    super.initState();
    getCollection("categories");
    getAgeRangeCollection("agerange");
    getLanguageCollection();
    getContributorCollection();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Description'),
      ),
      body: SingleChildScrollView(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                _addImage();
                              },
                              child: imagePath == null
                                  ? withoutImage()
                                  : withImage(),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/Title_red_headertext.png',
                                  height: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 30,
                                  // margin: EdgeInsets.only(left: 22, right: 22),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(
                                      color: Colors.black, // Set border color
                                      width: 2.0,
                                    ),
                                    // Set border width
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.black,
                                        offset: Offset(1, 1),
                                      ),
                                    ], // Make rounded corner of border
                                  ),
                                  child: TextFormField(
                                    cursorColor: Colors.black,
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                        hintText: 'Name of your book',
                                        border: InputBorder.none),
                                    controller: _titleController,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/Author_red_headertext.png',
                                  height: 20,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  height: 30,
                                  // margin: EdgeInsets.only(left: 22, right: 22),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(
                                      color: Colors.black, // Set border color
                                      width: 2.0,
                                    ),
                                    // Set border width
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.black,
                                        offset: Offset(1, 1),
                                      ),
                                    ], // Make rounded corner of border
                                  ),
                                  child: DropdownButton(
                                    value: languageValue,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    items: languages.map((String items) {
                                      return DropdownMenuItem(
                                          value: items,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: Text(
                                              items,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ));
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        languageValue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/Author_red_headertext.png',
                                  height: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 30,
                                  // margin: EdgeInsets.only(left: 22, right: 22),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(
                                      color: Colors.black, // Set border color
                                      width: 2.0,
                                    ),
                                    // Set border width
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.black,
                                        offset: Offset(1, 1),
                                      ),
                                    ], // Make rounded corner of border
                                  ),
                                  child: TextFormField(
                                    cursorColor: Colors.black,
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                        hintText: 'Name of the author(s)',
                                        border: InputBorder.none),
                                    controller: _authorNameController,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(bottom: 5.0),
                                    child: Image.asset(
                                      Assets.contributorsTextRed,
                                      height: 15,
                                    )),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  height: 30,
                                  // margin: EdgeInsets.only(left: 22, right: 22),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(
                                      color: Colors.black, // Set border color
                                      width: 2.0,
                                    ),
                                    // Set border width
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.black,
                                        offset: Offset(1, 1),
                                      ),
                                    ], // Make rounded corner of border
                                  ),
                                  child: DropdownButton(
                                    value: contributorValue,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    items: contributors.map((String items) {
                                      return DropdownMenuItem(
                                          value: items,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: Text(
                                              items,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ));
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        contributorValue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 5.0),
                                  child: Stack(
                                    children: [
                                      addNewBookWidget(
                                          context,
                                          Assets.editPagesRedBox,
                                          MediaQuery.of(context).size.width *
                                              0.15),
                                      addNewBookWidget(
                                          context,
                                          Assets.editPagesRedDeleteText,
                                          MediaQuery.of(context).size.width *
                                              0.15),
                                      addNewBookWidget(
                                          context,
                                          Assets.editPagesRedAdd,
                                          MediaQuery.of(context).size.width *
                                              0.15),
                                      addNewBookWidget(
                                          context,
                                          Assets.editPagesRedMinus,
                                          MediaQuery.of(context).size.width *
                                              0.15),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.4,
                                  height: 30,
                                  // margin: EdgeInsets.only(left: 22, right: 22),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(
                                      color: Colors.black, // Set border color
                                      width: 2.0,
                                    ),
                                    // Set border width
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.black,
                                        offset: Offset(1, 1),
                                      ),
                                    ], // Make rounded corner of border
                                  ),
                                  child: TextFormField(
                                    cursorColor: Colors.black,
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    controller: _titleController,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 5.0, left: 22.0),
                              child: Image.asset(
                                Assets.keywordsTextRed,
                                height: 15,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 1.1,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                              color: Colors.black, // Set border color
                              width: 2.0,
                            ),
                            // Set border width
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Colors.black,
                                offset: Offset(1, 1),
                              ),
                            ], // Make rounded corner of border
                          ),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            textAlign: TextAlign.start,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller: _keyWordsController,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(bottom: 5.0, left: 3.0),
                                  child: Image.asset(
                                    Assets.readingLevelText,
                                    height: 15,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  height: 30,
                                  // margin: EdgeInsets.only(left: 22, right: 22),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(
                                      color: Colors.black, // Set border color
                                      width: 2.0,
                                    ),
                                    // Set border width
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.black,
                                        offset: Offset(1, 1),
                                      ),
                                    ], // Make rounded corner of border
                                  ),
                                  child: DropdownButton(
                                    value: readingLevelValue,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    items: readingLevel.map((String items) {
                                      return DropdownMenuItem(
                                          value: items,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: Text(
                                              items.toString(),
                                              style: TextStyle(
                                                  color: Colors.black),
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
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(bottom: 5.0, left: 3.0),
                                  child: Image.asset(
                                    Assets.ageRangeTextRed,
                                    height: 15,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  height: 30,
                                  // margin: EdgeInsets.only(left: 22, right: 22),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(
                                      color: Colors.black, // Set border color
                                      width: 2.0,
                                    ),
                                    // Set border width
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.black,
                                        offset: Offset(1, 1),
                                      ),
                                    ], // Make rounded corner of border
                                  ),
                                  child: DropdownButton(
                                    value: ageValue,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    items: ageRange.map((String items) {
                                      return DropdownMenuItem(
                                          value: items,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: Text(
                                              items,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ));
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        ageValue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 5.0, left: 18.0),
                              child: Image.asset(
                                Assets.genresTextRed,
                                height: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 30,
                              // margin: EdgeInsets.only(left: 22, right: 22),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Colors.black, // Set border color
                                  width: 2.0,
                                ),
                                // Set border width
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                  ),
                                ], // Make rounded corner of border
                              ),
                              child: DropdownButton(
                                value: categoryValue,
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: category.map((String items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Text(
                                          items,
                                          style: TextStyle(color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    categoryValue = newValue!;
                                    subCategoryValue =
                                        data[category.indexOf(newValue)]
                                            [categoryValue][0];
                                    subCategory =
                                        data[category.indexOf(newValue)]
                                            [categoryValue];
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 30,
                              // margin: EdgeInsets.only(left: 22, right: 22),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Colors.black, // Set border color
                                  width: 2.0,
                                ),
                                // Set border width
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                  ),
                                ], // Make rounded corner of border
                              ),
                              child: DropdownButton(
                                value: subCategoryValue,
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: subCategory.map((String items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Text(
                                          items,
                                          style: TextStyle(color: Colors.black),
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
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(bottom: 5.0, left: 3.0),
                                  child: Image.asset(
                                    Assets.topicsTextRed,
                                    height: 15,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(
                                      color: Colors.black, // Set border color
                                      width: 2.0,
                                    ),
                                    // Set border width
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.black,
                                        offset: Offset(1, 1),
                                      ),
                                    ], // Make rounded corner of border
                                  ),
                                  child: TextFormField(
                                    cursorColor: Colors.black,
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    controller: _tagController,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 5.0, left: 3.0),
                              child: Image.asset(
                                Assets.bookDescriptionsTextRed,
                                height: 15,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.1,
                              height: MediaQuery.of(context).size.height / 3,
                              // margin: EdgeInsets.only(left: 22, right: 22),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Colors.black, // Set border color
                                  width: 2.0,
                                ),
                                // Set border width
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                  ),
                                ], // Make rounded corner of border
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 999,
                                cursorColor: Colors.black,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:
                                        "What is your book about? (Max xxx characters)"),
                                controller: _descriptionController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(bottom: 5.0, left: 3.0),
                                  child: Image.asset(
                                    Assets.topicsTextRed,
                                    height: 15,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(
                                      color: Colors.black, // Set border color
                                      width: 2.0,
                                    ),
                                    // Set border width
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.black,
                                        offset: Offset(1, 1),
                                      ),
                                    ], // Make rounded corner of border
                                  ),
                                  child: TextFormField(
                                    cursorColor: Colors.black,
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    controller: _priceController,
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              child: Image.asset(
                                Assets.rateTextRed,
                                height: 15,
                              ),
                              onTap: () {},
                            ),
                            InkWell(
                              child: Image.asset(
                                Assets.royaltyTextRed,
                                height: 15,
                              ),
                              onTap: () {},
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 5.0, left: 22.0),
                              child: Image.asset(
                                Assets.publishingRightsText,
                                height: 15,
                              ),
                            ),
                            RadioListTile(
                              title: Text(
                                  "I own the copyright and I hold the necessary publishing rights"),
                              value: "1",
                              groupValue: radioButtonValue,
                              onChanged: (value) {
                                setState(() {
                                  radioButtonValue = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text("This is a public domain work"),
                              value: "2",
                              groupValue: radioButtonValue,
                              onChanged: (value) {
                                setState(() {
                                  radioButtonValue = value.toString();
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                              onTap: () {
                                print(imagePath);
                                print(_titleController.text.toString());
                                print(_authorNameController.text.toString());
                                print(_keyWordsController.text.toString());
                                print(_tagController.text.toString());
                                print(_descriptionController.text.toString());
                                print(_priceController.text.toString());
                                print(languageValue);
                                print(contributorValue);
                                print(readingLevelValue);
                                print(ageValue);
                                print(categoryValue);
                                print(subCategoryValue);
                                print(radioButtonValue);

                                saveImages(imagePath, sightingRef);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ConfirmBookDetails(
                                            images: widget.images,
                                            imagesPath: widget.imagesPath,
                                            coverImage: imagePath,
                                            title: _titleController.text,
                                            authorName:
                                                _authorNameController.text,
                                            bookDescription:
                                                _descriptionController.text,
                                            bookGenre: categoryValue,
                                            price: _priceController.text,
                                            topic: _tagController.text,
                                          )
                                      /*AudioRecorder(*/ /*images: [imagePath],*/ /*),*/
                                      ),
                                );
                              },
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
                                      MediaQuery.of(context).size.width * 0.30),
                                  addNewBookWidget(
                                      context,
                                      Assets.directionalTextContinue,
                                      MediaQuery.of(context).size.width * 0.30),
                                ],
                              ),
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
          ],
        ),
      ),
    );
  }

  String? radioButtonValue;

  navigateToVoiceRecordScreen() async {
    var imageSplitPath = imagePath.path.toString().split('/');
    var storageReference = FirebaseStorage.instance
        .ref()
        .child('book_cover')
        .child(imageSplitPath[imageSplitPath.length - 1]);
    UploadTask uploadTask = storageReference.putFile(imagePath);
    await uploadTask.then((res) {
      storageReference.getDownloadURL().then((imageURL) {
        return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VoiceRecorder(
                    widget.images,
                    sightingRef,
                    imageURL,
                    categoryValue.toString(),
                    subCategoryValue.toString(),
                    _titleController.text.toString(),
                    _tagController.text.toString(),
                  )
              /*AudioRecorder(*/ /*images: [imagePath],*/ /*),*/
              ),
        );
      });
    });
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

  withImage() {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2.5),
          borderRadius: BorderRadius.circular(
            8.0,
          ), //<-- SEE HERE
        ),
        child: imagePath == null
            ? Image.asset(
                Assets.coverRedBook,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Image.file(
                  imagePath,
                  fit: BoxFit.cover,
                )),
        height: MediaQuery.of(context).size.height / 4,
        // width: MediaQuery.of(context).size.width / 3,
      ),
    );
  }

  withoutImage() {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: imagePath == null
          ? Image.asset(
              Assets.coverRedBook,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(7.0),
              child: Image.file(
                imagePath,
                fit: BoxFit.cover,
              )),
      height: MediaQuery.of(context).size.height / 4,
      // width: MediaQuery.of(context).size.width / 3,
    );
  }

  getAgeRangeCollection(String collectionName) {
    var collection = FirebaseFirestore.instance.collection("agerange");
    FirebaseFirestore.instance
        .collection('agerange')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          List list = doc["agerange"];
          ageData.add(list.cast<String>());
        });
      });
      ageRange = ageData[0];
    });
    return collection;
  }

  getLanguageCollection() {
    var collection = FirebaseFirestore.instance.collection("agerange");
    FirebaseFirestore.instance
        .collection('Language')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          List list = doc["language"];
          languageData.add(list.cast<String>());
        });
      });
      languages = languageData[0];
    });
    return collection;
  }

  getContributorCollection() {
    var collection = FirebaseFirestore.instance.collection("contributors");
    FirebaseFirestore.instance
        .collection('contributors')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          List list = doc["contributors"];
          contributorData.add(list.cast<String>());
        });
      });
      contributors = contributorData[0];
    });
    return collection;
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
    var audioUrl = "";

    if (widget.withAudio) {
      for (int i = 0; i < widget.audioPaths!.length; i++) {
        var childPath =
            widget.audioPaths![i].keys.first.path.toString().split('/');
        var storageReferencePageUrls = FirebaseStorage.instance
            .ref()
            .child('book_pages')
            .child(childPath[childPath.length - 1]);

        print("upload variable::: ${widget.audioPaths}");

        var upload = await storageReferencePageUrls
            .putFile(widget.audioPaths![i].keys.first);
        imageUrl = await upload.ref.getDownloadURL();

        var audioPath =
            widget.audioPaths![i].values.first.toString().split('/');
        var storageReference = FirebaseStorage.instance
            .ref()
            .child('audios')
            .child(audioPath[audioPath.length - 1]);
        var uploadTask = await storageReference
            .putFile(File(widget.audioPaths![i].values.first));
        audioUrl = await uploadTask.ref.getDownloadURL();

        var audioImagePair = {
          "page": imageUrl,
          "audio": audioUrl,
        };
        imagesUrlArray.add(audioImagePair);
      }
    } else {
      print(widget.images);
      print(widget.imagesPath);

      for (int i = 0; i < widget.images!.length; i++) {
        var childPath = widget.images![i].path.toString().split('/');
        var storageReferencePageUrls = FirebaseStorage.instance
            .ref()
            .child('book_pages')
            .child(childPath[childPath.length - 1]);

        print("upload variable::: ${widget.images}");

        var upload = await storageReferencePageUrls.putFile(widget.images![i]);
        imageUrl = await upload.ref.getDownloadURL();

        var audioImagePair = {
          "page": imageUrl,
          "audio": audioUrl,
        };
        imagesUrlArray.add(audioImagePair);
      }
    }

    var imageSplitPath = _image.path.toString().split('/');
    var storageReference = FirebaseStorage.instance
        .ref()
        .child('book_cover')
        .child(imageSplitPath[imageSplitPath.length - 1]);
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.then((res) {
      storageReference.getDownloadURL().then((imageURL) {
        sightingRef.set({
          "cover_url": imageURL,
          "audio_doc_id": "",
          "author_doc_id": "",
          "category_main": categoryValue.toString(),
          "category_sub": subCategoryValue.toString(),
          "pages_url": imagesUrlArray,
          "title": _titleController.text.toString(),
          "topic": _tagController.text.toString(),
          "book_description": _descriptionController.text.toString(),
          "author_name": _authorNameController.text.toString(),
          "keywords": _keyWordsController.text.toString(),
          "price": _priceController.text.toString(),
          "publishing_rights": radioButtonValue,
        });
      });
    });
  }

// Future<void> saveFile() async {
//   try {
//     var imagesUrlArray = [];
//     var imageUrl = "";
//     var audioUrl = "";
//
//
//
//     var data = widget.ref.set({
//       // "cover_url": widget.imageURL.toString(),
//       // "audio_doc_id": audioURl,
//       "audio_Paging_time": _pageTime.values,
//       "author_doc_id": "",
//       // "category_main": widget.category.toString(),
//       // "category_sub": widget.subCategory.toString(),
//       "pages_url": imagesUrlArray,
//       // "title": widget.title.toString(),
//       // "topic": widget.topic.toString(),
//     });
//
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => AddAuthorDescription(
//             images: widget.images,
//             imagesPath: widget.imagesPath,
//           )
//         /*AudioRecorder(*/ /*images: [imagePath],*/ /*),*/
//       ),
//     );
//   } catch (e, stacktrace) {}
// }

}
