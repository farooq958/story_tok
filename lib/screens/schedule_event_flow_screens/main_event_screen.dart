import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


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
                right: 20.sp, // distance from the right
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
                 Text("Hi, Farooq ",style: GoogleFonts.lexend(fontSize:25.sp ),),
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
                
                child:  Padding(
                  padding:  EdgeInsets.only(right: 50.0.sp),
                  child: Image.asset("assets/images/submenu_yellow_text.png",height: 50.sp,width: 1.sw/1.15,),
                ),
                  )


                  ),),

SizedBox(height: 20.sp,),
 Container(


   height: 240.h,
   width: 1.sw,
   color: Colors.transparent,
   margin: EdgeInsets.only(left: 25.sp),
child: CalendarView(),
 )
                ],),
            //SizedBox(height: 80.sp,),


            ],
          ),

        ),
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

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      rowHeight: 30.sp,
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
      },
      headerVisible: false,

      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          return LayoutBuilder(
            builder: (context,constraints) {
              return Container(
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  color:
                      Colors.yellow
                      ,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(day == DateTime.sunday ? 20 : 0),
                    topRight: Radius.circular(day == DateTime.thursday ? 20 : 0),
                  ),
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      DateFormat.E().format(day),
                      style: GoogleFonts.lexend(
                        fontSize: 20.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            }
          );
        },
        defaultBuilder: (context, date, _) {
          return Container(
            //height: 100.sp,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        },


      ), firstDay: DateTime.now(), lastDay: DateTime.now(),


      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        weekendTextStyle: TextStyle(color: Colors.black),
        holidayTextStyle: TextStyle(color: Colors.black),
        todayTextStyle: TextStyle(color: Colors.black),
        //selectedTextStyle: TextStyle(color: Colors.black),
        defaultTextStyle: TextStyle(color: Colors.black),
        selectedDecoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        defaultDecoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
      ),


    );
  }
}












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


