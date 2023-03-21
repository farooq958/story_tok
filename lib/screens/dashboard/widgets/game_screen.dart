import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../data/model/game_model.dart';

typedef UrlCallback = void Function(String url, WebViewController controller);

class GameScreenWidget extends StatefulWidget {
  const GameScreenWidget({
    Key? key,
    required this.gameModel,
  }) : super(key: key);

  final GameModel gameModel;
  @override
  State<GameScreenWidget> createState() => _GameScreenWidgetState();
}

class _GameScreenWidgetState extends State<GameScreenWidget> {
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: widget.gameModel.controller!,
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
                minHeight: 2.5,
              ),
          ],
        ),
      ),
    );
  }
}
