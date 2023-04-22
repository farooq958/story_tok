import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storily/Utils/app_colors.dart';
import 'package:storily/cubit/LibraryCubits/library_featured_authors_cubit.dart';
import 'package:storily/cubit/LibraryCubits/library_not_owned_books_cubit.dart';
import 'package:storily/screens/dashboard/bootm_menu_screens/library_screens/author_screen.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../../Utils/Events/library_utils.dart';
import '../../../../cubit/LibraryCubits/library_books_this_month_cubit.dart';

class DiscoveryTab extends StatelessWidget {
  const DiscoveryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      shrinkWrap: true,
      children: [
        SizedBox(height: 10.sp,),
        ///this month picks
        Container(height: 250.sp,
          width: 1.sw/1.15,
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          decoration: BoxDecoration(
    //border:Border(right: BorderSide(width: 2.0)),
   // borderRadius: BorderRadius.only(topRight: Radius.circular(20.sp)),
    //border: Border.all(color: Colors.black,width: 2.sp),
   //borderRadius: BorderRadius.circular(20.sp),
          image: DecorationImage(
              fit: BoxFit.fill,

alignment: Alignment.topRight,
//isAntiAlias: true,
              image: AssetImage("assets/images/kidslibrary_purple_container1.png"))

        ),
        child: ListView(
          //shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),children: [

           Container(
               padding: EdgeInsets.only(right: 55.sp),

               child: Image.asset('assets/images/kidslibrary_purple_thismonthspicks.png',width: 10.sp,)),
          SizedBox(height: 10.sp,),
          BlocConsumer<LibraryBooksThisMonthCubit, List>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return SizedBox(
            height: 150.sp,
            width: 150.sp,
            child: ListView.separated(
              padding: EdgeInsets.only(left: 20.sp,right: 20.sp),
    shrinkWrap: true,
              itemBuilder: (context,index){

              return TouchableOpacity(
                onTap: (){

                  showCustomBottomSheet(context,state[index]);
                },
                child: Container(
                  height: 100.sp,
                  width: 100.sp,

                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 2.0.sp)
                  ),
                  child: Center(child: Image.network(state[index]['cover_url']),),
                ),
              );
            },itemCount: state.length,scrollDirection: Axis.horizontal, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 10.sp,); },),
          );
  },
)

        ],),
        ),

        SizedBox(height: 10.sp,),
        Container(height: 180.sp,decoration: BoxDecoration(

            image: DecorationImage(
                fit: BoxFit.fill,

                image: AssetImage("assets/images/kidslibrary_purple_container2.png"))

        ),
          child: ListView(physics: NeverScrollableScrollPhysics(),children: [

            Container(
                padding: EdgeInsets.only(right: 55.sp,left: 2.sp),

                child: Image.asset('assets/images/kidslibrary_purple_featuredauthors.png',width: 10.sp,)),
            SizedBox(height: 10.sp,),
            BlocConsumer<LibraryFeaturedAuthorsCubit, List>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, featureAuthors) {
    return SizedBox(
              height: 90.sp,
              width: 150.sp,
              child: ListView.separated(
                padding: EdgeInsets.only(left: 20.sp,right: 20.sp),
                shrinkWrap: true,
                itemBuilder: (context,index){

                  return TouchableOpacity(
                    onTap: (){
print(featureAuthors[index]['user_id']);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthorLibraryScreen(auhtorId: featureAuthors[index]['user_id'],)));
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 80.sp,
                          width: 80.sp,


                          decoration: BoxDecoration(

                            //color: Colors.red,

                             image: DecorationImage(fit:BoxFit.fitWidth,image: AssetImage("assets/images/kidslibrary_authorcircle.png")),
                            borderRadius: BorderRadius.circular(360.sp),
                            border: Border.all(color: Colors.black,width: 2)



                          ),
                          child:  ClipOval(child: Image.network(featureAuthors[index]['avatar_url'],fit: BoxFit.fitHeight,)),
                        ),
                        Positioned(
                            bottom: 10.sp,
                            left: 2.sp,
                            child: Container(
                              height: 20.sp,
                              width: 75.sp,
                              //color: Colors.black,
         decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2.0)
         ,
           color: AppColors.libraryMainColor
         ),
child: Center(child: Text(featureAuthors[index]['name'].toString()),),

                            ))
                      ],
                    ),
                  );
                },itemCount: featureAuthors.length,scrollDirection: Axis.horizontal, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 10.sp,); },),
            );
  },
),


          ],),
        ),
        SizedBox(height: 10.sp,),
        Container(height: 250.sp,decoration: BoxDecoration(

            border: Border.all(color: Colors.black,width: 2.sp),
          borderRadius: BorderRadius.circular(20.sp)

        ),
          child: ListView(physics: NeverScrollableScrollPhysics(),children: [


            SizedBox(height: 10.sp,),
            BlocConsumer<LibraryNotOwnedBooksCubit, List>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, notOwnedBooks) {
    print(notOwnedBooks.length.toString()+"##Not OWned");
    return SizedBox(
              height: 150.sp,
              width: 150.sp,
              child: ListView.separated(
                padding: EdgeInsets.only(left: 20.sp,right: 20.sp),
                shrinkWrap: true,
                itemBuilder: (context,index){

                  return  TouchableOpacity(
                    onTap: (){

                      showCustomBottomSheet(context,notOwnedBooks[index]);
                    },
                    child: Container(
                      height: 100.sp,
                      width: 100.sp,

                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2.0.sp)
                      ),
                      child:Center(child: Image.network(notOwnedBooks[index]['cover_url']),) ,
                    ),
                  );
                },itemCount: notOwnedBooks.length,scrollDirection: Axis.horizontal, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 10.sp,); },),
            );
  },
)

          ],),
        ),
        SizedBox(height: 80.sp,)


      ],

    );
  }
}
