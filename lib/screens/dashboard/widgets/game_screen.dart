import 'dart:developer';
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
      body: Stack(
        children: [
          WebViewWidget(
            controller: widget.gameModel.controller!,
            /* initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (url) {
              setState(() {
                loadingPercentage = 0;
              });
              log(widget.url);
              if (widget.onPageStarted != null) {
                widget.onPageFinished!(url, controller);
              }
            },
            onProgress: (progress) {
              setState(() {
                loadingPercentage = progress;
                log(progress.toString());
              });
            },
            onPageFinished: (url) => (url) {
              // here i will run the javascript code to perform something like scrapping and automation
              log(widget.url);
              setState(() {
                loadingPercentage = 100;
              });
              if (widget.onPageFinished != null) {
                widget.onPageFinished!(url, controller);
              }
            },
            onWebViewCreated: (controller) {
              this.controller = controller;
            }, */
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
              minHeight: 2.5,
            ),
        ],
      ),
    );
  }
}
