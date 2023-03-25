import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
  static List<int> readingLevelList=[0,1,2,3,4,5,6,7,8,9,10,11,12,13];
  static int dropDownReadingValue=6;
   static String? dropdownValue;

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
      var data = FirebaseFirestore.instance.collection("streaming_events");


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
      var data = FirebaseFirestore.instance.collection("streaming_events").doc("instance_events").collection("upcoming_events");


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
      var data1 = FirebaseFirestore.instance.collection("streaming_events").doc("instance_events").collection("upcoming_events").doc(ef.eventId);
      var data2 = FirebaseFirestore.instance.collection("streaming_events").doc("instance_events").collection("recommended_events").doc(ef.eventId);

      await data.set(ef.toMap());

      if(DateTime.parse(ef.createdDate).isAfter(DateTime.now()))
      {await data1.set(ef.toMap());}

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

      var data1 = FirebaseFirestore.instance.collection("streaming_events").doc("instance_events").collection("recommended_events").where("readingLevel",isLessThanOrEqualTo: readingLevel);

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
}