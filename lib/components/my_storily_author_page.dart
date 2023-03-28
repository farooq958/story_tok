import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:storily/Utils/PageTransitions/slide_page_transition.dart';
import 'package:storily/components/page_uploader.dart';
import 'package:storily/components/upload_book_format.dart';
import 'package:storily/components/video_uploader_page.dart';
import 'package:storily/cubit/selected_date_event_cubit.dart';
import 'package:storily/screens/schedule_event_flow_screens/add_shedule_event.dart';
import 'package:storily/screens/schedule_event_flow_screens/main_event_screen.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../cubit/load_main_data_cubit.dart';
import '../cubit/load_upcoming_data_cubit.dart';
import '../model/event_flow_model.dart';


//This page is the author's center
////////////////////////////////////
class MyStorilyAuthorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("My Storily"),
        ),
        body: Container(
          width: 1.sw,
          height: 1.sh,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 0, 254, 100),
              Color.fromRGBO(51, 51, 153, 100),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: AuthorCenterPageUI(),
        ));
  }
}

class AuthorCenterPageUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
     // mainAxisAlignment: MainAxisAlignment.spaceAround,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 50.sp,),
        Image.asset('assets/images/bitRead_logo_banner_Placeholder.png', height: MediaQuery.of(context).size.height*0.12,),
        SizedBox(height: 20.sp,),
        Center(
          child: Text("Millions of Stories. \n Free on BitRead.", style: TextStyle(
            fontFamily: 'Proxima Nova',
            fontSize: 30.0.sp,
            fontWeight: FontWeight.w900,
          ),),
        ),
        SizedBox(height: 50.sp,),


              Center(
                child: Text("Upload Video", style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18.0,
                ),),
              ),
              SizedBox(
                height: 10.0.sp,
              ),
              MaterialButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoUploader()));//
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.mail_outline, color: Colors.black,),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text("Add Videos", style: TextStyle(//this is a short cut for the author to update videos
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),),
                      ],
                    ),
                  )
              ),
              SizedBox(
                height: 10.0,
              ),
              MaterialButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadBookFormat())); //short cut for author to upload their book
                    /*Navigator.push(context, MaterialPageRoute(builder: (context)=>Material(
                      child: ChangeNotifierProvider(
                        create: (_)=>Admin(),
                        child: SpotifyAdmin(),
                      ),
                    )));*/
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.mail_outline, color: Colors.black,),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text("UPLOAD NEW STORIES", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),),
                      ],
                    ),
                  )
              ),
              SizedBox(
                height: 10.0,
              ),
              MaterialButton(
                  onPressed: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>PageUploader())); //short cut for author to upload their book
                    /*Navigator.push(context, MaterialPageRoute(builder: (context)=>Material(
                      child: ChangeNotifierProvider(
                        create: (_)=>Admin(),
                        child: SpotifyAdmin(),
                      ),
                    )));*/
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.mail_outline, color: Colors.black,),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text("Schedual Reading Event", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),),
                      ],
                    ),
                  )
              ),
              SizedBox(
                height: 10.0.sp,
              ),
              MaterialButton(
                  onPressed: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>PageUploader())); //short cut for author to upload their book
                    /*Navigator.push(context, MaterialPageRoute(builder: (context)=>Material(
                      child: ChangeNotifierProvider(
                        create: (_)=>Admin(),
                        child: SpotifyAdmin(),
                      ),
                    )));*/
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.mail_outline, color: Colors.black,),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text("My BOOKS", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),),
                      ],
                    ),
                  )
              ),
        SizedBox(
          height: 10.0.sp,
        ),
            UnconstrainedBox(child: SizedBox(
              height: 50.sp,
              width: 1.sw/1.6,
              child: TouchableOpacity(
                child: ElevatedButton(
                  style: ButtonStyle(
   shape: MaterialStateProperty.all(RoundedRectangleBorder(
     borderRadius: BorderRadius.circular(20), // Set the radius of the border
   ),),
                    backgroundColor:  MaterialStateProperty.all(Colors.white)
                  ),

                    onPressed: (){

                    Navigator.pushReplacement(context, CustomSlidePageRoute(child: MainEventScreenScheduleScreen()));
                    context.read<LoadMainDataCubit>().getEventData();
                    context.read<LoadUpcomingDataCubit>().getUpcomingEventData();
                    context.read<SelectedDateEventCubit>().setDate(DateTime.now());
                   // context.read<LoadMainDataCubit>().getEventData(EventFlowModel(eventTitle: "", eventDescription: "", fromTime: "", outTime: "", eventDate: DateTime.now()));


                    }, child: Center(child: Text("Schedule Event ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),)),
              ),
            ))
            ,
        SizedBox(
          height: 10.0.sp,
        ),
        // UnconstrainedBox(child: SizedBox(
        //   height: 50.sp,
        //   width: 1.sw/1.6,
        //   child: TouchableOpacity(
        //     child: ElevatedButton(
        //         style: ButtonStyle(
        //             shape: MaterialStateProperty.all(RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(20), // Set the radius of the border
        //             ),),
        //             backgroundColor:  MaterialStateProperty.all(Colors.white)
        //         ),
        //
        //         onPressed: (){
        //
        //          // Navigator.push(context, CustomSlidePageRoute(child: AddEventScreenScheduleScreen()));
        //
        //         }, child: Center(child: Text("Add  Event ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),)),
        //   ),
        // ))



      ],
    );
  }
}
