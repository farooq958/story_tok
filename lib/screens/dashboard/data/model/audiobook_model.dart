import 'video_model.dart';

class AudioBookModel extends CommonDataModel {
  final String? coverUrl;
  final String? categorySub;
  final String? audioDocId;
  final String? categoryMain;
  final String? topic;
  final String? title;
  final List<String?> pageUrl;
  AudioBookModel({
    this.coverUrl,
    this.categorySub,
    this.audioDocId,
    this.categoryMain,
    this.topic,
    this.title,
    required this.pageUrl,
  });

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
      pageUrl: List<String?>.from(
        ((map['pages_url']) ?? []),
      ),
    );
  }
}

/* {
  cover_url: https://firebasestorage.googleapis.com/v0/b/storily-f38a6.appspot.com/o/book_cover%2FIMG_20230309_153020.jpg?alt=media&token=fe4f89a0-0375-479f-8066-298235ddad34,
 category_sub: Myths,
 audio_doc_id: https://firebasestorage.googleapis.com/v0/b/storily-f38a6.appspot.com/o/audios%2Faudio191715786201573146.m4a?alt=media&token=b72679b7-4726-4ccd-b8e3-8deb6b9c394e,
 category_main: Traditional Genre,
 author_doc_id: ,
 topic: bitread app topic,
 pages_url: [https://firebasestorage.googleapis.com/v0/b/storily-f38a6.appspot.com/o/book_pages%2Fscaled_IMG_20230309_153020.jpg?alt=media&token=b5f7d264-287b-40b0-a03c-ded801dd6075],
 title: bitread app title
 } */

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
