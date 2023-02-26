import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:storily/components/home_video_display_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import "package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart";
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

//In this code, the GameScreen widget takes in a gameId parameter,
// //which is used to retrieve the game data from Firebase using the FirebaseDatabase package.
// //Once the game data is retrieved, it is parsed as JSON and the game name, image URL, and game URL are extracted.
// The game image is displayed using the Image.network widget, and the "Play Now" button navigates to the GameWebViewScreen widget,
// which loads the game URL in a webview using the webview_flutter package. Note that the webview screen also disables landscape mode,
// as many games are designed to be played in portrait mode.
class GameScreen extends StatefulWidget {
  final String gameId;

  GameScreen({@required this.gameId});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String _gameData;

  @override
  void initState() {
    super.initState();
    _loadGameData();
  }

  _loadGameData() async {
    final DatabaseReference databaseRef =
    FirebaseDatabase.instance.reference().child('games').child(widget.gameId);
    databaseRef.once().then((snapshot) {//DataSnapshot
      setState(() {
        _gameData = snapshot.snapshot.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_gameData == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      final gameJson = json.decode(_gameData);
      final gameName = gameJson['name'];
      final gameImageUrl = gameJson['image_url'];
      final gameUrl = gameJson['game_url'];

      return Scaffold(
        appBar: AppBar(
          title: Text(gameName),
        ),
        body: GestureDetector(
        onVerticalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity > 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VideoDisplayScreen()), //this needs to be changed to random types, not just video, but it is a start.
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(gameImageUrl),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameWebViewScreen(url: gameUrl)),
                  );
                },
                child: Text('Play Now'),
              ),
            ],
          ),
        ),
        ),
      );
    }
  }
}

class GameWebViewScreen extends StatefulWidget {
  final String url;

  GameWebViewScreen({@required this.url});

  @override
  _GameWebViewScreenState createState() => _GameWebViewScreenState();
}

class _GameWebViewScreenState extends State<GameWebViewScreen> {
  @override
  void initState() {
    super.initState();
    // Disable landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // Enable landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }
  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
        // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
  ..loadRequest(Uri.parse('https://flutter.dev'));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(controller: controller),
        //   initialUrl: widget.url,
        //   javascriptMode: JavascriptMode.unrestricted,
        // ),
      ),
    );
  }
}