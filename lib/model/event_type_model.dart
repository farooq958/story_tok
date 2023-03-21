

import 'package:meta/meta.dart';
import 'dart:convert';

EventTypeModel eventTypeModelFromMap(String str) => EventTypeModel.fromMap(json.decode(str));

String eventTypeModelToMap(EventTypeModel data) => json.encode(data.toMap());

class EventTypeModel {
  EventTypeModel({
    required this.name,
    required this.type,
  });

  final String name;
  final int type;

  factory EventTypeModel.fromMap(Map<String, dynamic> json) => EventTypeModel(
    name: json["name"],
    type: json["type"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "type": type,
  };
}
