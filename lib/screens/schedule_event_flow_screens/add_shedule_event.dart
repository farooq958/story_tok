import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:storily/Utils/PageTransitions/slide_page_transition.dart';
import 'package:storily/cubit/event_from_time_cubit.dart';
import 'package:storily/cubit/event_to_time_cubit.dart';
import 'package:storily/cubit/selected_date_event_cubit.dart';
import 'package:storily/model/event_type_model.dart';
import 'package:storily/repo/repo.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../Utils/Events/event_utils.dart';
import 'confirmation1.dart';
import 'main_event_screen.dart';

class AddEventScreenScheduleScreen extends StatelessWidget {
  const AddEventScreenScheduleScreen({Key? key}) : super(key: key);



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
                    color: Color(0xffEEF0F2),
                    margin: EdgeInsets.only(left: 20.sp),
                    child: Text("Title ",style: GoogleFonts.lexend(fontSize:20.sp,fontWeight: FontWeight.w600),)),
Container(
  height: 40.sp,
  margin: EdgeInsets.symmetric(horizontal: 20.sp),
  decoration: BoxDecoration(
      color: Color(0xffEEF0F2),
    border: Border.all(color: Colors.black,width: 2.sp),
    borderRadius: BorderRadius.circular(12.sp)
  ),
  child:TextFormField(
    controller: Repository.eventTitleController,
    style: GoogleFonts.lexend(),
    decoration: InputDecoration(

    hintStyle: GoogleFonts.lexend(color: Colors.grey,fontSize: 14.sp,fontWeight: FontWeight.w300),
      hintText: "   Title of the event"
    ),
  ) ,
)
,
                ///date for custom calender
                SizedBox(height: 10.sp,),
                BlocBuilder<SelectedDateEventCubit, DateTime>(
  builder: (context, selectedDateBuilder) {
    return Container(
                  height: 20.sp,
                  margin: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Row(
                    children: <Widget>[
                      
                       Expanded(child: Align(
                           alignment: Alignment.centerLeft,
                           child: Image.asset("assets/images/calendar_yellow_clockicon.png")))
                      ,
                      SizedBox(width: 3.sp,),
                      Expanded(
                          flex:6,child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(DateFormat("MMMM dd yyyy").format(selectedDateBuilder),style: GoogleFonts.lexend(decoration:TextDecoration.underline ,decorationThickness: 2,  decorationColor: Color(0xfff6c33f),),))),
                      Expanded(
                          flex: 2,
                          child: CustomPopupMenu(isFromTime: true,)),

                     Expanded(child: Text("To",style: GoogleFonts.lexend(),)),
                      Expanded(
                          flex:2,child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomPopupMenu(isFromTime: false,),
                          // child:
                          // Text("01:30",style: GoogleFonts.lexend
                          //   (decoration:TextDecoration.underline ,decorationThickness: 2,
                          //   decorationColor: Color(0xfff6c33f),),)),
                          ))


                    ],
                  ),
                );
  },
),
                // SizedBox(height: 10.sp,),
                // ///Reading Level
                // Container(
                //
                //     margin: EdgeInsets.only(left: 20.sp),
                //     color: Color(0xffEEF0F2),
                //     child: Text("Reading Level ",style: GoogleFonts.lexend(fontSize:20.sp,fontWeight: FontWeight.w600),)),

                SizedBox(height: 10.sp,),
//                 UnconstrainedBox(
//                   child: Container(
//                     height: 40.sp,
//                     width: 1.sw/3,
//                     //margin: EdgeInsets.symmetric(horizontal: 20.sp),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black,width: 2.sp),
//                         borderRadius: BorderRadius.circular(12.sp)
//                     ),
//
//                     child: CustomDropDown3(),
// //                   child:TextFormField(
// //                     readOnly: true,
// //                     style: GoogleFonts.lexend(),
// //                     decoration: InputDecoration(
// // suffixIcon:  Image.asset("assets/images/arrowdropdown-removebg-preview.png",),
// //                         hintStyle: GoogleFonts.lexend(color: Colors.grey,fontSize: 14.sp,fontWeight: FontWeight.w300),
// //                         hintText: "   Select type of your Event"
// //                     ),
// //                   ) ,
//                   ),
//                 )
               // ,
                ///event Type drop down
                Container(
                    color: Color(0xffEEF0F2),
                    margin: EdgeInsets.only(left: 20.sp),
                    child: Text("Event Type ",style: GoogleFonts.lexend(fontSize:20.sp,fontWeight: FontWeight.w600),)),
                UnconstrainedBox(
                  child: Container(
                    height: 40.sp,
                    width: 1.sw/1.15,
                    //margin: EdgeInsets.symmetric(horizontal: 20.sp),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 2.sp),
                        borderRadius: BorderRadius.circular(12.sp)
                    ),

child: CustomDropDown2(),
//                   child:TextFormField(
//                     readOnly: true,
//                     style: GoogleFonts.lexend(),
//                     decoration: InputDecoration(
// suffixIcon:  Image.asset("assets/images/arrowdropdown-removebg-preview.png",),
//                         hintStyle: GoogleFonts.lexend(color: Colors.grey,fontSize: 14.sp,fontWeight: FontWeight.w300),
//                         hintText: "   Select type of your Event"
//                     ),
//                   ) ,
                  ),
                )
                ,
                SizedBox(height: 10.sp,),
                ///description
                Container(

                    margin: EdgeInsets.only(left: 20.sp),
                    child: Text("Description ",style: GoogleFonts.lexend(fontSize:20.sp,fontWeight: FontWeight.w600),)),
SizedBox(height: 5.sp,),

Container(

height: 100.sp,
  //swidth: 180.sp,
  margin: EdgeInsets.symmetric(horizontal: 20.sp),
  decoration: BoxDecoration(
     // color: Colors.blueGrey,
border: Border.all(color: Colors.black,width: 2),
  borderRadius: BorderRadius.circular(15.sp)
  ),
child: TextFormField(
  controller: Repository.eventDescriptionController,
  maxLines: 100,
style: GoogleFonts.lexend(),
decoration: InputDecoration(
    hintStyle: GoogleFonts.lexend(color: Colors.grey,fontSize: 10.sp,fontWeight: FontWeight.w300),
  hintText: "  Description of event"
),
),
),
                SizedBox(height: 10.sp,),
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
                    Expanded(child: TouchableOpacity(
                      onTap: (){

                        Navigator.pushReplacement(context, CustomSlidePageRoute(child: Confirmation1()));

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
                    )),
                    
                  ],
                ),
                )
                ,SizedBox(height: 10.sp,),

              ],),
            //SizedBox(height: 80.sp,),


          ],
        ),

      ),
    );

  }
}
class CustomPopupMenu extends StatefulWidget {
  bool isFromTime;
 CustomPopupMenu({Key? key,required this.isFromTime}) : super(key: key);
  @override
  State<CustomPopupMenu> createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  var timeList=Repository().generateTimeList();
  String selectedTime = Repository().generateTimeList()[0];
  @override
  Widget build(BuildContext context) {
    //List<String> timeList = generateTimeList();
     // initialize the selected time to the first element in the list

   return PopupMenuButton<String>(

     position: PopupMenuPosition.under,
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(15.sp),
       side: BorderSide(
         width: 1.5,
         color: Colors.black
       )
     ),
     color: Color(0xffEEF0F2),
      itemBuilder: (BuildContext context) {
        // return timeList.map((String time) {
        //   return PopupMenuItem<String>(
        //     value: time,
        //     child: Column(
        //       children: [
        //         Text(time),
        //          Divider(thickness: 2, )
        //       ],
        //     ),
        //   );
        // }).toList();

        return [
          for (String time in timeList)
            PopupMenuItem(
              value: time,
              child: Column(

                children: [
                  Text(time,style: GoogleFonts.lexend(),),
                  Divider(thickness: 2,color: Colors.black,)
                ],
              ),
            ),
          // PopupMenuDivider(
          //   height: 20,
          // )

          // PopupMenuItem(
          //   value: 'cancel',
          //   child: Text('Cancel'),
          // ),
        ];
      },
      onSelected: (String time) {
       if(widget.isFromTime==true) {
         context.read<EventFromTimeCubit>().setTime(time);
       }
       else
         {
           context.read<EventToTimeCubit>().setTime(time);
         }
       setState(() {
          selectedTime = time;
        });
      },
      child: Text(selectedTime,style: GoogleFonts.lexend(decoration:TextDecoration.underline ,decorationThickness: 2,  decorationColor: Color(0xfff6c33f),),),
    );

  }
}

class CustomDropDown2 extends StatefulWidget {
  const CustomDropDown2({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDropDown2> createState() => _CustomDropDown2State();
}

class _CustomDropDown2State extends State<CustomDropDown2> {

  @override
  Widget build(BuildContext context) {
   // print(dropdownValue);
    return Container(
      constraints: BoxConstraints(
        maxWidth: 300.0, // Set the maximum width of the dropdown button
        minWidth: 190.0,
        maxHeight: 40// Set the minimum width of the dropdown button
      ),
      child: DropdownButton<String>(

        //menuMaxHeight: 50.sp,
        icon: Image.asset("assets/images/arrowdropdown-removebg-preview.png"),
        isExpanded: true,
        underline: const SizedBox(),
        // hint:  Text("Choose Plan ",style: GoogleFonts.poppins(color: AppColors.greyColor2),),
        // Step 3.
        hint: Text(
          'Select type of your Event',
          style: GoogleFonts.lexend(
           // decoration: TextDecoration.underline,
            color: Colors.grey[500], // Set the hint text color
            fontSize: 16.0, // Set the hint text font size
          ),
        ),
        value: Repository.dropdownValue,
        style: GoogleFonts.lexend(),

        // Step 4.
        items: Repository.eventTypeRawData
            .map<DropdownMenuItem<String>>((eventTypeModelData) {
          return DropdownMenuItem<String>(
            alignment: Alignment.center,
            value: eventTypeModelData.type.toString(),
            child: SizedBox(
            //  width: 20.sp,
              child: Text(
                eventTypeModelData.name,
                style:  GoogleFonts.lexend(fontSize: 10.sp,color: Colors.blueGrey),
              ),
            ),
          );
        }).toList(),

        onChanged: (String? newValue) {
          setState(() {
            Repository.dropdownValue = newValue!;
            print(Repository.dropdownValue);
          });
        },
      ),
    );
  }
}
class CustomDropDown3 extends StatefulWidget {
  const CustomDropDown3({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDropDown3> createState() => _CustomDropDown3State();
}

class _CustomDropDown3State extends State<CustomDropDown3> {

  @override
  Widget build(BuildContext context) {
    // print(dropdownValue);
    return Container(
      constraints: BoxConstraints(
          maxWidth: 20.0, // Set the maximum width of the dropdown button
          minWidth: 10.0,
          maxHeight: 10,
          minHeight: 8
          // Set the minimum width of the dropdown button

      ),
      child: DropdownButton<int>(

        //menuMaxHeight: 50.sp,
        //icon: Image.asset("assets/images/arrowdropdown-removebg-preview.png"),
        isExpanded: true,
        underline: const SizedBox(),
        // hint:  Text("Choose Plan ",style: GoogleFonts.poppins(color: AppColors.greyColor2),),
        // Step 3.
        hint: Text(
          'Select Reading Level',
          style: GoogleFonts.lexend(
            // decoration: TextDecoration.underline,
            color: Colors.grey[500], // Set the hint text color
            fontSize: 16.0, // Set the hint text font size
          ),
        ),
        value: Repository.dropDownReadingValue,
        style: GoogleFonts.lexend(),

        // Step 4.
        items: Repository.readingLevelList
            .map<DropdownMenuItem<int>>((i) {
          return DropdownMenuItem<int>(
            alignment: Alignment.center,
            value: i,
            child: SizedBox(
              //  width: 20.sp,
              child: Text(
                i.toString(),
                style:  GoogleFonts.lexend(fontSize: 10.sp,color: Colors.blueGrey),
              ),
            ),
          );
        }).toList(),

        onChanged: (int? newValue) {
          setState(() {
            Repository.dropDownReadingValue = newValue!;
            //print(Repository.dropdownValue);
          });
        },
      ),
    );
  }
}
