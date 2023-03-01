import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum ImageSourceType { gallery, camera }

class AddAuthorDescription extends StatefulWidget {
  @override
  AddAuthorDescriptionState createState() => AddAuthorDescriptionState();
}

class AddAuthorDescriptionState extends State<AddAuthorDescription> {
  IconData icon = Icons.add;
  String categoryValue = 'Traditional Genre';
  String subCategoryValue = 'Myths';
  String readingLevelValue = 'Kindergarten: 0.1 - 0.9';
  List<String> category = [
    'Traditional Genre',
    'realistic Fiction genres',
    'historical Fiction genres',
    'Fantasy',
    'Poetry',
    'NonFictions',
    'picture books'
  ];
  List<String> traditionalCategory = [
    'Myths',
    'fables',
    'epics',
    'ballads',
    'legends',
    'folk rhymes',
    'folktales',
    'fairy tales',
    'trickster tales',
    'tall tales',
    'cumulative tales',
    'pourquoi tales'
  ];
  List<String> realisticFictionGenres = ['Historical', 'Contemporary'];
  List<String> historicalFictionGenres = [
    'Documentary fiction',
    'Fictional biographies',
    'Gothic fiction',
    'Historical mysteries',
    'Historical romance and family sagas',
    'Nautical and pirate fiction',
    'Alternate history and historical fantasy',
    'Historiographic metafiction',
    'Comics and graphic novels'
  ];
  List<String> fantasy = [
    'Animal Fantasy',
    'The World of Toys and Dolls',
    'Eccentric Characters and Preposterous Situations',
    'Extraordinary Worlds',
    'Magical Powers',
    'Suspense and the Supernatural',
    'Time-Shift Fantasy',
    'Imaginary Realms',
    'High Fantasy'
  ];
  List<String> poetry = [
    'Rhythm',
    'Rhyme',
    'Sound',
    'Imagery',
    'Figurative' 'Language',
    'Shape'
  ];
  List<String> nonFictions = [
    'Informational Text',
    'NonFiction Narrative',
    'Biography',
    'How-to'
  ];
  List<String> pictureBooks = ['illustrated kids\' books', 'Comic books'];

  List<String> subCategory = [
    'Myths',
    'fables',
    'epics',
    'ballads',
    'legends',
    'folk rhymes',
    'folktales',
    'fairy tales',
    'trickster tales',
    'tall tales',
    'cumulative tales',
    'pourquoi tales'
  ];

  List<String> readingLevel = [
    'Kindergarten: 0.1 - 0.9',
    '1st Grade: 1.0 - 1.9',
    '2nd Grade: 2.0 - 2.9',
    '3rd Grade: 3.0 - 3.9',
    '4th Grade: 4.0 - 4.9',
    '5th Grade: 5.0 - 5.9',
    '6th Grade: 6.0 - 6.9'
  ];

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  var imagePath;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _tagController = TextEditingController();
  TextEditingController _readingLevelController = TextEditingController();

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
                        });

                        if (categoryValue == 'Traditional Genre') {
                          setState(() {
                            subCategoryValue = traditionalCategory[0];
                            subCategory = traditionalCategory;
                          });
                        } else if (categoryValue ==
                            "realistic Fiction genres") {
                          setState(() {
                            subCategoryValue = realisticFictionGenres[0];
                            subCategory = realisticFictionGenres;
                          });
                        } else if (categoryValue ==
                            "historical Fiction genres") {
                          setState(() {
                            subCategoryValue = historicalFictionGenres[0];
                            subCategory = historicalFictionGenres;
                          });
                        } else if (categoryValue == "Fantasy") {
                          setState(() {
                            subCategoryValue = fantasy[0];
                            subCategory = fantasy;
                          });
                        } else if (categoryValue == "Poetry") {
                          setState(() {
                            subCategoryValue = poetry[0];
                            subCategory = poetry;
                          });
                        } else if (categoryValue == "NonFictions") {
                          setState(() {
                            subCategoryValue = nonFictions[0];
                            subCategory = nonFictions;
                          });
                        } else {
                          setState(() {
                            subCategoryValue = pictureBooks[0];
                            subCategory = pictureBooks;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: 40.0, right: 40.0),
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
                            print(subCategoryValue);
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
                      // Record the screen
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
    image = (await _picker.pickImage(source: ImageSource.gallery))!;
    setState(() {
      icon = Icons.refresh;
      imagePath = File(image!.path);
    });
  }
}
