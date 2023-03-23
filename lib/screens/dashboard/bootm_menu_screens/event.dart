import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storily/Utils/app_colors.dart';
import 'package:storily/cubit/load_recommended_events_cubit.dart';
import 'package:storily/model/event_flow_model.dart';
import 'package:storily/repo/repo.dart';
import 'package:storily/screens/schedule_event_flow_screens/main_event_screen.dart';

import '../../../Utils/Events/event_utils.dart';


class MyEventPage extends StatelessWidget {
 const MyEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor, ///mainColor
        //color: Color(0xfff0f3f6),
        height: 1.sh,
        width: 1.sw,
        //  padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Stack(
          children: [
            Positioned(
              // left: 20.sp,
                top: 120.sp,
                left: 0,
                child: Image.asset("assets/images/dotEventScreen.png",width: 80.sp,
                  height: 8.sp,)),
            Positioned(
              // left: 20.sp,
                top: 190.sp,
                right: 0,
                child: Image.asset("assets/images/background_circledots.png",width: 100.sp,
                  height: 130.sp,)),
            Positioned(
                top: 170.sp,
                right: 80.sp,child:  Container(
                color: Colors.transparent
                ,child: Image.asset("assets/images/background_kids_squiggle1.png",height: 30.sp,width: 30.sp,)))
         ,
            Positioned(
                top: 160.sp,
                left: 20.sp,child:  Container(
                color: Colors.transparent
                ,child: Image.asset("assets/images/background_kids_cross2.png",height: 25.sp,width: 30.sp,)))
            ,
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
              left: 10.sp,
              //right: 20.sp,
                bottom:1.sh/5.sp,

               // top: 1.sh/5,
                child: Image.asset("assets/images/background_kids_cross1.png",height: 50.sp,width: 40.sp,)),
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

              SizedBox(height: 40.sp,),
              ///My Event Text - Title Text
              Container(margin: EdgeInsets.symmetric(horizontal:1.sw/4.5),
              color: AppColors.primaryColor,

              child: Center(child: Text("   MY\nEVENTS",style: GoogleFonts.lexend(fontSize: 40.sp,fontWeight: FontWeight.w700),)),
              ),
                SizedBox(height: 20.sp,),
                ///Currently streaming text
                Container(
                    color: Color(0xffEEF0F2),
                    margin: EdgeInsets.only(left: 20.sp,right: 1.sw/4),
                    child: Text("CURRENTLY STREAMING ",style: GoogleFonts.lexend(fontSize:17.sp ,fontWeight: FontWeight.w600,decoration:TextDecoration.underline ,decorationThickness: 2,  decorationColor: Color(0xfff6c33f)),)),
                SizedBox(height: 10.sp,),
///Current Streaming Widget
                Container(
                    height: Repository.eventListData.isEmpty? 100: 1.sh/3.1,
                    child: StreamingCurrentEventWidget()),
                SizedBox(height: 20.sp,),
              ///upcoming Text
                Container(
                  color: Color(0xffEEF0F2),
                    margin: EdgeInsets.only(left: 20.sp,right: 1.sw/2.9),
                    child: Text("UPCOMING",style: GoogleFonts.lexend(fontSize:20.sp ,fontWeight: FontWeight.w600,decoration:TextDecoration.underline ,decorationThickness: 2,  decorationColor: Color(0xfff6c33f)),)),
                SizedBox(height: 10.sp,),
                ///Upcoming Widget
                Container(
                    color: AppColors.primaryColor,
                    height: Repository.eventListData.isEmpty? 100:1.sh/3.1,
                    child: UpcomingWidget()),

                SizedBox(height: 20.sp,),
///recommended widget
                 SizedBox(
                   height: 300.sp,

                   child: RecommendWidget(),
                 )




              ],),
            //SizedBox(height: 80.sp,),


          ],
        ),

      ),
    );

  }
}

