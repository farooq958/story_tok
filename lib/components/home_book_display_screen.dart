import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
//
// In this code, we create a FirebaseBookPage widget that extends StatefulWidget. The state of the widget is managed
// by the _FirebaseBookPageState class, which extends State<FirebaseBookPage>.
//
// The _FirebaseBookPageState class has a bookId property that identifies the book to load from Firebase.
// It also has a private _bookData variable that holds the future result of loading the book data from Firebase,
// a private _currentPage variable that keeps track of the current page being displayed, and a private _pages list that contains the content for each page.
//
// In the initState method, we initialize Firebase and load the book data from Firebase using the _loadBookData method.
//
// In the build method, we return a Scaffold with an AppBar and a body that contains a FutureBuilder and a GestureDetector.
// The FutureBuilder listens for changes to the _bookData variable and displays a CircularProgressIndicator while the data is being loaded,
// or an error message if there was an error. If the data is loaded successfully, the _pages list is populated with the book data, and a

class FirebaseBookPage extends StatefulWidget {
  final String bookId;

  FirebaseBookPage({@required this.bookId});

  @override
  _FirebaseBookPageState createState() => _FirebaseBookPageState();
}

class _FirebaseBookPageState extends State<FirebaseBookPage> {
  Future<DocumentSnapshot<Map<String, dynamic>>> _bookData; //late , not null safe currently
  int _currentPage = 0;
  List<String> _pages = [];

  @override
  void initState() {
    super.initState();
    _bookData = _loadBookData();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _loadBookData() async {
    await Firebase.initializeApp();
    return FirebaseFirestore.instance.collection('books').doc(widget.bookId).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Book'),
      ),
      body: FutureBuilder(
        future: _bookData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error loading book data.'),
              );
            }
            Map<String, dynamic> bookData = snapshot.data.data();//! not null safe
            _pages = List<String>.from(bookData['pages']);
            return GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.primaryVelocity.compareTo(0) == -1) {
                  setState(() {
                    if (_currentPage < _pages.length - 1) {
                      _currentPage++;
                    }
                  });
                } else if (details.primaryVelocity.compareTo(0) == 1) {
                  setState(() {
                    if (_currentPage > 0) {
                      _currentPage--;
                    }
                  });
                }
              },
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    _pages[_currentPage],
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}