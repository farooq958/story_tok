import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../repo/repo.dart';
import '../app_colors.dart';

class CustomDropDownLibrary extends StatefulWidget {
  const CustomDropDownLibrary({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDropDownLibrary> createState() => CustomDropDownLibraryState();
}

class CustomDropDownLibraryState extends State<CustomDropDownLibrary> {

  @override
  Widget build(BuildContext context) {
    // print(dropdownValue);
    return Container(
      height: 100.sp,
      width: 100.sp,
      constraints: BoxConstraints(
          maxWidth: 200.0, // Set the maximum width of the dropdown button
        //  minWidth: 190.0,
          maxHeight: 40// Set the minimum width of the dropdown button
      ),
      child: DropdownButton<String>(
       // alignment: Alignment.topLeft,

        //menuMaxHeight: 50.sp,
        // icon: Image.asset("assets/images/arrowdropdown-removebg-preview.png"),
        isExpanded: true,
        underline: const SizedBox(),
       // isDense: true,
        icon: SizedBox(),
        iconDisabledColor: Colors.transparent,
        // hint:  Text("Choose Plan ",style: GoogleFonts.poppins(color: AppColors.greyColor2),),
        // Step 3.
        hint: Text(
          'Sort By...',
          style: GoogleFonts.lexend(
            // decoration: TextDecoration.underline,
            color: Colors.grey[500], // Set the hint text color
            fontSize: 16.0, // Set the hint text font size
          ),
        ),
        value: Repository.dropdownValueLibrary,
        style: GoogleFonts.lexend(),

        // Step 4.
        items: Repository.libraryCategoriesBooks
            .map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(
            alignment: Alignment.center,
            value: value,
            child: SizedBox(
              //  width: 20.sp,
              child: Text(
                value,
                style:  GoogleFonts.lexend(fontSize: 10.sp,color: Colors.blueGrey),
              ),
            ),
          );
        }).toList(),

        onChanged: (String? newValue) {
          setState(() {
            Repository.dropdownValueLibrary = newValue!;

          });
        },
      ),
    );
  }
}
Container reusableButtonLibrary({required String text }) {
  return Container(
    // width: 1.sw/1.15,
      decoration: BoxDecoration(
          color: AppColors.libraryMainDarkColor,
          borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(color: Colors.black,width: 2.sp)),
      margin: EdgeInsets.symmetric(horizontal: 20.sp),
      height: 50.sp,

      child:Container(


        //   margin:EdgeInsets.only(bottom: 10.sp),

        width:  1.sw/1.15,
        decoration: BoxDecoration(
          // image: DecorationImage(
          //     fit: BoxFit.fitWidth,
          //     image: AssetImage("assets/images/submenu_yellow_box.png")),
            color: AppColors.libraryMainColor,
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(color: Colors.black,width: 1.5.sp)),
        margin: EdgeInsets.only(right: 5.sp,bottom: 2.sp),
        height: 50.sp,
        child: Center(child: Text(text,style: GoogleFonts.lexend(fontWeight: FontWeight.w600),),),


      )


  );
}



 void showCustomBottomSheet(BuildContext context, listState) {
  showModalBottomSheet(
    enableDrag: true,
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    isDismissible: false,
    constraints: BoxConstraints(
      maxWidth:1.sw/1.05,
    ),

    useRootNavigator: true,

    builder: (BuildContext context) {
      return SafeArea(child: buildBottomSheet(context,listState),bottom: true,);
    },
  );
}

Widget buildBottomSheet(BuildContext context,listState) {
  return Container(
    height: 1.sh/1.4,
    //color: AppColors.primaryColor,
    child: ListView(
        shrinkWrap: true,
        children:[
          //SizedBox(height: 20.sp,)
          Stack(
            children: [
              Container(
                height: 1.sh/2.sp,
                // width: 1.sw,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    image: DecorationImage(image: AssetImage("assets/images/bookpreview_textbox4.png"))),
                child: Center(child: listState['cover_url']==null?Text("No Image"):Image.network(listState['cover_url'],fit: BoxFit.fill,height: 1.sh/2.7,),),
              ),
              Positioned(
                  right: 0,
                  top: 10.sp,
                  child: TouchableOpacity(
                      onTap: (){
                        Navigator.pop(context);

                      },
                      child: Image.asset("assets/images/bookpreview_exit.png",height: 40.sp,)))
            ],
          ),
          Container(height: 5.sp,color: AppColors.primaryColor,),
          Container(

            height: 70.sp,
            decoration: BoxDecoration(

                color: AppColors.primaryColor,borderRadius: BorderRadius.circular(20.sp),border: Border.all(color: Colors.black,width: 2.0.sp)),
            child:
            Row(
              children:<Widget>[
                ///Generes and Topics
                Expanded(child:
                ListView(
                    padding: EdgeInsets.only(left: 10.sp),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(height: 2.sp,),
                      Row(
                        children: <Widget>[
                          Expanded(child: Text("Generes",style: GoogleFonts.lexend(),))  ,
                          SizedBox(width: 2.sp,),
                          Expanded(
                              flex: 2,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: listState['category_main']==null?Text("No Generes"):Text(listState['category_main'])))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: Text("Topics",style: GoogleFonts.lexend(),))  ,
                          SizedBox(width: 2.sp,),
                          Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 15.sp,
                                width: 200.sp,
                                child:listState['topic']==null?Text("No topic") : ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: listState['topic'].length,
                                  itemBuilder: (BuildContext context, int index) {

                                    return FittedBox(child: Text(listState['topic'][index].toString(),style: GoogleFonts.lexend(decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.dotted),));

                                  }, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 2.sp,); },

                                ),
                              ))
                        ],
                      ),
                    ]
                ),
                ),
                Image.asset("assets/images/home/home_readinglevel_1_icon.png",height: 50.sp,width: 50.sp,)



              ],
            ),

          ),
          Container(height: 5.sp,color: AppColors.primaryColor,),
          Container(
            height: 300.sp,
            decoration: BoxDecoration(
color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20.sp),border: Border.all(color: Colors.black,width: 2.0.sp)),

            child: ListView(shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(height: 10.sp,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.sp),
                  color: AppColors.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(width: 10.sp,),
                      Expanded(child: listState['title']==null?Text("No Title"):Text("${listState['title']}",style: GoogleFonts.lexend(fontSize: 20.sp,fontWeight: FontWeight.w600),)),
                      SizedBox(width: 20.sp,),
                      Expanded(child:listState['title']==null?Text("C\$0"): Text("C\$${listState['price']}",style: GoogleFonts.lexend(fontSize: 20.sp,color: AppColors.libraryPriceColor,fontWeight: FontWeight.w600),)),

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp),
                  color: AppColors.primaryColor,child: listState['author_name']==null?Text("No Author name"): Text("${listState['author_name']}",style: GoogleFonts.lexend(fontSize: 15.sp,fontWeight: FontWeight.w500),),),
                Row(
                  children: [
                    Container(

                      color: AppColors.primaryColor,
                      child: Text("Contributors",style: GoogleFonts.lexend(fontSize: 15.sp,fontWeight: FontWeight.w500),),),
                    Expanded(

                      child: Container(
                        height: 20.sp,
                        width: 200.sp,
                        padding: EdgeInsets.symmetric(horizontal: 12.sp),
                        color: AppColors.primaryColor,child:  listState['contributors']==null?Text("No Contributors"):

                      ListView.separated(
                        scrollDirection: Axis.horizontal,
                       // shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index) {
                          return FittedBox(child: Text("${listState['contributors'][index]['name']==null?"C":listState['contributors'][index]['name']}",style: GoogleFonts.lexend(fontSize: 8.sp),));
                        }, separatorBuilder: (BuildContext context, int index) {return SizedBox(width: 2.sp,); }, itemCount: listState['contributors'].length,
                      ),),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp),
                  color: AppColors.primaryColor,child: Text("${(DateTime.now().year)}/${(DateTime.now().month)}/${(DateTime.now().day)}",style: GoogleFonts.lexend(fontSize: 15.sp,fontWeight: FontWeight.w500),),),
                SizedBox(height: 30.sp,),
                SingleChildScrollView(
                  child: Container(
                    height: 60.sp,
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    color: AppColors.primaryColor,child:listState['book_description']==null? Text("Books Description.."): Text("${listState['book_description']}",style: GoogleFonts.lexend(fontSize: 12.sp,fontWeight: FontWeight.w500),),),
                ),
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 12.sp),
                  height: 30.sp,
                  color: AppColors.primaryColor

                  ,child: Row(

                  children: <Widget>[
                    SizedBox(width: 4.sp,),
                    Expanded(
                      child: Container(height: 25.sp,width:90.sp,decoration:
                      BoxDecoration(color: AppColors.libraryBottomSheetButtonColor,borderRadius: BorderRadius.circular(5.sp),border:
                      Border.all(color: Colors.black,width: 2)),

                        child: Center(child: Text("ENGLISH",style: GoogleFonts.lexend(),),),
                      ),
                    ),
                    SizedBox(width: 8.sp,)
                    ,
                    Expanded(
                      child: Container(height: 25.sp,width:90.sp,decoration: BoxDecoration(color: AppColors.libraryBottomSheetButtonColor2,
                          borderRadius: BorderRadius.circular(5.sp),border: Border.all(color: Colors.black,width: 2)),
                          child:  Center(child: listState['pages_url']==null?Text("0 PAGES"):Text("${listState['pages_url'].length} PAGES",style: GoogleFonts.lexend(),),)
                      ),
                    )
                    ,SizedBox(width: 7.sp,)
                    ,
                    Expanded(
                      flex:2,
                      child: Container(height: 25.sp,width:92.sp,decoration: BoxDecoration(color: AppColors.libraryBottomSheetButtonColor2,
                          borderRadius: BorderRadius.circular(5.sp),border: Border.all(color: Colors.black,width: 2)),
                          child:  FittedBox(child: listState['likes']==null?Text(" 0 USER LIKED THIS "):Text(" ${listState['likes']} USER LIKED THIS ",style: GoogleFonts.lexend(),),)
                      ),

                    ),
                    SizedBox(width: 4.sp,),

                  ],
                ),)

              ],),
          ),
          Container(height: 10.sp,color: AppColors.primaryColor,),
          Container(
              color: AppColors.primaryColor,
              child: TouchableOpacity(child: reusableButtonLibrary(text: "Add To Cart"))),
          Container(height: 70.sp,color: Colors.transparent,),
         // Container(height: 5.sp,color: AppColors.primaryColor,),

        ]),
  );
}