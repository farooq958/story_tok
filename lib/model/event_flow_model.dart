class EventFlowModel{
  EventFlowModel({
    required this.eventTitle,
    required this.eventDescription,
   // required this.data,
    required this.fromTime,
    required this.toTime,
    required this.eventDate

  });
 final String eventTitle;
  final String eventDescription;

  final String fromTime;
  final String toTime;
  final DateTime eventDate;


}