// To parse this JSON data, do
//
//     final eventFlowModel = eventFlowModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EventFlowModel eventFlowModelFromMap(String str) => EventFlowModel.fromMap(json.decode(str));

String eventFlowModelToMap(EventFlowModel data) => json.encode(data.toMap());

class EventFlowModel {
  EventFlowModel({
    required this.eventTitle,
    required this.eventDesc,
    required this.fromTime,
    required this.toTime,
    required this.createdDate,
    required this.userId,
    required this.eventType,
    required this.readingLevel,
    required this.eventId,
  });

  final String eventTitle;
  final String eventDesc;
  final String fromTime;
  final String toTime;
  final String createdDate;
  final String userId;
  final int eventType;
  final int readingLevel;
  final String eventId;

  factory EventFlowModel.fromMap(Map<String, dynamic> json) => EventFlowModel(
    eventTitle: json["event_title"],
    eventDesc: json["event_desc"],
    fromTime: json["fromTime"],
    toTime: json["toTime"],
    createdDate: json["createdDate"],
    userId: json["user_id"],
    eventType: json["eventType"], readingLevel: json["readingLevel"], eventId: json["eventId"],
  );

  Map<String, dynamic> toMap() => {
    "event_title": eventTitle,
    "event_desc": eventDesc,
    "fromTime": fromTime,
    "toTime": toTime,
    "createdDate": createdDate,
    "user_id": userId,
    "eventType": eventType,
    "readingLevel":readingLevel,
    "eventId":eventId
  };
}
