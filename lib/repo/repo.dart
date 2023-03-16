import 'package:flutter/cupertino.dart';

class Repository{

  static TextEditingController eventTitleController=TextEditingController();
  static TextEditingController eventDescriptionController=TextEditingController();

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

}