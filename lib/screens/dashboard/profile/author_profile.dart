import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../global/constants/color_resources.dart';
import '../widgets/circle_profile.dart';
import '../widgets/textfield_clear.dart';
import '../widgets/textfiled_desc.dart';

class AuthorProfile extends StatefulWidget {
  const AuthorProfile({Key? key}) : super(key: key);

  @override
  State<AuthorProfile> createState() => _AuthorProfileState();
}

class _AuthorProfileState extends State<AuthorProfile> {
  final TextEditingController controllerProfile = TextEditingController();
  final TextEditingController controllerBio = TextEditingController();
  bool isBooksSelected = true;
  bool isVideoSelected = false;
  bool isEventsSelected = false;
  bool isPublishedSelected = true;
  bool isUnderReviewSelected = false;
  late Query collectionRefAuthor;
  late QuerySnapshot querySnapshotAuthor;
  var authorProfile = [];

  late Query collectionRefBook;
  late QuerySnapshot querySnapshotBook;
  var bookLists = [];

  late Query collectionRefVideo;
  late QuerySnapshot querySnapshotVideo;
  var videoLists = [];

  late Query collectionRefEvent;
  late QuerySnapshot querySnapshotEvent;
  var eventLists = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadProfileData();
  }

  void loadProfileData() async {
    await getAuthorProfileData();
  }

  Future<List> getAuthorProfileData() async {
    collectionRefAuthor = FirebaseFirestore.instance.collection('book_authors');

    // Get docs from collection reference
    querySnapshotAuthor = await collectionRefAuthor.get();

    // Get data from docs and convert map to List
    authorProfile = querySnapshotAuthor.docs.map((doc) => doc.data()).toList();

    print('#### PROFILE COUNT ${authorProfile.length}');
    return authorProfile;
  }

  Future<List> getBookData() async {
    collectionRefBook = FirebaseFirestore.instance.collection('booksentity');

    // Get docs from collection reference
    querySnapshotBook = await collectionRefBook.get();

    // Get data from docs and convert map to List
    bookLists = querySnapshotBook.docs.map((doc) => doc.data()).toList();

    print('#### Book COUNT ${bookLists.length}');
    return bookLists;
  }

  Future<List> getVideoData() async {
    collectionRefVideo = FirebaseFirestore.instance.collection('videos');

    // Get docs from collection reference
    querySnapshotVideo = await collectionRefVideo.get();

    // Get data from docs and convert map to List
    videoLists = querySnapshotVideo.docs.map((doc) => doc.data()).toList();

    print('#### Video COUNT ${videoLists.length}');
    return videoLists;
  }

  Future<List> getEventData() async {
    collectionRefEvent = FirebaseFirestore.instance.collection('videos');

    // Get docs from collection reference
    querySnapshotEvent = await collectionRefEvent.get();

    // Get data from docs and convert map to List
    eventLists = querySnapshotEvent.docs.map((doc) => doc.data()).toList();

    print('#### Event COUNT ${eventLists.length}');
    return eventLists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.autherProfileBG,
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getAuthorProfileData(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return Container(
                //       height: MediaQuery.of(context).size.height,
                //       width: MediaQuery.of(context).size.width,
                //       child: Center(child: CircularProgressIndicator()));
                // } else {
                print('####### SNAP ${snapshot.data}');
                //var list = snapshot.data!;
                return Column(
                  children: [
                    CircleProfile(
                        profileurl: authorProfile.isNotEmpty
                            ? authorProfile[0]['avatar_url'] ?? ''
                            : ''),
                    TextFiledClear(
                      controllerProfile: controllerProfile,
                      name: authorProfile.isNotEmpty
                          ? authorProfile[0]['name'] ?? ''
                          : '',
                    ),
                    TextFiledBio(
                        controllerBio: controllerBio,
                        bio: authorProfile.isNotEmpty
                            ? authorProfile[0]['boigraphy'] ?? ''
                            : ''),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0),
                      child: Stack(children: [
                        Image.asset('assets/images/menubox.png'),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 5),
                              Expanded(
                                child: isBooksSelected
                                    ? InkWell(
                                        onTap: () {
                                          isBooksSelected = true;
                                          isVideoSelected = false;
                                          isEventsSelected = false;
                                          setState(() {
                                            isBooksSelected;
                                            isVideoSelected;
                                            isEventsSelected;
                                          });
                                        },
                                        child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/selectedmenu.png'),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "BOOKS",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          isBooksSelected = true;
                                          isVideoSelected = false;
                                          isEventsSelected = false;
                                          setState(() {
                                            isBooksSelected;
                                            isVideoSelected;
                                            isEventsSelected;
                                          });
                                        },
                                        child: Container(
                                          height: 45,
                                          child: Center(
                                            child: Text(
                                              "BOOKS",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: isVideoSelected
                                    ? InkWell(
                                        onTap: () {
                                          isBooksSelected = false;
                                          isVideoSelected = true;
                                          isEventsSelected = false;
                                          setState(() {
                                            isBooksSelected;
                                            isVideoSelected;
                                            isEventsSelected;
                                          });
                                        },
                                        child: Container(
                                          height: 45,
                                          //width: 150,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/selectedmenu.png'),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "VIDEOS",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          isBooksSelected = false;
                                          isVideoSelected = true;
                                          isEventsSelected = false;
                                          setState(() {
                                            isBooksSelected;
                                            isVideoSelected;
                                            isEventsSelected;
                                          });
                                        },
                                        child: Container(
                                          height: 45,
                                          child: Center(
                                            child: Text(
                                              "VIDEOS",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: isEventsSelected
                                    ? InkWell(
                                        onTap: () {
                                          isBooksSelected = false;
                                          isVideoSelected = false;
                                          isEventsSelected = true;
                                          setState(() {
                                            isBooksSelected;
                                            isVideoSelected;
                                            isEventsSelected;
                                          });
                                        },
                                        child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/selectedmenu.png'),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "EVENTS",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          isBooksSelected = false;
                                          isVideoSelected = false;
                                          isEventsSelected = true;
                                          setState(() {
                                            isBooksSelected;
                                            isVideoSelected;
                                            isEventsSelected;
                                          });
                                        },
                                        child: Container(
                                          height: 45,
                                          //width: 150,
                                          child: Center(
                                            child: Text(
                                              "EVENTS",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              SizedBox(width: 5),
                            ],
                          ),
                        )
                      ]),
                    ),
                    isBooksSelected
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            child: Stack(children: [
                              Image.asset(
                                'assets/images/menubox.png',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: isPublishedSelected
                                          ? InkWell(
                                              onTap: () {
                                                isPublishedSelected = true;
                                                isUnderReviewSelected = false;
                                                setState(() {
                                                  isPublishedSelected;
                                                  isUnderReviewSelected;
                                                });
                                              },
                                              child: Container(
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/selectedmenu.png'),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "PUBLISHED",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                isPublishedSelected = true;
                                                isUnderReviewSelected = false;
                                                setState(() {
                                                  isPublishedSelected;
                                                  isUnderReviewSelected;
                                                });
                                              },
                                              child: Container(
                                                height: 45,
                                                child: Center(
                                                  child: Text(
                                                    "PUBLISHED",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: isUnderReviewSelected
                                          ? InkWell(
                                              onTap: () {
                                                isPublishedSelected = false;
                                                isUnderReviewSelected = true;
                                                setState(() {
                                                  isPublishedSelected;
                                                  isUnderReviewSelected;
                                                });
                                              },
                                              child: Container(
                                                height: 45,
                                                //width: 150,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/selectedmenu.png'),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "UNDER REVIEW",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                isPublishedSelected = false;
                                                isUnderReviewSelected = true;
                                                setState(() {
                                                  isPublishedSelected;
                                                  isUnderReviewSelected;
                                                });
                                              },
                                              child: Container(
                                                height: 45,
                                                child: Center(
                                                  child: Text(
                                                    "UNDER REVIEW",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                          )
                        : SizedBox(),
                    isBooksSelected
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            child: Stack(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Container(
                                      width: 200,
                                      child: Image.asset(
                                        'assets/images/profile/profile_purple_sortby_box.png',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  DropdownButton<String>(
                                    iconSize: 40,
                                    hint: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Text("Sort By...",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          )),
                                    ),
                                    underline: SizedBox(),
                                    items: <String>[
                                      'Date',
                                      'Size',
                                      'Newest',
                                      'Published'
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (_) {},
                                  ),
                                ],
                              )
                            ]))
                        : SizedBox(),
                    isEventsSelected ? eventList(context) : SizedBox(),
                    isBooksSelected ? bookList(context) : SizedBox(),
                    isVideoSelected ? videoList(context) : SizedBox()
                  ],
                );
                //}
              } else {
                return Text('no data');
              }
              // return Container(
              //     height: MediaQuery.of(context).size.height,
              //     width: MediaQuery.of(context).size.width,
              //     child: Center(child: CircularProgressIndicator()));
            }),
      ),
    );
  }

  Widget eventList(BuildContext context) {
    return FutureBuilder(
        future: getEventData(),
        builder: (BuildContext context, snapshot) {
          return ListView.builder(
            itemCount: eventLists.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
                child: Stack(children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/events/eventticket_yellow_base.png'),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 150,
                                // width: 50,
                                child: Image.asset(
                                    'assets/images/events/eventticket_yellow_bookicon.png')),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "EVENT TITLE",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              "01/05/20XX",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              "01:30-02:30",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 50,
                                  // width: 100,
                                  child: Image.asset(
                                      'assets/images/events/eventticket_yellow_editicon.png')),
                              Text(
                                "50 MORE DAYS",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              );
            },
          );
        });
  }

  Widget bookList(BuildContext context) {
    return FutureBuilder(
        future: getBookData(),
        builder: (BuildContext context, snapshot) {
          return GridView.builder(
            itemCount: bookLists.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              // return bookListRow(bookLists[index]);
              return Padding(
                padding:
                    const EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
                child: Stack(children: [

                  Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: CachedNetworkImage(
                            imageUrl: bookLists[index]['cover_url'],
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Transform.scale(
                                  scale: 0.5,
                                  child: CircularProgressIndicator(
                                    color: Color.fromRGBO(216, 209, 231, 1.0),
                                  ),
                                )
                            //  Image.asset('assets/images/profile.png'),
                            // child: Image.network(
                            //     mainCategoryData[index]
                            //         ['catimage1url']),
                            ),
                      ),
                      Container(
                        width: 100,
                        height: 20,
                       child: Row(
                         children: [
                           Icon(Icons.thumb_up,size: 12),
                           Padding(
                             padding: const EdgeInsets.only(left:3.0),
                             child: Text(
                               bookLists[index]['likes'].toString(),
                               style: TextStyle(
                                 color: Colors.black,
                                 fontWeight: FontWeight.w600,
                                 fontSize: 12.0,
                               ),
                             ),
                           ),
                           SizedBox(width: 6),
                           Icon(Icons.remove_red_eye,size: 12),
                           Padding(
                             padding: const EdgeInsets.only(left:3.0),
                             child: Text(
                               bookLists[index]['views'].toString(),
                               style: TextStyle(
                                 color: Colors.black,
                                 fontWeight: FontWeight.w600,
                                 fontSize: 12.0,
                               ),
                             ),
                           )
                         ],
                       ),
                      )
                    ],
                  ),

                  Column(
                    children: [
                      Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              bookLists[index]['title'],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Container(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                bookLists[index]['topic'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )

                  // Container(
                  //   // height: 150,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage(
                  //           'assets/images/books/pagepreview_red_page.png'),
                  //     ),
                  //   ),
                  // ),
                ]),
              );
            },
          );
        });
  }

  Widget videoList(BuildContext context) {
    return FutureBuilder(
        future: getVideoData(),
        builder: (BuildContext context, snapshot) {
          return GridView.builder(
            itemCount: videoLists.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              // return bookListRow(bookLists[index]);
              return Padding(
                padding:
                    const EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
                child: Stack(children: [
                  Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: CachedNetworkImage(
                            imageUrl: videoLists[index]['user_pic'],
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Transform.scale(
                                scale: 0.5,
                                child: CircularProgressIndicator(
                                  color: Color.fromRGBO(216, 209, 231, 1.0),
                                ))
                            //  Image.asset('assets/images/profile.png'),
                            // child: Image.network(
                            //     mainCategoryData[index]
                            //         ['catimage1url']),
                            ),
                      ),
                      Container(
                        width: 100,
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.thumb_up,size: 12),
                            Padding(
                              padding: const EdgeInsets.only(left:3.0),
                              child: Text(
                                videoLists[index]['likes'].toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.comment_rounded,size: 12),
                            Padding(
                              padding: const EdgeInsets.only(left:3.0),
                              child: Text(
                                videoLists[index]['comments'].toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  Column(
                    children: [
                      Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              videoLists[index]['video_title'],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Container(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                videoLists[index]['song_name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Icon(
                      Icons.play_arrow,
                      size: 35,
                    ),
                  )

                  // Container(
                  //   // height: 150,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage(
                  //           'assets/images/books/pagepreview_red_page.png'),
                  //     ),
                  //   ),
                  // ),
                ]),
              );
            },
          );
        });
  }

  Widget bookListRow(Map<dynamic, String> data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
      child: Stack(children: [
        Container(
          // height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/books/pagepreview_red_page.png'),
            ),
          ),
        ),
      ]),
    );
  }

  Widget videoListRow(Map<dynamic, String> data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
      child: Stack(children: [
        Container(
          // height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/books/pagepreview_red_page.png'),
            ),
          ),
        ),
      ]),
    );
  }
}
