import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:storily/Utils/PageTransitions/scale_page_transition.dart';
import 'package:storily/Utils/PageTransitions/slide_page_transition.dart';
import 'package:storily/cubit/load_main_data_cubit.dart';
import 'package:storily/cubit/selected_date_event_cubit.dart';
import 'package:storily/model/event_flow_model.dart';
import 'package:storily/repo/repo.dart';
import 'package:storily/screens/schedule_event_flow_screens/add_shedule_event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../Utils/Events/event_utils.dart';


class MainEventScreenScheduleScreen extends StatelessWidget {
  const MainEventScreenScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffEEF0F2),
           //color: Color(0xfff0f3f6),
height: 1.sh,
          width: 1.sw,
        //  padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Stack(
            children: [
              Positioned(
                //left: 0.sp,
                //right: 1.sw/2,
                  bottom:1.sh/3.5.sp,
                  top: 1.sh/2.8,
                  child: SizedBox(
                      height: 20.sp,
                      child: Image.asset("assets/images/background_rectangledots.png"))),
              Positioned(
              // left: 20.sp,
                top: 70.sp,
                right: 0,
                child: Image.asset("assets/images/background_circledots.png",width: 115.sp,
                  height: 150.sp,)),
              // Positioned(
              // //left: 0.sp,
              // //right: 1.sw/2,
              //   bottom:1.sh/3.5.sp,
              //   top: 1.sh/2.8,
              //   child: SizedBox(
              //       height: 20.sp,
              //       child: Image.asset("assets/images/background_rectangledots.png"))),
              Positioned(
                bottom: 20.sp, // distance from the bottom
                right: 0.sp, // distance from the right
                child: Image.asset(
                  'assets/images/background_square.png',
                  width: 70.sp, // specify the width of the image
                  height: 70.sp, // specify the height of the image
                ),
              ),
              ListView(
                shrinkWrap: true,
              //padding:  EdgeInsets.symmetric(horizontal: 20.sp)
                children: [
//SizedBox(height: 35.sp,),
///Top Design
       Container(height: 130.sp,color: Colors.transparent ,
       //  padding: EdgeInsets.symmetric(horizontal: 20.sp),
         margin: EdgeInsets.only(left: 20.sp),
         child: ListView(
         shrinkWrap: true,
         scrollDirection: Axis.horizontal,
         physics: NeverScrollableScrollPhysics(),

         children: <Widget>[

           ///left side
           UnconstrainedBox(
             child: Container(
               height:120.sp,
               width: 1.sw/1.9.sp,
color: Colors.transparent,
               child: ListView(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),

               children: [
SizedBox(height: 50.sp,),
                 ///upper date
                 Text("13/3/2023",style: GoogleFonts.lexend(fontSize:11.sp ),),
///Profile Name
                 Text("Hi,Farooq ",style: GoogleFonts.lexend(fontSize:25.sp,fontWeight: FontWeight.w600),),
                 FittedBox(child: Text("Welcome to your dashboard",style: GoogleFonts.lexend(fontSize:11.sp ,fontWeight: FontWeight.w200),)),

               ],

               ),
             ),
           )
,
           ///rigth side
           UnconstrainedBox(
             child: Container(
               height:130.sp,
               width: 1.sw/1.9.sp,
               color: Colors.transparent,
               child: ListView(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),

                 children: [
                   SizedBox(height: 25.sp,),
                   ///Profile Picture
                   Row(
                     children: [

                       Expanded(child: ListView(
                         shrinkWrap:true,
                         physics: NeverScrollableScrollPhysics(),
                         children: [
                           Container(
                               color: Colors.transparent
                               ,child: Image.asset("assets/images/background_triangle.png",height: 30.sp,width: 80.sp,)),
                           SizedBox(height: 20.sp,),
                           Container(
                               color: Colors.transparent
                               ,child: Image.asset("assets/images/background_squiggle.png",height: 30.sp,width: 80.sp,)),

                         ],
                       )),

                       Expanded(
                         flex: 3,
                           child: Align(
                             alignment: Alignment.centerLeft,
                             child: Stack(
                               children: [
                                 Container(
                                   height: 100.sp,
                                   width: 90.sp,
                                   child: CircleAvatar(
                                       child: Image.asset("assets/images/profile_profile_placeholder.png",height: 100.sp,width: 90.sp,)
,
                                     //minRadius: 30.sp,
                                       maxRadius: 45.sp,
//backgroundImage: AssetImage("assets/images/profile_profile_placeholder.png"),
                                       ),
                                 ),
                              //   child: Image.asset("assets/images/profile_profile_placeholder.png",height: 100.sp,width: 90.sp,)
                               Positioned(
                                   right: 2.sp,
                                   top: 10.sp,
                                   child: Image.asset("assets/images/profile_notificationdot.png",height: 20.sp,width: 20.sp,))
                               ],
                             ),
                           )),


                     ],
                   )

                 ],

               ),
             ),
           )
           ,
           //Container(color: Colors.red,height: 50.sp,),

         ],
       ),)
,
///Event Planner Text Container
                  UnconstrainedBox(child: Container(
width: 1.sw/1.15,
                    decoration: BoxDecoration(
                        color: Color(0xfff6c33f),
                        borderRadius: BorderRadius.circular(10.sp),
                        border: Border.all(color: Colors.black,width: 2.sp)),
                    margin: EdgeInsets.symmetric(horizontal: 20.sp),
                    height: 50.sp,

                  child:Container(
                    

                 //   margin:EdgeInsets.only(bottom: 10.sp),

                      width:  1.sw/1.15,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: AssetImage("assets/images/submenu_yellow_box.png")),
                          color: Color(0xffEEF0F2),
                          borderRadius: BorderRadius.circular(10.sp),
                          border: Border.all(color: Colors.black,width: 1.5.sp)),
                      margin: EdgeInsets.only(right: 5.sp,bottom: 2.sp),
                      height: 50.sp,
                
                child:  Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:  EdgeInsets.only(right: 50.0.sp),
                            child: Image.asset("assets/images/submenu_yellow_text.png",height: 50.sp,width: 1.sw/1.15,),
                          ),
                        ),

                      ],
                    ),
                    Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        child: Image.asset("assets/images/submenu_exit.png"))
                  ],
                ),
                  )


                  ),),

SizedBox(height: 20.sp,),
 Container(


   height: 240.h,
   width: 1.sw,
   //color: Colors.transparent,
   decoration: BoxDecoration(

     image: DecorationImage(
         fit: BoxFit.fill,
         image: AssetImage("assets/images/subcalendar_yellow_base.png"))
   ),
   padding:EdgeInsets.symmetric(horizontal:20.sp) ,
   margin: EdgeInsets.only(left: 20.sp,right: 20.sp),
child: CalendarView(),
 ),
                  SizedBox(height: 10.sp,),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: Text("Upcoming Events ",style: GoogleFonts.lexend(fontSize:25.sp ,fontWeight: FontWeight.w600),)),
                  ///upcoming Events
                   UpcomingWidget(),
                  SizedBox(height: 10.sp,),
                  // Container(
                  //
                  //     margin: EdgeInsets.only(left: 20.sp,right: 20.sp),
                  //     child: Stack(
                  //       children: [
                  //         Image.asset("assets/images/eventticket_yellow_base.png",fit: BoxFit.fitWidth,),
                  //         Positioned(
                  //             top:0,
                  //             right: 0,
                  //             bottom: 0,
                  //             left: 1,
                  //             child: Image.asset("assets/images/eventticket_yellow_bookicon.png")),
                  //         Positioned.fill(
                  //           top:0,
                  //           right: 0,
                  //           left: 50.sp,
                  //           //right: 0,
                  //           bottom: 0,
                  //           child: UnconstrainedBox(
                  //
                  //             child: SizedBox(
                  //               height: 100.sp,
                  //               width: 200.sp,
                  //               child: Center(
                  //                 child: ListView(
                  //                   physics: NeverScrollableScrollPhysics(),
                  //                   shrinkWrap: true,
                  //                   children: <Widget>[
                  //
                  //                     Text("Event Title ",style: GoogleFonts.lexend(fontSize:20.sp,fontWeight: FontWeight.w600),),
                  //                     Text("01/05/20xx ",style: GoogleFonts.lexend(fontSize:15.sp,fontWeight: FontWeight.w600),),
                  //                     Text("01:30-2:30 ",style: GoogleFonts.lexend(fontSize:14.sp,fontWeight: FontWeight.w600),),
                  //
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Positioned(
                  //             right: 10,
                  //             bottom: 10,
                  //             child: Text("30 MORE Days",style: GoogleFonts.lexend(fontSize:8.sp,fontWeight: FontWeight.w300),)),
                  //         Positioned(
                  //           //top:0,
                  //             right: 0,
                  //             bottom: 0,
                  //             left: 0,
                  //             child: Image.asset("assets/images/eventticket_yellow_editicon.png")),
                  //
                  //
                  //       ],
                  //     )),
                  // SizedBox(height: 10.sp,),
                ],),
            //SizedBox(height: 80.sp,),


            ],
          ),

        ),
    );

  }
}



// class MyCalendarWidget extends StatefulWidget {
//   @override
//   _MyCalendarWidgetState createState() => _MyCalendarWidgetState();
// }
//
// class _MyCalendarWidgetState extends State<MyCalendarWidget> {
//   DateTime _selectedMonth = DateTime.now();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         children: [
//     // custom header
//     Container(
//     padding: EdgeInsets.all(16),
//     child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//     IconButton(
//     icon: Icon(Icons.arrow_back_ios),
//     onPressed: () {
//     setState(() {
//     _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
//     });
//     },
//     ),
//     Text(
//     '${DateFormat.MMMM().format(_selectedMonth)} ${_selectedMonth.year}',
//     style: TextStyle(fontSize: 18),
//     ),
//     IconButton(
//     icon: Icon(Icons.arrow_forward_ios),
//     onPressed: () {
//     setState(() {
//     _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
//     });
//     },
//     ),
//     ],
//     ),
//     ),
//     // table calendar
//     TableCalendar(
//
//     startingDayOfWeek: StartingDayOfWeek.sunday,
//     headerVisible: false,
//     ///important
//     // onDaySelected: (date, events) {
//     // // update the selected month based on the selected date
//     // setState(() {
//     // _selectedMonth = DateTime(date.year, date.month);
//     // });
//     }, focusedDay: null, firstDay: null, lastDay: null,













// class CalendarView2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       shrinkWrap: true,
//       children: [
//         SfCalendar(
//           view: CalendarView.day,
//           dataSource: _getCalendarDataSource(),
//         ),
//       ],
//     );
//   }
//
//   _DataSource _getCalendarDataSource() {
//     List<Appointment> appointments = <Appointment>[];
//     final DateTime today = DateTime.now();
//     final DateTime startTime =
//     DateTime(today.year, today.month, today.day, 9, 0, 0);
//     final DateTime endTime =
//     DateTime(today.year, today.month, today.day, 11, 0, 0);
//     appointments.add(Appointment(
//         startTime: startTime,
//         endTime: endTime,
//         subject: 'Meeting',
//         color: Colors.blue,
//         isAllDay: false));
//     return _DataSource(appointments);
//   }
// }
//
// class _DataSource extends CalendarDataSource {
//   _DataSource(List<Appointment> source) {
//     appointments = source;
//   }
// }


