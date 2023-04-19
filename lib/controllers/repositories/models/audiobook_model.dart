import 'dart:developer';

import 'package:just_audio/just_audio.dart';

import 'base_content_model.dart';

class AudioBookModel extends CommonDataModel {
  final String? coverUrl;
  final String? categorySub;
  final String? audioDocId;
  final String? categoryMain;
  final List? topic;
  final String? title;
  final List<BookPage> pageUrl;

  AudioBookModel({
    this.coverUrl,
    this.categorySub,
    this.audioDocId,
    this.categoryMain,
    this.topic,
    this.title,
    required this.pageUrl,
  });

  AudioPlayer? audioPlayer;

  factory AudioBookModel.fromMap(Map<String, dynamic> map) {
    return AudioBookModel(
      coverUrl: map['cover_url'] != null ? map['cover_url'] as String : null,
      categorySub:
          map['category_sub'] != null ? map['category_sub'] as String : null,
      audioDocId:
          map['audio_doc_id'] != null ? map['audio_doc_id'] as String : null,
      categoryMain:
          map['category_main'] != null ? map['category_main'] as String : null,
      topic: map['topic'] != null ? map['topic'] : null,
      title: map['title'] != null ? map['title'] as String : null,
      pageUrl: map['pages_url'] != null ? (map['pages_url'] as List<dynamic>)
          .map(
            (pageJson) => BookPage.fromMap(
              Map.from(pageJson),
            ),
          )
          .toList() : [],
    );
  }

  setAudioPlayerSource(int sourceindex) async {
    await audioPlayer!.setAudioSource(
      AudioSource.uri(
        Uri.parse(pageUrl[sourceindex].audioUrl!),
      ),
    );
    await audioPlayer!.play();
  }

  @override
  Future<int> initiate(int index) async {
    try {
      audioPlayer = AudioPlayer();
      audioPlayer!.setLoopMode(LoopMode.off);
      await audioPlayer!.setAudioSource(
          AudioSource.uri(Uri.parse(pageUrl.first.audioUrl!)),
          preload: false);
    } catch (e, s) {
      log("Audio Initializer", error: e, stackTrace: s);
    }
    return index;
  }

  @override
  Future<void> hold() {
    audioPlayer?.pause();
    return super.hold();
  }

  @override
  Future<void> dispose() {
    audioPlayer?.dispose();
    return super.dispose();
  }
}

class BookPage {
  final String? pageUrl;
  final String? audioUrl;
  BookPage({
    this.pageUrl,
    this.audioUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page': pageUrl,
      'audio': audioUrl,
    };
  }

  factory BookPage.fromMap(Map<String, dynamic> map) {
    return BookPage(
      pageUrl: map['page'] != null ? map['page'] as String : null,
      audioUrl: map['audio'] != null ? map['audio'] as String : null,
    );
  }
}

