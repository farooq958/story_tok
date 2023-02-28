import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum ImageSourceType { gallery, camera }

class AddAuthorDescription extends StatefulWidget {
  @override
  AddAuthorDescriptionState createState() => AddAuthorDescriptionState();
}

class AddAuthorDescriptionState extends State<AddAuthorDescription> {
  String categoryValue = 'Traditional Genre';
  String subCategoryValue = 'Myths';
  var category = [
    'Traditional Genre',
    'realistic Fiction genres',
    'historical Fiction genres',
    'Fantasy',
    'Poetry',
    'NonFictions',
    'picture books'
  ];
  var traditionalCategory = [
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
  var realisticFictionGenres = ['Historical', 'Contemporary'];
  var historicalFictionGenres = [
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
  var fantasy = [
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
  var poetry = [
    'Rhythm',
    'Rhyme',
    'Sound',
    'Imagery',
    'Figurative' 'Language',
    'Shape'
  ];
  var nonFictions = [
    'Informational Text',
    'NonFiction Narrative',
    'Biography',
    'How-to'
  ];
  var pictureBooks = ['illustrated kids\' books', 'Comic books'];

  var subCategory = [
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

  final ImagePicker _picker = ImagePicker();
  XFile? image;

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
              containers('Title', _titleController),
              SizedBox(
                height: 20.0,
              ),
              containers('Description', _descriptionController),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  children: [
                    Text("Cover"),
                    iconButton(),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              containers('Tag', _tagController),
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
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: category.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child:  Container(width: 90.0,child: Text(
                            items,
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),)
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          categoryValue = newValue!;
                          if (categoryValue == 'Traditional Genre') {
                            setState(() {
                              subCategory = traditionalCategory;
                            });
                          } else if (categoryValue ==
                              "realistic Fiction genres") {
                            setState(() {
                              subCategory = realisticFictionGenres;
                            });
                          } else if (categoryValue ==
                              "historical Fiction genres") {
                            setState(() {
                              subCategory = historicalFictionGenres;
                            });
                          } else if (categoryValue == "Fantasy") {
                            setState(() {
                              subCategory = fantasy;
                            });
                          } else if (categoryValue == "Poetry") {
                            setState(() {
                              subCategory = poetry;
                            });
                          } else if (categoryValue == "NonFictions") {
                            setState(() {
                              subCategory = nonFictions;
                            });
                          } else {
                            setState(() {
                              subCategory = pictureBooks;
                            });
                          }
                          print(categoryValue);
                        });
                      },
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: 40.0, right: 40.0),
                      child: DropdownButton(
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: subCategory.map((String items) {
                          return DropdownMenuItem(
                              value: items,
                              child: Container(width: 120.0,child: Text(
                                items,
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),)
                          );
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
              containers('Reading Level', _readingLevelController),
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

  containers(String label, TextEditingController _controller) {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  iconButton() {
    return IconButton(
        onPressed: () {
          _addImage();
        },
        icon: Icon(Icons.add));
  }

  void _addImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
  }
}
