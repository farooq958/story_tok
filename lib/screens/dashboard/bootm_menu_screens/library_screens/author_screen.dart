import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../../Utils/Events/library_utils.dart';
import '../../../../global/constants/color_resources.dart';
import '../../widgets/circle_profile.dart';
import '../../widgets/textfield_clear.dart';
import '../../widgets/textfiled_desc.dart';
///to be modified
class AuthorLibraryScreen extends StatefulWidget {
 final String auhtorId;
  const AuthorLibraryScreen({Key? key,required this.auhtorId}) : super(key: key);

  @override
  State<AuthorLibraryScreen> createState() => _AuthorLibraryScreenState();
}

class _AuthorLibraryScreenState extends State<AuthorLibraryScreen> {
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

  late Query collectionRefEventType;
  late QuerySnapshot querySnapshotEventType;
  var eventTypeLists = [];

  late Query collectionRefBookCategory;
  late QuerySnapshot querySnapshotBookCategory;
  var bookCategoryLists = [];

  List<String> categoryLists = [];

  var selectedSort = 'Sort By...';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadEventTypeData();
  }

  void loadEventTypeData() async {
    //await getAuthorProfileData();
    await getEventTypeData();
    await getBookCategoryData();
  }

  Future<List> getAuthorProfileData() async {
    collectionRefAuthor = FirebaseFirestore.instance.collection('book_authors').where('user_id',isEqualTo: widget.auhtorId.trim());

    // Get docs from collection reference
    querySnapshotAuthor = await collectionRefAuthor.get();

    // Get data from docs and convert map to List
    authorProfile = querySnapshotAuthor.docs.map((doc) => doc.data()).toList();

    print('#### PROFILE COUNT ${authorProfile.length}');
    return authorProfile;
  }

  Future<List> getEventTypeData() async {
    collectionRefEventType =
        FirebaseFirestore.instance.collection('event_type_static');

    // Get docs from collection reference
    querySnapshotEventType = await collectionRefEventType.get();

    // Get data from docs and convert map to List
    eventTypeLists =
        querySnapshotEventType.docs.map((doc) => doc.data()).toList();

    print('#### EVENT TYPE COUNT ${eventTypeLists.length}');
    return eventTypeLists;
  }

  Future<List> getBookData() async {

        collectionRefBook = FirebaseFirestore.instance
            .collection('booksentity')
            .where('author_doc_id', isEqualTo: widget.auhtorId.trim());



    // Get docs from collection reference
    querySnapshotBook = await collectionRefBook.get();

    // Get data from docs and convert map to List
    bookLists = querySnapshotBook.docs.map((doc) => doc.data()).toList();

    print('#### Book COUNT ${bookLists.length}');
    return bookLists;
  }

  Future<List> getVideoData() async {
    collectionRefVideo = FirebaseFirestore.instance.collection('videos').where('user',isEqualTo: widget.auhtorId.trim());

    // Get docs from collection reference
    querySnapshotVideo = await collectionRefVideo.get();

    // Get data from docs and convert map to List
    videoLists = querySnapshotVideo.docs.map((doc) => doc.data()).toList();

    print('#### Video COUNT ${videoLists.length}');
    return videoLists;
  }

  Future<List> getEventData() async {
    collectionRefEvent = FirebaseFirestore.instance
        .collection('streaming_events')
        .orderBy('createdDate', descending: false);

    // Get docs from collection reference
    querySnapshotEvent = await collectionRefEvent.get();

    // Get data from docs and convert map to List
    eventLists = querySnapshotEvent.docs.map((doc) => doc.data()).toList();

    print('#### Event COUNT ${eventLists.length}');
    return eventLists;
  }
  Future<void> getBookCategoryData() async {
    collectionRefBookCategory = FirebaseFirestore.instance
        .collection('categories');

    // Get docs from collection reference
    querySnapshotBookCategory = await collectionRefBookCategory.get();

    // Get data from docs and convert map to List
    bookCategoryLists = querySnapshotBookCategory.docs.map((doc) => doc.data()).toList();

    print('#### Book Category COUNT ${bookCategoryLists.length}');

    categoryLists = [];
    for(int i=0; i<bookCategoryLists.length; i++){
      var bookCat = bookCategoryLists[i]['name'];
      print('#### BOOK OBJ $bookCat');
      //print('#### BOOK NAME ${bookCat.get('name')}');
      categoryLists.add(bookCat);
    }
    setState(() {
      categoryLists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var docID = '';
        await FirebaseFirestore.instance
            .collection('book_authors')
            .get()
            .then((value1) {
          value1.docs.forEach((element) {
            print(element.id);
            docID = element.id;
          });
        });
        await FirebaseFirestore.instance
            .collection('book_authors')
            .doc(docID)
            .update({
          'name': controllerProfile.text,
          'boigraphy':controllerBio.text
        });
        return true;

      },
      child: Scaffold(


        backgroundColor: ColorResources.autherProfileBG,
        body: SafeArea(
          child: Container(
            width: 1.sw,
            height: 1.sh,
            decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage("assets/images/authorprofile_background.png"))),
            child: Stack(
              children: [

                Positioned(
                    top: 100,
                    right: 1.sw/7,

                    child: Image.asset("assets/images/background_circledots.png",width: 80.sp,height: 80.sp,)),
                Positioned(
                    top: 1.sh/5.2,
                    left: 20.sp,
                    child: Image.asset("assets/images/background_kids_cross2.png",height: 20.sp,width: 40.sp,)),
                Positioned(
                    top: 70.sp,
                    left: 1.sw/7,

                    child: Image.asset("assets/images/background_squiggle.png",width: 50.sp,height: 30.sp,)),
                Positioned(
                    top: 90.sp,
                    right: 1.sw/18,

                    child: Image.asset("assets/images/background_kids_squiggle1.png",width: 50.sp,height: 15.sp,)),
                Positioned(
                    top: 30.sp,
                    left: 1.sw/5,

                    child: Image.asset("assets/images/background_triangle.png",width: 30.sp,height: 25.sp,)),
                Positioned(
                    top: 30.sp,
                    right: 1.sw/5,

                    child: Image.asset("assets/images/background_kids_cross1.png",width: 30.sp,height: 25.sp,)),
                SingleChildScrollView(
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
                              // TextFiledClear(
                              //   controllerProfile: controllerProfile,
                              //   name: authorProfile.isNotEmpty
                              //       ? authorProfile[0]['name'] ?? ''
                              //       : '',
                              // ),
                              TextFiledBio2(
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
                                                      'assets/images/authorprofile_yellowselector.png'),
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
                                                      'assets/images/authorprofile_yellowselector.png'),
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
                                                      'assets/images/authorprofile_yellowselector.png'),
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
                              // isBooksSelected
                              //     ? Padding(
                              //   padding: const EdgeInsets.only(
                              //       top: 10.0, left: 10.0, right: 10.0),
                              //   child: Stack(children: [
                              //     Image.asset(
                              //       'assets/images/menubox.png',
                              //     ),
                              //     Padding(
                              //       padding: const EdgeInsets.only(top: 3.6),
                              //       child: Row(
                              //         mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Expanded(
                              //             child: isPublishedSelected
                              //                 ? InkWell(
                              //               onTap: () {
                              //                 isPublishedSelected = true;
                              //                 isUnderReviewSelected = false;
                              //                 setState(() {
                              //                   isPublishedSelected;
                              //                   isUnderReviewSelected;
                              //                 });
                              //               },
                              //               child: Container(
                              //                 height: 45,
                              //                 decoration: BoxDecoration(
                              //                   image: DecorationImage(
                              //                     image: AssetImage(
                              //                         'assets/images/selectedmenu.png'),
                              //                   ),
                              //                 ),
                              //                 child: Center(
                              //                   child: Text(
                              //                     "PUBLISHED",
                              //                     style: TextStyle(
                              //                       color: Colors.black,
                              //                       fontWeight:
                              //                       FontWeight.bold,
                              //                       fontSize: 16.0,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             )
                              //                 : InkWell(
                              //               onTap: () {
                              //                 isPublishedSelected = true;
                              //                 isUnderReviewSelected = false;
                              //                 setState(() {
                              //                   isPublishedSelected;
                              //                   isUnderReviewSelected;
                              //                 });
                              //               },
                              //               child: Container(
                              //                 height: 45,
                              //                 child: Center(
                              //                   child: Text(
                              //                     "PUBLISHED",
                              //                     style: TextStyle(
                              //                       color: Colors.black,
                              //                       fontWeight:
                              //                       FontWeight.bold,
                              //                       fontSize: 16.0,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //           SizedBox(width: 5),
                              //           Expanded(
                              //             child: isUnderReviewSelected
                              //                 ? InkWell(
                              //               onTap: () {
                              //                 isPublishedSelected = false;
                              //                 isUnderReviewSelected = true;
                              //                 setState(() {
                              //                   isPublishedSelected;
                              //                   isUnderReviewSelected;
                              //                 });
                              //               },
                              //               child: Container(
                              //                 height: 45,
                              //                 //width: 150,
                              //                 decoration: BoxDecoration(
                              //                   image: DecorationImage(
                              //                     image: AssetImage(
                              //                         'assets/images/selectedmenu.png'),
                              //                   ),
                              //                 ),
                              //                 child: Center(
                              //                   child: Text(
                              //                     "UNDER REVIEW",
                              //                     style: TextStyle(
                              //                       color: Colors.black,
                              //                       fontWeight:
                              //                       FontWeight.bold,
                              //                       fontSize: 16.0,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             )
                              //                 : InkWell(
                              //               onTap: () {
                              //                 isPublishedSelected = false;
                              //                 isUnderReviewSelected = true;
                              //                 setState(() {
                              //                   isPublishedSelected;
                              //                   isUnderReviewSelected;
                              //                 });
                              //               },
                              //               child: Container(
                              //                 height: 45,
                              //                 child: Center(
                              //                   child: Text(
                              //                     "UNDER REVIEW",
                              //                     style: TextStyle(
                              //                       color: Colors.black,
                              //                       fontWeight:
                              //                       FontWeight.bold,
                              //                       fontSize: 16.0,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     )
                              //   ]),
                              // )
                              //     : SizedBox(),
                              isBooksSelected
                                  ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10.0, right: 10.0),
                                  child: Stack(children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0.0),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width/2,
                                            height: 50,
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
                                        Padding(
                                          padding: const EdgeInsets.only(top:0.0,right: 5.0),
                                          child: DropdownButton<String>(
                                            iconSize: 30,
                                            hint: Padding(
                                              padding:
                                              const EdgeInsets.only(right: 5.0),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width/2 - 40,
                                                child: Text(selectedSort,
                                                    textAlign: TextAlign.right,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16.0,
                                                    )),
                                              ),
                                            ),
                                            underline: SizedBox(),
                                            items: categoryLists.map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (val) {
                                              selectedSort = val!;
                                              getBookData();
                                              setState(() {
                                                selectedSort;
                                              });
                                            },
                                          ),
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

                Positioned(
                    top: 10.sp,
                    left: 10.sp,
                    child: TouchableOpacity(

                        onTap: ()
                        {
                          print("test");

                          Navigator.pop(context);
                        },
                        child: Image.asset("assets/images/authorprofile_backbutton.png",height: 29.sp,width: 40.sp,))),
              ],
            ),
          ),
        ),
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
              var type = 0;
              var name = '';
              if (eventLists.isNotEmpty) {
                // print("### EVENT TYPE LENGTH ${eventTypeLists.length}");
                for (int i = 0; i < eventTypeLists.length; i++) {
                  // print("### EVENT TYPE ${eventTypeLists[i]['type']}");
                  // print("### EVENT List TYPE ${eventLists[index]['event_type']}");
                  if (eventTypeLists[i]['type'] ==
                      eventLists[index]['eventType']) {
                    type = eventTypeLists[i]['type'];
                    name = eventTypeLists[i]['name'];
                  }
                }
                // print("### type $type");
                // print("### name $name");

                // getEventTypeData(eventLists[index]['event_type']);

              }
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                        child: Container(
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              type == 0
                                  ? Icon(Icons.menu_book_sharp,
                                  color: Colors.white, size: 40)
                                  : type == 1
                                  ? Icon(Icons.accessibility,
                                  size: 40, color: Colors.white)
                                  :
                              //Image.asset('assets/images/events/eventticket_yellow_bookicon.png'):
                              // Image.asset('assets/images/events/eventticket_yellow_peopleicon.png')
                              Icon(Icons.group,
                                  size: 40, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${eventLists[index]['event_title']}",
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              "${eventLists[index]['event_desc']}",
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              "${eventLists[index]['createdDate']}",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              "${eventLists[index]['fromTime']} - ${eventLists[index]['toTime']}",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Container(
                                    //     height: 50,
                                    //     // width: 100,
                                    //     child: Image.asset(
                                    //         'assets/images/events/eventticket_yellow_editicon.png')),
                                    Text(
                                      //"50 MORE DAYS",
                                      '${daysBetween(DateTime.now(), DateFormat("yyyy-MM-dd").parse('${eventLists[index]['createdDate']}')).toString()} MORE DAYS',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // Container(
                      //   height: 135,
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       // Container(
                      //       //     height: 50,
                      //       //     // width: 100,
                      //       //     child: Image.asset(
                      //       //         'assets/images/events/eventticket_yellow_editicon.png')),
                      //       Text(
                      //         //"50 MORE DAYS",
                      //        '${daysBetween(DateTime.now(),DateFormat("yyyy-MM-dd").parse('${eventLists[index]['createdDate']}')).toString()} MORE DAYS',
                      //         style: TextStyle(
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.w600,
                      //           fontSize: 12.0,
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  )
                ]),
              );
            },
          );
        });
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
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
                child: TouchableOpacity(
                  onTap: (){
                    print("object");
                    showCustomBottomSheet(context,bookLists[index]);
                  },
                  child: Stack(children: [
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Container(
                          height: 80.sp,
                          width: 100.sp,
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
                          height: 30,
                          child: Row(
                            children: [
                              Icon(Icons.thumb_up, size: 12),
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
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
                              Icon(Icons.remove_red_eye, size: 12),
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
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
                                  bookLists[index]['topic'][0],
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
                ),
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
                  ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: CachedNetworkImage(
                            imageUrl:videoLists[index]['user_pic']==null? "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg": videoLists[index]['user_pic'],
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
                            Icon(Icons.thumb_up, size: 12),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
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
                            Icon(Icons.comment_rounded, size: 12),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
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
                        width: 100.sp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                videoLists[index]['video_title'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0.sp,
                                ),
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
                                videoLists[index]['song_name']==null?"Song Name": videoLists[index]['song_name'],
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
class TextFiledBio2 extends StatefulWidget {
  final controllerBio;
  final String bio;
  TextFiledBio2({Key? key, required this.controllerBio,required this.bio}) : super(key: key);

  @override
  State<TextFiledBio2> createState() => TextFiledBioState();
}

class TextFiledBioState extends State<TextFiledBio2> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('####### ${widget.bio}');
    widget.controllerBio.text = widget.bio;
    setState(() {
      widget.controllerBio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(

            fit: BoxFit.fill,
            image: AssetImage("assets/images/authorprofile_biobox.png"))),
        height: 150.sp,
        child: Center(
          child: TextField(
            controller: widget.controllerBio,
            maxLines: 1,
            style: TextStyle(
                color: ColorResources.colorBlack, fontWeight: FontWeight.w800),
            decoration: InputDecoration(
              // hintText: 'Enter a message',
              hintStyle: TextStyle(
                  color: ColorResources.colorBlack, fontWeight: FontWeight.w900),
              hintText: "   Bio",
             // filled: true,
              //fillColor: ColorResources.textfieldProfileBG,
              border: InputBorder.none,
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
              // enabledBorder: OutlineInputBorder(
              //   borderSide:
              //   BorderSide(color: ColorResources.colorBlack, width: 3.0),
              // ),
              // focusedBorder: OutlineInputBorder(
              //   borderSide:
              //   BorderSide(color: ColorResources.colorBlack, width: 3.0),
              // ),
              // suffixIcon: IconButton(
              //   onPressed: widget.controllerProfile.clear,
              //   icon: Icon(Icons.clear, size: 30, color: ColorResources.colorBlack),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}