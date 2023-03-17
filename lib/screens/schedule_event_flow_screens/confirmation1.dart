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
import 'package:storily/cubit/selected_date_event_cubit.dart';
import 'package:storily/model/event_flow_model.dart';
import 'package:storily/repo/repo.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import 'confirmation2.dart';
class Confirmation1 extends StatelessWidget {
  const Confirmation1({Key? key}) : super(key: key);

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

            Column(
              children: [
                Expanded(
                  child: ListView(
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



                      SizedBox(height: 10.sp,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 50.sp),

                        decoration: BoxDecoration(
                          ),

                     child: Image.asset("assets/images/event_yellow_confirmdetails.png"),
                      ),
                      SizedBox(height: 20.sp,),
                      UnconstrainedBox(
                        child: Container(
                          height: 180.sp,
                          width: 1.sw/1.15,
                         // margin: EdgeInsets.symmetric(horizontal: 20.sp),
                          decoration: BoxDecoration(

                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/event_yellow_confirmbox.png"))
                          ),
child: ListView(
  shrinkWrap: true,
  padding: EdgeInsets.only(left: 10.sp),
  physics: NeverScrollableScrollPhysics(),
  children: [
    SizedBox(height: 10.sp,),
    Text(Repository.eventTitleController.text,style: GoogleFonts.lexend(fontSize:20.sp,fontWeight: FontWeight.w600),),
    SizedBox(height: 10.sp,),
    ///date and time
    SizedBox(
      height: 20.sp,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
                                 physics: NeverScrollableScrollPhysics(),
                                 children: <Widget>[
                                   Image.asset("assets/images/calendar_yellow_clockicon.png",height: 15.sp,),
                                   SizedBox(width: 5.sp,),
                                   Text("Date and Time ",style: GoogleFonts.lexend(fontSize:12.sp,fontWeight: FontWeight.w600),),
                                  // Text(" ",style: GoogleFonts.lexend(fontSize:8.sp,fontWeight: FontWeight.w600),),


                                 ],
                                ),
    ),
    ///date and time value
    BlocBuilder<SelectedDateEventCubit, DateTime>(
  builder: (context, selectedDate) {
    return BlocBuilder<EventToTimeCubit, String>(
  builder: (context, toTime) {
    return BlocBuilder<EventFromTimeCubit, String>(
  builder: (context, fromTime) {
    return Padding(
        padding: EdgeInsets.only(left: 25.sp),
        child: Text("${DateFormat("MMMM dd yyyy").format(selectedDate)}   $fromTime - $toTime",style: GoogleFonts.lexend(fontSize:12.sp,fontWeight: FontWeight.w300),));
  },
);
  },
);
  },
),
SizedBox(height: 10.sp,),
    ///Event Type Text
    SizedBox(
      height: 20.sp,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Image.asset("assets/images/calendar_yellow_clockicon.png",height: 15.sp,),
          SizedBox(width: 5.sp,),
          Text("Description  ",style: GoogleFonts.lexend(fontSize:12.sp,fontWeight: FontWeight.w600),),
          // Text(" ",style: GoogleFonts.lexend(fontSize:8.sp,fontWeight: FontWeight.w600),),


        ],
      ),
    ),
    ///event type value
    Padding(
        padding: EdgeInsets.only(left: 25.sp),
        child: Text(Repository.eventDescriptionController.text,style: GoogleFonts.lexend(fontSize:10.sp,fontWeight: FontWeight.w300),)),
  ],
),
                        ),
                      ),

                      SizedBox(height: 10.sp,),

                    ],),
                ),
                ///confirm cancel button
                Container(height: 40.sp,margin: EdgeInsets.symmetric(horizontal: 20.sp),

                  child: Row(
                    children: <Widget>[

                      Expanded(child: TouchableOpacity(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 3.sp),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 2),
                              color: Color(0xfff6c33f),
                              borderRadius: BorderRadius.circular(12.sp)

                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 2),
                                color: Color(0xffe6d9bd),
                                borderRadius: BorderRadius.circular(10.sp)

                            ),
                            child: Center(child: Text("Cancel",style: GoogleFonts.lexend(),),),

                          ),
                        ),
                      )),
                      SizedBox(width: 5.sp,),
                      Expanded(child:

                      BlocBuilder<SelectedDateEventCubit, DateTime>(
                        builder: (context, selectedDate) {
                          return BlocBuilder<EventToTimeCubit, String>(
                            builder: (context, toTime) {
                              return BlocBuilder<EventFromTimeCubit, String>(
                                builder: (context, fromTime) {
    return TouchableOpacity(
                        onTap: (){

                          Navigator.pushReplacement(context, CustomSlidePageRoute(child: Confirmation2()));
                          context.read<LoadMainDataCubit>().getEventData(EventFlowModel(eventTitle:Repository.eventTitleController.text , eventDescription: Repository.eventDescriptionController.text, fromTime: fromTime, toTime: toTime, eventDate: selectedDate));

                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 3.sp),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 2),
                              color: Color(0xfff6c33f),
                              borderRadius: BorderRadius.circular(12.sp)

                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 2),
                                color: Color(0xffe6d9bd),
                                borderRadius: BorderRadius.circular(10.sp)

                            ),
                            child: Center(child: Text("Confirm",style: GoogleFonts.lexend(),),),

                          ),
                        ),
                      );
  },
);
  },
);
  },
)),

                    ],
                  ),
                )
              ],
            ),
            //SizedBox(height: 80.sp,),


          ],
        ),

      ),
    );

  }
}
