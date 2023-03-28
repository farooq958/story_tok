import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:storily/Utils/PageTransitions/slide_page_transition.dart';
import 'package:storily/cubit/event_from_time_cubit.dart';
import 'package:storily/cubit/event_to_time_cubit.dart';
import 'package:storily/cubit/load_main_data_cubit.dart';
import 'package:storily/cubit/load_upcoming_data_cubit.dart';
import 'package:storily/cubit/selected_date_event_cubit.dart';
import 'package:storily/repo/repo.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import 'main_event_screen.dart';
class Confirmation2 extends StatefulWidget {
  const Confirmation2({Key? key}) : super(key: key);

  @override
  State<Confirmation2> createState() => _Confirmation2State();
}

class _Confirmation2State extends State<Confirmation2> {
  @override
  void initState() {
    context.read<LoadMainDataCubit>().getEventData();
  //context.read<LoadUpcomingDataCubit>().getUpcomingEventData();
    Future.delayed(Duration(seconds: 3)).then((value) => Navigator.pushReplacement(context, CustomSlidePageRoute(child: MainEventScreenScheduleScreen())));
    // TODO: implement initState
    super.initState();
  }
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
            Positioned(
              //left: 0.sp,
              //right: 1.sw/2,
                bottom:1.sh/3.5.sp,
                top: 1.sh/2.8,
                child: SizedBox(
                    height: 20.sp,
                    child: Image.asset("assets/images/background_rectangledots.png"))),
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



                SizedBox(height: 50.sp,),
Container(
  margin: EdgeInsets.symmetric(horizontal: 50.sp),
  child: Image.asset("assets/images/event_yellow_confirmedtext.png"),),
          SizedBox(height: 5.sp,)
          ,  Container(

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

                                    Text(Repository.eventTitleController.text,style: GoogleFonts.lexend(fontSize:20.sp,fontWeight: FontWeight.w600),),
                                    BlocBuilder<SelectedDateEventCubit, DateTime>(
  builder: (context, selectedDate) {
    return Text(DateFormat("MMMM dd yyyy").format(selectedDate),style: GoogleFonts.lexend(fontSize:15.sp,fontWeight: FontWeight.w600),);
  },
),
                                    BlocBuilder<EventToTimeCubit, String>(
                                      builder: (context, toTime) {
                                        return BlocBuilder<EventFromTimeCubit, String>(
                                          builder: (context, fromTime) {
    return Text("$fromTime-$toTime ",style: GoogleFonts.lexend(fontSize:14.sp,fontWeight: FontWeight.w600),);
  },
);
  },
),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            right: 10,
                            bottom: 10,
                            child: Text("30 MORE Days",style: GoogleFonts.lexend(fontSize:8.sp,fontWeight: FontWeight.w300),)),



                      ],
                    )),

              ],),
            //SizedBox(height: 80.sp,),


          ],
        ),

      ),
    );

  }
}
