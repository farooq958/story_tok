import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:storily/Utils/app_utils.dart';
import 'package:storily/repo/repo.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../cubit/load_main_data_cubit.dart';
import '../../cubit/load_recommended_events_cubit.dart';
import '../../cubit/selected_date_event_cubit.dart';
import '../../model/event_flow_model.dart';
import '../../screens/schedule_event_flow_screens/add_shedule_event.dart';
import '../PageTransitions/slide_page_transition.dart';
import '../app_colors.dart';

class UpcomingWidget extends StatelessWidget {
  const UpcomingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoadMainDataCubit, List<EventFlowModel>>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, eventFlowStateData) {
        var sEvents=[];
        if(eventFlowStateData.isNotEmpty) {
          sEvents = getUpcomingSortedEvents(eventFlowStateData);
        }
        if(sEvents.isEmpty) return Padding(
          padding:  EdgeInsets.only(top: 30.0.sp),
          child: Center(child: Text("No Upcoming Events ",style: GoogleFonts.lexend(fontWeight: FontWeight.w700),)),
        );
        else
          return ListView.separated(
            shrinkWrap: true,
            itemCount: sEvents.length,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context,index) {
              return Container(

                  margin: EdgeInsets.only(left: 20.sp,right: 20.sp),
                  child: Stack(
                    children: [
                      Image.asset("assets/images/eventticket_yellow_base.png",fit: BoxFit.fitWidth,),
                      Positioned(
                          top:0,
                          right: 0,
                          bottom: 0,
                          child: Image.asset("assets/images/eventticket_yellow_peopleicon.png")),
                      Positioned.fill(
                        top:0,
                        right: 0,
                        left: 50.sp,
                        //right: 0,
                        bottom: 0,
                        child: UnconstrainedBox(

                          child: SizedBox(
                            height: 100.sp,
                            width: 200.sp,
                            child: Center(
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[

                                  Text(sEvents[index].eventTitle,style: GoogleFonts.lexend(fontSize:20.sp,fontWeight: FontWeight.w600),),
                                  Text(sEvents[index].createdDate,style: GoogleFonts.lexend(fontSize:15.sp,fontWeight: FontWeight.w600),),
                                  Text("${sEvents[index].fromTime}-${sEvents[index].toTime} ",style: GoogleFonts.lexend(fontSize:14.sp,fontWeight: FontWeight.w600),),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 10,
                          bottom: 10,
                          child:
                          Text("${daysBetween(DateTime.now(), DateFormat("yyyy-MM-dd").parse('${sEvents[index].createdDate}')).toString()} MORE DAYS",style: GoogleFonts.lexend(fontSize:8.sp,fontWeight: FontWeight.w300),)
                      ),
                      Positioned(
                        //top:0,
                          right: 0,
                          bottom: 0,
                          left: 0,
                          child: Image.asset("assets/images/eventticket_yellow_editicon.png")),


                    ],
                  ));
            }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 5.sp,); },
          );
      },
    );
  }

  getUpcomingSortedEvents(List<EventFlowModel> events) {


    DateTime currentDateTime = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);

    List<DateTime> dates = events.map((event) => DateTime.parse(event.createdDate)).toList();
    ///sorting dates quick sort dart algo
    dates.sort((a, b) => a.compareTo(b));
    print(dates[0]);
    //print(currentDateTime);
    List<EventFlowModel> streamedUpcomingEvents=[];
    ///currently sorted events logic
    for(int i=0;i<dates.length;i++)
    {
      if(DateTime.parse(events[i].createdDate).isAfter(currentDateTime)) {
        streamedUpcomingEvents.add(events[i]);
      }
    }
    streamedUpcomingEvents.sort((a,b)=> DateTime.parse(a.createdDate).compareTo(DateTime.parse(b.createdDate)));
    return streamedUpcomingEvents;
  }
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}

class StreamingCurrentEventWidget extends StatelessWidget {
  const StreamingCurrentEventWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoadMainDataCubit, List<EventFlowModel>>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, eventFlowStateData) {
        var sEvents=[];
        if(eventFlowStateData.isNotEmpty) {
          sEvents = getCurrentStreamedEvents(eventFlowStateData);
        }
        if(sEvents.isEmpty) return Padding(
          padding:  EdgeInsets.only(top: 30.0.sp),
          child: Container(
              color: Color(0xff),
              child: Center(child: Text("No Currently streamed  Events ",style: GoogleFonts.lexend(fontWeight: FontWeight.w700),))),
        );
        else
          return ListView.separated(
            shrinkWrap: true,
            itemCount: sEvents.length,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context,index) {
              return Container(

                  margin: EdgeInsets.only(left: 20.sp,right: 20.sp),
                  child: Stack(
                    children: [
                      Image.asset("assets/images/eventticket_yellow_base.png",fit: BoxFit.fitWidth,),
                      Positioned(
                          top:0,
                          right: 0,
                          bottom: 0,
                          child: Image.asset("assets/images/eventticket_yellow_peopleicon.png")),
                      Positioned.fill(
                        top:0,
                        right: 0,
                        left: 50.sp,
                        //right: 0,
                        bottom: 0,
                        child: UnconstrainedBox(

                          child: SizedBox(
                            height: 100.sp,
                            width: 200.sp,
                            child: Center(
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[

                                  Text(sEvents[index].eventTitle,style: GoogleFonts.lexend(fontSize:20.sp,fontWeight: FontWeight.w600),),
                                  Text(sEvents[index].createdDate,style: GoogleFonts.lexend(fontSize:15.sp,fontWeight: FontWeight.w600),),
                                  Text("${sEvents[index].fromTime}-${sEvents[index].toTime} ",style: GoogleFonts.lexend(fontSize:14.sp,fontWeight: FontWeight.w600),),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 10,
                          bottom: 10,
                          child:
                          Text("${daysBetween(DateTime.now(), DateFormat("yyyy-MM-dd").parse('${sEvents[index].createdDate}')).toString()} MORE DAYS",style: GoogleFonts.lexend(fontSize:8.sp,fontWeight: FontWeight.w300),)
                      ),
                      Positioned(
                          top:0,
                          right: 5.sp,
                          bottom: 60.sp,
                          //left: 0,
                          child: TouchableOpacity(
                            onTap: (){
  AppUtils.showCustomSnackBar(context: context, message: "To be Evaluated", color: AppColors.containerYellowColor, duration: Duration(seconds: 1));
                              print("joined");
                            },
                            child: UnconstrainedBox(
                              child: Container(
                                height: 35.sp,
                                width: 50.sp,
                                decoration: BoxDecoration(
                                    color: Color(0xffE8D9B9),
                                    borderRadius: BorderRadius.circular(10.sp),
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(
                                  child: Text("Join",style: GoogleFonts.lexend(
                                      fontSize:15.sp,
                                      fontWeight: FontWeight.w700,color: Colors.green),),
                                ),
                              ),
                            ),
                          )

                      ),


                    ],
                  ));
            }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 5.sp,); },
          );
      },
    );
  }


  getCurrentStreamedEvents(List<EventFlowModel> events) {

    // events.forEach((element) {print(element.createdDate);});
    // print("object");
    DateTime currentDateTime = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);

    List<DateTime> dates = events.map((event) => DateTime.parse(event.createdDate)).toList();
    ///sorting dates quick sort dart algo
    dates.sort((a, b) => a.compareTo(b));
    print(dates[0]);
    //print(currentDateTime);
    List<EventFlowModel> streamedEvents=[];
    ///currently sorted events logic
    for(int i=0;i<dates.length;i++)
    {
      if(DateTime.parse(events[i].createdDate).isAtSameMomentAs(currentDateTime)) {
        streamedEvents.add(events[i]);
      }
    }

    return streamedEvents;
  }
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}

class RecommendWidget extends StatelessWidget {
  const RecommendWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        BlocConsumer<LoadMainDataCubit, List<EventFlowModel>>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return BlocConsumer<LoadRecommendedEventsCubit, List<EventFlowModel>>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, recommendedList) {
            return Container(
              height: 280.sp,
              width: 1.sw,
              margin: EdgeInsets.symmetric(horizontal: 20.sp),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  border: Border.all(color: Colors.black,width: 3.0),
                  borderRadius: BorderRadius.circular(15.sp)
              ),
              child: Row(
                children: [
                  Expanded(
                    child:recommendedList.isEmpty? Center(child: Text("No Events",style: GoogleFonts.lexend(fontWeight: FontWeight.w700),)):ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: recommendedList.length,
                      shrinkWrap: false,
                      padding: EdgeInsets.only(left: 20.sp,right: 20.sp),

                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return Center(child:
                        TouchableOpacity(
                          onTap: (){

                            showDialog(context: context, builder: (context){
                              return AlertDialog(content: Text("Do you want to add this event to your list? ",style: GoogleFonts.lexend(color: Colors.blueGrey),),actions: [
                                
                                ElevatedButton(
                                    style: ButtonStyle(backgroundColor:MaterialStateColor.resolveWith((states) => AppColors.containerYellowColor)),
                                    onPressed: () async {
                                   var send=await Repository().setEventDataToFirebase(recommendedList[index]);
                                   if(send==true)
                                   {
                                     AppUtils.showCustomSnackBar(context: context, message: "Event Added Successfully", color: Colors.green, duration: const Duration(milliseconds: 1000),);
                           context.read<LoadMainDataCubit>().getEventData();
                                     context.read<LoadRecommendedEventsCubit>().getRecommendedEventData(readingLevel: 5);
                                    // Navigator.pushReplacement(context, CustomSlidePageRoute(child: Confirmation2()));

                                   }
                                   else
                                   {
                                     //print(send);
                                     AppUtils.showCustomSnackBar(context: context, message: "something went wrong please try again later", color: Color(0xfff6c33f), duration: const Duration(milliseconds: 1200),);
                                   }
                                  Navigator.pop(context);
                                },
                                child: Text("Yes",style: GoogleFonts.lexend(color: Colors.blueGrey))),
                                SizedBox(width: 20.sp,),
                                ElevatedButton(onPressed: () {Navigator.pop(context);  },
                                    style: ButtonStyle(backgroundColor:MaterialStateColor.resolveWith((states) => AppColors.rectangleColor)),
                                child: Text("Cancel",style: GoogleFonts.lexend(color: Colors.blueGrey),)),
                                SizedBox(width: 20.sp,),
                                
                              ],);

                            });

                          },
                          child: Container(


                            height: 130.sp,
                            width: 100.sp,
                            // color: Colors.red,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 2.0),
                                color: AppColors.rectangleColor,
                                borderRadius: BorderRadius.circular(5.sp)
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                SizedBox(height: 5.sp,),
                                Center(child: Text("EventTitle",style: GoogleFonts.lexend(fontWeight: FontWeight.w900,fontSize: 12.sp),)),

                                Center(child: Text(recommendedList[index].eventTitle,style: GoogleFonts.lexend(fontWeight: FontWeight.w500,fontSize: 12.sp),))
                                ,
                                SizedBox(height: 5.sp,),
                                Center(child: Text("Date",style: GoogleFonts.lexend(fontWeight: FontWeight.w900,fontSize: 12.sp),)),
                                Center(child: Text(recommendedList[index].createdDate,style: GoogleFonts.lexend(fontWeight: FontWeight.w500,fontSize: 12.sp),))
                                ,SizedBox(height: 5.sp,),
                                Center(child: Text("Time",style: GoogleFonts.lexend(fontWeight: FontWeight.w900,fontSize: 12.sp),)),
                                Center(child: Text("${recommendedList[index].fromTime}-${recommendedList[index].toTime}",style: GoogleFonts.lexend(fontWeight: FontWeight.w500,fontSize: 12.sp),))

                              ],),

                          ),
                        ));
                      }, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 10.sp,); },),
                  ),
                ],
              ),


            );
          },
        );
  },
),
        Positioned(
            top: 0,

            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp),
              height: 45.sp,
              width: 1.sw/1.14,
              padding: EdgeInsets.only(left: 5.sp,top: 5.sp),
              decoration: BoxDecoration(
                  border: Border.all(color:Colors.black,width: 2.0),
                  color: AppColors.containerYellowColor ,
                  borderRadius: BorderRadius.circular(15.sp)

              ),
              child: Text("RECOMMENDED",style: GoogleFonts.lexend(fontWeight: FontWeight.w700,fontSize: 20.sp),),

            )),
      ],
    );
  }
}


class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDay=DateTime.now();
  DateTime _selectedDay=DateTime.now();
  GlobalKey selectedDayKey= new GlobalKey();
  GlobalKey tableKey= new GlobalKey();

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }
  // Map<DateTime, List<dynamic>> events = {
  //   DateTime(2023, 3, 15): ['Event A', 'Event B'],
  //   DateTime(2023, 3, 20): ['Event C'],
  //   DateTime(2023, 3, 25): ['Event D', 'Event E', 'Event F'],
  // };
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LoadMainDataCubit, List<EventFlowModel>>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, eventFlowData) {
        return BlocConsumer<SelectedDateEventCubit, DateTime>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, selectedDateBuilder) {
            var eventListLength=Repository.eventListData.length;
            for(var i=0;i<eventListLength;i++)
            {
              DateTime parsedDate = DateTime.parse(Repository.eventListData[i].createdDate);
              var dateToPass=DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
              Repository.eventMapOfData.addAll({dateToPass:[Repository.eventTitleController.text] });
            }

            return TableCalendar(
              key: tableKey,

              enabledDayPredicate: (d){
                return true;
              },
              availableGestures: AvailableGestures.horizontalSwipe,
              eventLoader: (d)
              {
                //print(d);
                String formattedDate = DateFormat('yyyy-MM-dd').format(d);
                //print("formatted date $formattedDate");
                DateTime dateTime = DateTime.parse(formattedDate);
                var dateToPass= DateTime(dateTime.year, dateTime.month, dateTime.day);
                // print("date check"+dateTime.toString());
                // print(Repository.eventMapOfData[dateTime]);
                return Repository.eventMapOfData[dateToPass]??[];
              },


              headerStyle: HeaderStyle(
                titleCentered: false,
                formatButtonVisible: true,
                headerPadding: EdgeInsets.only(bottom: 30),
                leftChevronIcon: Icon(Icons.arrow_back_ios),
                rightChevronIcon: Icon(Icons.arrow_forward_ios),
                titleTextStyle: TextStyle(fontSize: 18),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),),
              daysOfWeekHeight: 40.sp,
              rowHeight: 30.sp,
              focusedDay: selectedDateBuilder,
              selectedDayPredicate: (day) => isSameDay(selectedDateBuilder, day),
              onDaySelected: (selectedDay, focusedDay) {
                // final RenderBox dayNumberBox =
                // selectedDayKey.currentContext!.findRenderObject() as RenderBox;
                // final RenderBox tableBox =
                // tableKey.currentContext!.findRenderObject() as RenderBox; // get the RenderBox of the Table Calendar widget
                // final dayNumberOffset = dayNumberBox
                //     .localToGlobal(Offset.zero);
                // final tableOffset = tableBox
                //     .localToGlobal(Offset.zero);
                // final double height = dayNumberBox.size.height;
                // print(dayNumberOffset.dy);
                // final double width = dayNumberBox.size.width;
                // final offset = Offset(dayNumberOffset.dx, dayNumberOffset.dy);
                // final offset2 = Offset(tableOffset.dx, tableOffset.dy);
                // print(focusedDay);
                context.read<SelectedDateEventCubit>().setDate(selectedDay);
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  selectedDayKey=GlobalKey();
                });

              },
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              availableCalendarFormats: const {
                CalendarFormat.month: '',
              },
              headerVisible: false,

              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context,date,_){
                  return TouchableOpacity(
                    onTap: (){

                      showGeneralDialog(
                        barrierDismissible: true,
                        barrierColor: Colors.transparent,
                        barrierLabel: "",
                        transitionDuration: Duration(milliseconds: 200),
                        context: context,
                        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {

                          final RenderBox dayBox = selectedDayKey.currentContext!.findRenderObject() as RenderBox;
                          final Offset dayPosition = dayBox.localToGlobal(Offset.zero);
                          // final double dialogX = dayPosition.dx + dayBox.size.width / 2 - 30;
                          // final double dialogY = dayPosition.dy - 30;
                          return Stack(
                            children: [
                              Positioned(
                                top:dayPosition.dy-100.sp,
                                left:dayPosition.dx-dayBox.size.width*2.1.sp,
                                // bottom: 0,
                                //right: 0,
                                child: Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.symmetric(horizontal: 100.sp),
                                  child: Stack(
                                    children: <Widget>[

                                      Image.asset('assets/images/speechbubble_yellow_base.png',fit: BoxFit.fitWidth,height: 130.sp,width: 130.sp,),

                                      Positioned(
                                        top:0,
                                        right: 1.sw/2,
                                        bottom: 1.sp,
                                        left: 0,

                                        child: SizedBox(
                                          height: 50.sp,
                                          width: 50.sp,
                                          child: ListView(
                                            padding: EdgeInsets.symmetric(vertical: 5.sp),
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            children: <Widget>[
                                              SizedBox(height: 30.sp,),
                                              Stack(
                                                children: [
                                                  Image.asset('assets/images/speechbubble_yellow_text.png',height: 50.sp,width: 100.sp,),
                                                  ///yesTapped
                                                  Positioned(
                                                    top: 10.sp,
                                                    right: 0,
                                                    left: 0,
                                                    bottom: 0,
                                                    child: TouchableOpacity(
                                                        onTap: () async {
                                                          Repository.eventTitleController.clear();
                                                          Repository.eventDescriptionController.clear();


                                                          Navigator.pushReplacement(context, CustomSlidePageRoute(child: AddEventScreenScheduleScreen()));

                                                          await Repository().getEventsTypeFromFirebase();
                                                        },

                                                        child: Image.asset('assets/images/speechbubble_yellow_button.png',height: 50.sp,)),)
                                                ],
                                              ),




                                            ],
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ); },
                      );
                    },
                    child: Container(
                      key: selectedDayKey,
                      width: 40.sp,
                      height: 40.sp,

                      //margin: EdgeInsets.symmetric(horizontal: 12.sp),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xfff6c33f),
                        border: Border.all(color: Colors.black,style: BorderStyle.solid,width: 2),
                      ),
                      child: Center(
                        child: Text(
                          date.day.toString(),
                          style: GoogleFonts.lexend(
                            fontSize: 16.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );

                },
                dowBuilder: (context, day) {
                  return    SizedBox.shrink();

                  // return Container(
                  //
                  //   decoration: BoxDecoration(
                  //     color:
                  //         Colors.yellow
                  //         ,
                  //    // borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Center(
                  //     child: FittedBox(
                  //       child: Text(
                  //         DateFormat.E().format(day),
                  //         style: GoogleFonts.lexend(
                  //           fontSize: 20.sp,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // );


                },
                defaultBuilder: (context, date, _) {
                  return Container(
                    width: 40.sp,
                    height: 40.sp,
                    //margin: EdgeInsets.symmetric(horizontal: 12.sp),
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      // border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: GoogleFonts.lexend(
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
                markerBuilder: (context, date, _events) {
                  // print(date); ///null
                  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                  DateTime dateTime = DateTime.parse(formattedDate);
                  var dateToPass= DateTime(dateTime.year, dateTime.month, dateTime.day);

                  if (Repository.eventMapOfData[dateToPass] != null && Repository.eventMapOfData[dateToPass]!.isNotEmpty) {
                    // print("here");
                    return Positioned(
                      right: 1,
                      bottom: 1,
                      child: Icon(Icons.fiber_manual_record, size: 10,color: dateTime.isBefore(DateTime.now())?Colors.red: Colors.green,),
                    );
                  }
                  return null;
                },


              ),  firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),


              calendarStyle: CalendarStyle(
                //  cellMargin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                //cellPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                weekendDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),

                ),
                rowDecoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                outsideDaysVisible: false,
                weekendTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                holidayTextStyle: TextStyle(color: Colors.black),
                todayTextStyle: TextStyle(color: Colors.black),
                //sdisabledTextStyle: TextStyle(color: Colors.black),
                //selectedTextStyle: TextStyle(color: Colors.black),
                defaultTextStyle: TextStyle(color: Colors.black),

                defaultDecoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
              ),


            );
          },
        );
      },
    );
  }
}