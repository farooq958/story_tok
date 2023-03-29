import 'dart:developer';

import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

import 'video_model.dart';

class AudioBookModel extends CommonDataModel {
  final String? coverUrl;
  final String? categorySub;
  final String? audioDocId;
  final String? categoryMain;
  final String? topic;
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
      topic: map['topic'] != null ? map['topic'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      pageUrl: (map['pages_url'] as List<dynamic>)
          .map(
            (pageJson) => BookPage.fromMap(
              Map.from(pageJson),
            ),
          )
          .toList(),
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
  Future<void> initiate() async {
    try {
      audioPlayer = AudioPlayer();
      await audioPlayer!.setAndroidAudioAttributes(
        const AndroidAudioAttributes(
          contentType: AndroidAudioContentType.speech,
          usage: AndroidAudioUsage.media,
        ),
      );
      audioPlayer!.setLoopMode(LoopMode.off);
      await audioPlayer!.setAudioSource(
          AudioSource.uri(Uri.parse(pageUrl.first.audioUrl!)),
          preload: false);
    } catch (e, s) {
      log("Audio Initializer", error: e, stackTrace: s);
    }

    return super.initiate();
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
//  ** SUGGESTED **  //
/* {
  cover_url: https://firebasestorage.googleapis.com/v0/b/storily-f38a6.appspot.com/o/book_cover%2FIMG_20230309_153020.jpg?alt=media&token=fe4f89a0-0375-479f-8066-298235ddad34,
 category_sub: Myths,
 category_main: Traditional Genre,
 author_doc_id: ,
 topic: bitread app topic,
page: [
    {
      "page 1 url",
      "audio 1 link"
    },
    {
      "page 2 url",
      "audio 2 link"
    },
  ],
   title: bitread app title
 } */

//  ** NEW RES **  //
/* 
{
cover_url: https://firebasestorage.googleapis.com/v0/b/storily-f38a6.appspot.com/o/book_cover%2FIMG_20230309_225422_649.jpg?alt=media&token=2a5b9ccd-d5af-4448-a371-649be5ab68f9,
 category_sub: Imagery,
 category_main: Poetry,
 author_doc_id: ,
 topic: hdjjdb,
 pages_url: [
  {page: https://firebasestorage.googleapis.com/v0/b/storily-f38a6.appspot.com/o/book_pages%2Fscaled_IMG_20230309_225422_649.jpg?alt=media&token=3116a98b-172a-4e24-89d6-85b04a89202f,
 audio: https://firebasestorage.googleapis.com/v0/b/storily-f38a6.appspot.com/o/audios%2Faudio480859453156125068.m4a?alt=media&token=dd1f2f21-0069-47c2-80d7-3b5daa924f14},
 {page: https://firebasestorage.googleapis.com/v0/b/storily-f38a6.appspot.com/o/book_pages%2Fscaled_IMG_20230309_225428_611.jpg?alt=media&token=3de395fa-5c32-48c7-b72d-3d9f541f4d95,
 audio: https://firebasestorage.googleapis.com/v0/b/storily-f38a6.appspot.com/o/audios%2Faudio7154920678776667324.m4a?alt=media&token=54b28e1a-a22f-4b73-b45d-a37e53a56665},
 {page: https://firebasestorage.googleapis.com/v0/b/storily-f38a6.appspot.com/o/book_pages%2Fscaled_IMG_20230309_225435_977.jpg?alt=media&token=ba3ca95c-4927-4ff2-b20f-a9c75a1ba2e1,
 audio: https://firebasestorage.googleapis.com/v0/b/storily-f38a6.appspot.com/o/audios%2Faudio8921107690173517838.m4a?alt=media&token=84cb7992-f079-46f8-907c-e529f4b24a6d},
 {page: https://firebasestorage.googleapis.com/v0/b/storily-f38a6.appspot.com/o/book_pages%2Fscaled_IMG_20230309_225441_364.jpg?alt=media&token=fe6d8d90-6c44-4d33-94f5-55167addf483,
 audio: https://firebasestorage.googleapis.com/v0/b/storily-f38a6.appspot.com/o/audios%2Faudio8319672088218202217.m4a?alt=media&token=97786b86-8815-4235-83a0-f2fe9ed5ee05}],
 title: audio cut up
 } 
 */
