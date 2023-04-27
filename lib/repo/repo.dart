import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:storily/model/FakeUserData.dart';
import 'package:storily/model/event_flow_model.dart';
import 'package:storily/model/event_type_model.dart';

class Repository{

  static TextEditingController eventTitleController=TextEditingController();
  static TextEditingController eventDescriptionController=TextEditingController();
  static  Map<DateTime, List<dynamic>>  eventMapOfData={};
  static List<EventFlowModel> eventListData=[];
  static List<EventFlowModel> eventListUpcomingData=[];
  static List<EventFlowModel> recommendedEventListData=[];
  static List<EventTypeModel> eventTypeRawData=[];
  static List<String> libraryDropDownData=["Check1 " ,"check2","check3"];
  static List<int> readingLevelList=[0,1,2,3,4,5,6,7,8,9,10,11,12,13];
  static int dropDownReadingValue=6;
   static String? dropdownValue;
   static String? dropdownValueLibrary;
   static List<Map> libraryListBooksDetails=[];
  static List<Map> libraryList=[];
  static List<Map> libraryFinalBooks=[];
 static List favouriteTopics = [];
  static List favouriteCategory = [];
 static List favouriteSubCategories = [];
  static String? errorMessage;


  List<String> generateTimeList() {
    List<String> timeList = [];
    for (int hour = 0; hour < 24; hour++) {
      for (int minute = 0; minute < 60; minute += 15) {
        String hourString = hour.toString().padLeft(2, '0');
        String minuteString = minute.toString().padLeft(2, '0');
        String timeString = '$hourString:$minuteString';
        timeList.add(timeString);
      }
    }
    return timeList;
  }


  getEventsFromFirebase() async
  {

    try {
      var currentUser= FirebaseAuth.instance.currentUser?.uid;

      var data = FirebaseFirestore.instance.collection("streaming_events").where("user_id",isEqualTo: currentUser);


      var event=await data.get();
        Repository.eventListData.clear();
        Repository.eventMapOfData.clear();

        event.docs.forEach((element) {
          if (element
              .data()
              .isNotEmpty) {


            Repository.eventListData.add(
                eventFlowModelFromMap(jsonEncode(element.data())));
           // print(element.data()["createdDate"]);
          }
        });

      return "true";
    }
 catch(e){
  if(e is FirebaseException)
    {
Repository.errorMessage=e.message;
  print(e.message);
      return e.message;
    }
  if(e is SocketException)
    {
//print("here");
Repository.errorMessage=e.message;

      return "No Internet";
    }

}
  }
  getUpcomingEventsFromFirebase() async
  {

    try {
      var cUser=FirebaseAuth.instance.currentUser?.uid;

      var data = FirebaseFirestore.instance.collection("streaming_events").doc("instance_events").collection("upcoming_events").where("user_id",isEqualTo:cUser );


      var event=await data.get();
      Repository.eventListUpcomingData.clear();
     // Repository.eventMapOfData.clear();

      event.docs.forEach((element) {
        if (element
            .data()
            .isNotEmpty) {


          Repository.eventListUpcomingData.add(
              eventFlowModelFromMap(jsonEncode(element.data())));
          // print(element.data()["createdDate"]);
        }
      });

      return "true";
    }
    catch(e){
      if(e is FirebaseException)
      {
        Repository.errorMessage=e.message;
        print(e.message);
        return e.message;
      }
      if(e is SocketException)
      {
//print("here");
        Repository.errorMessage=e.message;

        return "No Internet";
      }

    }
  }

  setEventDataToFirebase(EventFlowModel ef)async{
    try {
      var data = FirebaseFirestore.instance.collection("streaming_events").doc(ef.eventId);
      //var data1 = FirebaseFirestore.instance.collection("streaming_events").doc("instance_events").collection("upcoming_events").doc(ef.eventId);
      var data2 = FirebaseFirestore.instance.collection("streaming_events").doc("instance_events").collection("recommended_events").doc(ef.eventId);

      await data.set(ef.toMap());



      await data2.set(ef.toMap());
      return true;
    } catch(e){
      if(e is FirebaseException)
      {
        Repository.errorMessage=e.message;
       // print(e.message);
        return e.message;
      }
      if(e is SocketException)
      {
        //print("here");
        Repository.errorMessage=e.message;

        return "No Internet";
      }

    }


  }
  setEventRecommendedDataToFirebase(EventFlowModel ef)async{
    try {
     // var data = FirebaseFirestore.instance.collection("streaming_events").doc(ef.eventId);
      var data1 = FirebaseFirestore.instance.collection("streaming_events").doc("instance_events").collection("upcoming_events");
      //var data2 = FirebaseFirestore.instance.collection("streaming_events").doc("instance_events").collection("recommended_events").doc(ef.eventId);
var currentUserId=FirebaseAuth.instance.currentUser?.uid;

  //  var data2=FirebaseFirestore.instance.collection("users").doc(currentUserId).collection("attending_events");
      var data2=FirebaseFirestore.instance.collection("users").doc(currentUserId);
var myList=[ef.eventId];
//await data2.add({"event_id":ef.eventId});

      var check= await data2.get();
      if(check.exists)
        {
          if(check.data()!.containsKey("attending_events"))
            {
              await data2.update({"attending_events":FieldValue.arrayUnion(myList)});

            }
          else
          {
            await data2.set({"attending_events":myList});

          }
        }
      // else
      //   {
      //
      //   }



      await data1.add(ef.toMap());
      return true;
    } catch(e){
      if(e is FirebaseException)
      {
        Repository.errorMessage=e.message;
        // print(e.message);
        return e.message;
      }
      if(e is SocketException)
      {
        //print("here");
        Repository.errorMessage=e.message;

        return "No Internet";
      }

    }


  }
  Future<bool> deleteEventFromRecommended(id) async {
    try {
      var data2 = FirebaseFirestore.instance.collection("streaming_events").doc("instance_events").collection("recommended_events").doc(id);
   await  data2.delete();
      return true;
    } catch (e) {
      return false;
    }
  }
  getEventsTypeFromFirebase() async
  {

    try {
      var data = FirebaseFirestore.instance.collection("event_type_static");


      var event=await data.get();
    //  Repository.eventListData.clear();
     // Repository.eventMapOfData.clear();
      Repository.eventTypeRawData.clear();
      event.docs.forEach((element) {
        if (element
            .data()
            .isNotEmpty) {
          print(jsonEncode(element.data()));
          //EventFlowModel.fromJson(element)
          Repository.eventTypeRawData.add(
              eventTypeModelFromMap(jsonEncode(element.data())));
        //   // print(element.data()["createdDate"]);
         }
      });

      return "true";
    }
    catch(e){
      if(e is FirebaseException)
      {
        Repository.errorMessage=e.message;
        print(e.message);
        return e.message;
      }
      if(e is SocketException)
      {
//print("here");
        Repository.errorMessage=e.message;

        return "No Internet";
      }

    }
  }
  getRecommendedEventsFromFirebase(int readingLevel) async
  {

    try {
      //var data = FirebaseFirestore.instance.collection("streaming_events").where("readingLevel",isLessThanOrEqualTo:readingLevel );
      var currentUserId=FirebaseAuth.instance.currentUser?.uid;
      var data1 = FirebaseFirestore.instance.collection("streaming_events").doc("instance_events").collection("recommended_events").where("user_id",isEqualTo:currentUserId ).where("readingLevel",isLessThanOrEqualTo: readingLevel);

      //await data.add(ef.toMap());
      //var event=await data.get();
      Repository.recommendedEventListData.clear();
     // Repository.eventMapOfData.clear();
//        List<EventFlowModel> filterList=[];
//
//       event.docs.forEach((element) {
//         if (element
//             .data()
//             .isNotEmpty) {
//
//
//           filterList.add(
//               eventFlowModelFromMap(jsonEncode(element.data())));
//           // print(element.data()["createdDate"]);
//         }
//       });
//
// filterList.forEach((element) async {
//
//  await data1.add(element.toMap());
//
// });
var event2 =await data1.get();
      event2.docs.forEach((element) {
        if (element
            .data()
            .isNotEmpty) {


          Repository.recommendedEventListData.add(
              eventFlowModelFromMap(jsonEncode(element.data())));
          // print(element.data()["createdDate"]);
        }
      });

      return "true";
    }
    catch(e){
      if(e is FirebaseException)
      {
        Repository.errorMessage=e.message;
        print(e.message);
        return e.message;
      }
      if(e is SocketException)
      {
//print("here");
        Repository.errorMessage=e.message;

        return "No Internet";
      }

    }
  }

  getLibraryBooksFromFirebase() async
  {

    try {
      print("here");
      var cUser=FirebaseAuth.instance.currentUser?.uid;
      ///pass this

      var data =   FirebaseFirestore.instance.collection("users").doc(cUser);//FakeUserData.fakeKidUserId
      var data2= FirebaseFirestore.instance.collection("booksentity");
      Repository.libraryListBooksDetails.clear();
      var event=await data.get();
      var rawDta = jsonEncode(event["books_owned"]);
      List dto=jsonDecode(rawDta);
      if(dto.isEmpty)
      {
        return "false";
      }
      //Repository.libraryBooksOwnedData=dto;
      else {
        for (var i in dto) {
          var bookdata = await data2.doc(i.toString()).get();
          print("data");
          print(bookdata);
          if (bookdata.data() != null) {
            var raww = jsonEncode(bookdata.data());

            Map dataBooks = jsonDecode(raww);
            //List
            Repository.libraryListBooksDetails.add(dataBooks);
            //print(dataListBooksDetails.length);
          }
        }
      }
      //print( Repository.libraryBooksOwnedData.length);
    //  Repository.eventListUpcomingData.clear();
      // Repository.eventMapOfData.clear();

      // event.docs.forEach((element) {
      //   if (element
      //       .data()
      //       .isNotEmpty) {
      //
      //
      //     Repository.eventListUpcomingData.add(
      //         eventFlowModelFromMap(jsonEncode(element.data())));
      //     // print(element.data()["createdDate"]);
      //   }
      // });

      return "true";
    }
    catch(e){
      if(e is FirebaseException)
      {
        Repository.errorMessage=e.message;
        print(e.message);
        return e.message;
      }
      if(e is SocketException)
      {
//print("here");
        Repository.errorMessage=e.message;

        return "No Internet";
      }

    }
  }

  getThisMonthBooksFromFirebase() async
  {

    try {
      //print("chek");
      var cUser=FirebaseAuth.instance.currentUser?.uid;

      var data =   FirebaseFirestore.instance.collection("users").doc(cUser);//FakeUserData.fakeKidUserId
      var data2= FirebaseFirestore.instance.collection("booksentity");
      var data3= FirebaseFirestore.instance.collection("monthly_picks_books");

      Repository.libraryList.clear();
      Repository.libraryFinalBooks.clear();
      Repository.favouriteTopics.clear();
      Repository.favouriteCategory.clear();
      Repository.favouriteSubCategories.clear();
      var event=await data.get();
      //print(event['books_read']);
      List dto=event.data()!['books_read'];
      String readingLevel= event.data()!['reading_level'].toString();
      List bookId=[];
      var monthlyBookData=await data3.get();

      monthlyBookData.docs.forEach((element) {

        print(element.data()["books_id"]);
        if(element.data() !=null)
          {
         //   bookId.add();
        bookId=element.data()["books_id"];
          }

      });
      //print("after this");
      //print(bookId);
      for(var i in bookId)
      {
        print(i.toString().trimLeft());
        var bookdata=await data2.doc(i.toString().trim()).get();
        if(bookdata.data() != null ) {
        //  print("chcek");
          var raww = jsonEncode(bookdata.data());
         // print("che");
          print(raww);
          Map dataBooks = jsonDecode(raww);

    // print(dataBooks['reading_level']+"testingg");
           if(dataBooks['reading_level']==readingLevel) {
             Repository.libraryFinalBooks.add(dataBooks);
            // print("added or not");
           }
        }
      }

      int ii=0;
      print("length ="+dto.length.toString());
      if(dto.isEmpty)
      {
        return "false";
      }
      //Repository.libraryBooksOwnedData=dto;
      else {
        List filteredList = dto.where((element) {
          DateTime elementDate = element["reading_date"].toDate();
          DateTime now = DateTime.now();
          Duration difference = now.difference(elementDate);
          return difference.inDays <= 7;
        }).take(3).toList();

        /// filtered list contains last 7 days elements  based on reading date of book_read and is limited to 3
        print(filteredList.length.toString() + "filteredLength");
        for (var i in filteredList) {
          var bookdata = await data2.doc(i['book_id'].toString()).get();
          if (bookdata.data() != null) {
            var raww = jsonEncode(bookdata.data());
            print("che");
            print(raww);
            Map dataBooks = jsonDecode(raww);
//List
            //print(i["reading_date"]);


            Repository.libraryList.add(dataBooks);
            print(Repository.libraryList);
          }
        }
        print(Repository.libraryList.length.toString() + "testtt");
        List filterToApplyList = [];

        for (var i in Repository.libraryList) {
          print(i['topic']);
         // favouriteTopics.add(i['topic']);
         // favouriteTopics=i["topic"];
          for(var j in i['topic'])
            {
              favouriteTopics.add(j.toString());
            }
            print(i['category_main']);
            favouriteCategory.add(i['category_main']);
            print(i['category_sub']);
            favouriteSubCategories.add(i['category_sub']);
            print(i['reading_level']);
        }
        print(favouriteTopics);
        print(favouriteCategory);
        print(favouriteSubCategories);
        favouriteTopics=favouriteTopics.toSet().toList();
        favouriteCategory=favouriteCategory.toSet().toList();
        favouriteSubCategories=favouriteSubCategories.toSet().toList();
        for(var i in favouriteTopics)
        {
          var collectionRef= await data2.where('topic',arrayContains: i).get();
          collectionRef.docs.forEach((element) {

          print(element.data());
          if(element.data() != null)
            if (!Repository.libraryFinalBooks.contains(element.data())) {
              Repository.libraryFinalBooks.add(element.data());
          }


          });

        }
        for(var i in favouriteCategory)
        {
          var collectionRef= await data2.where('category_main',isEqualTo: i).limit(3).get();
          collectionRef.docs.forEach((element) {

            print(element.data());
            if(element.data() != null)
              if (!Repository.libraryFinalBooks.contains(element.data())) {
                Repository.libraryFinalBooks.add(element.data());
              }

          });

        }
        for(var i in favouriteSubCategories)
        {
          var collectionRef= await data2.where('category_sub',isEqualTo: i).limit(3).get();
          collectionRef.docs.forEach((element) {

            print(element.data());
            if(element.data() != null)
              if (!Repository.libraryFinalBooks.contains(element.data())) {
                Repository.libraryFinalBooks.add(element.data());
              }

          });

        }

      }
      //print( Repository.libraryBooksOwnedData.length);
      //  Repository.eventListUpcomingData.clear();
      // Repository.eventMapOfData.clear();

      // event.docs.forEach((element) {
      //   if (element
      //       .data()
      //       .isNotEmpty) {
      //
      //
      //     Repository.eventListUpcomingData.add(
      //         eventFlowModelFromMap(jsonEncode(element.data())));
      //     // print(element.data()["createdDate"]);
      //   }
      // });
      // print("before");
      // print(Repository.libraryFinalBooks.length);
      Set<Map<dynamic, dynamic>> set = Set<Map<dynamic, dynamic>>.from(Repository.libraryFinalBooks);
      print(set.toList().length);
      print("after");
      Repository.libraryFinalBooks=Repository.libraryFinalBooks.toSet().toList();
       print(Repository.libraryFinalBooks.length);
      return "true";
    }
    catch(e){
      if(e is FirebaseException)
      {
        Repository.errorMessage=e.message;
        print(e.message);
        return e.message;
      }
      if(e is SocketException)
      {
//print("here");
        Repository.errorMessage=e.message;
        return "No Internet";
      }

    }
  }
  static List libraryFeaturedAuthors=[];
  getFeaturedAuthors()async
  {
    var cUser=FirebaseAuth.instance.currentUser?.uid;
    try{
      var data =   FirebaseFirestore.instance.collection("users").doc(cUser);//FakeUserData.fakeKidUserId
      var data2= FirebaseFirestore.instance.collection("book_authors");
      var data3= FirebaseFirestore.instance.collection("monthly_picks_authors");
      var dto = await  data3.get();
      List monthlyAuthorsId=[];
      Repository.libraryFeaturedAuthors.clear();
      dto.docs.forEach((element) {
        monthlyAuthorsId=element.data()['authors_id'];
      });
      print(monthlyAuthorsId);
      for(var i in monthlyAuthorsId)
      {
        print(i.toString().trimLeft());
        var authorData=await data2.doc(i.toString().trim()).get();
        if(authorData.data() != null ) {
          //  print("chcek");
          var raww = jsonEncode(authorData.data());
          // print("che");
          print(raww);
          Map dataBooks = jsonDecode(raww);
          print(dataBooks);
  //List
          //print(i["reading_date"]);

          // print(dataBooks['reading_level']+"testingg");

            Repository.libraryFeaturedAuthors.add(dataBooks);
            // print("added or not");

        }
      }

      return "true";
      }catch(e) {
        if (e is FirebaseException) {
          Repository.errorMessage = e.message;
          print(e.message);
          return e.message;
        }
        if (e is SocketException) {
    //print("here");
          Repository.errorMessage = e.message;

          return "No Internet";
        }
      }
  }

  static List libraryBooksNotOwned=[];
  getRecommendedBooksNotOwned()async
  {
    var cUser=FirebaseAuth.instance.currentUser?.uid;
    try{
      var data =   FirebaseFirestore.instance.collection("users").doc(cUser);//FakeUserData.fakeKidUserId
      var data2=  FirebaseFirestore.instance.collection("booksentity");

      var event=await data.get();
      var rawDta = jsonEncode(event["books_owned"]);
      List dto=jsonDecode(rawDta);
      Repository.libraryBooksNotOwned.clear();
      if(dto.isEmpty)
      {
        return "false";
      }
      //Repository.libraryBooksOwnedData=dto;
      else {
        var bookdata = await data2.get();
        List<String> temBookId=[];

        //print(i);
        print("data2");
        bookdata.docs.forEach((element) {
          print(element.data());
          var raww = jsonEncode(element.data());

          Map dataBooks = jsonDecode(raww);

          print(element.data()['book_id']);
          if(element.data()['book_id']!=null) {
            // print(i);
            if (!dto.contains(element.data()['book_id'])) {
              print("from here");
              print(element.data()['book_id']);
              //
              if (!temBookId.contains(element.data()['book_id'])) {
                print("true1");
                temBookId.add(element.data()['book_id']);
                Repository.libraryBooksNotOwned.add(dataBooks);
              }
            }
          }else
            {
              print("false");
            }
        });

        print("tempbooks"+Repository.libraryBooksNotOwned.length.toString());
        Repository.libraryBooksNotOwned =
            Repository.libraryBooksNotOwned.toSet().toList();
        print(Repository.libraryBooksNotOwned);
        print("not owned " + Repository.libraryBooksNotOwned.length.toString());
        return "true";
      }
    }catch(e) {
      if (e is FirebaseException) {
        Repository.errorMessage = e.message;
        print(e.message);
        return e.message;
      }
      if (e is SocketException) {
  //print("here");
        Repository.errorMessage = e.message;

        return "No Internet";
      }
    }
  }
  static List<String> libraryCategoriesBooks=[];
  Future getCategories()async{
    try{
      var data= await FirebaseFirestore.instance.collection("categories").get();
      Repository.libraryCategoriesBooks.clear();
      data.docs.forEach((element) {
      if(!Repository.libraryCategoriesBooks.contains(element.data()['name'].toString())){
        Repository.libraryCategoriesBooks.add(element.data()['name'].toString());
      }
  });

    print(Repository.libraryCategoriesBooks);
   }catch(e){
    if (e is FirebaseException) {
      Repository.errorMessage = e.message;
      print(e.message);
      return e.message;
    }
    if (e is SocketException) {
//print("here");
      Repository.errorMessage = e.message;

      return "No Internet";
    }

  }

}


}