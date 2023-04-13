import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storily/Utils/app_colors.dart';
import 'package:storily/Utils/app_controller.dart';
import 'package:storily/Utils/app_utils.dart';
import 'package:storily/cubit/LibraryCubits/library_books_cubit.dart';
import 'package:storily/cubit/LibraryCubits/library_page_view_cubit.dart';
import 'package:storily/repo/repo.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../../Utils/Events/library_utils.dart';

class BooksLibrary extends StatelessWidget {
  const BooksLibrary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Repository().getLibraryBooksFromFirebase();
    return BlocConsumer<LibraryBooksCubit, List>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, listState) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 5.sp,
            ),
            SizedBox(
              height: 50.sp,
              child: Row(
                children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: listState.isEmpty
                        ? SizedBox()
                        : Container(
                            color: AppColors.primaryColor,
                            // margin: EdgeInsets.only(right: 5.sp),
                            child: Image.asset(
                              "assets/images/kidslibrary_purple_mybooks.png",
                              fit: BoxFit.fitHeight,
                              height: 20.sp,
                            )),
                  )),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerRight,
                    child: Stack(
                      children: [
                        Container(
                          height: 30.sp,
                          width: 120.sp,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(20.sp)),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Container(

                                  )),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.libraryMainColor,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.sp),
                                        bottomRight: Radius.circular(20.sp))),
                                child: Center(
                                    child: Image.asset(
                                  "assets/images/arrowdropdown-removebg-preview.png",
                                  height: 20.sp,
                                )),
                              )),
                            ],
                          ),
                          // margin: EdgeInsets.only(right: 5.sp),
                        ),

                        Positioned(
                            top: 5.sp,
                            bottom: 0,
                            left: 5.sp,
                            child: CustomDropDownLibrary())
                      ],
                    ),
                  ))
                ],
              ),
            ),
            listState.isEmpty
                ? Stack(
                    children: [
                      Center(
                          child: Image.asset(
                        "assets/images/kidslibrary_purple_shelfempty.png",
                        height: 300.sp,
                        width: 300.sp,
                      )),
                      Positioned(
                          top: 5.sp,
                          right: 50.sp,
                          child: TouchableOpacity(
                              onTap: () {
                                print("plus tap");
                                AppControllers.libraryPageController
                                    .jumpToPage(1);
                                context
                                    .read<LibraryPageViewCubit>()
                                    .setPageIndex(1);
                              },
                              child: Container(
                                height: 50.sp,
                                width: 100.sp,
                                color: Colors.transparent,
                              )))
                    ],
                  )
                : GridView.builder(
              shrinkWrap: true,
                    itemCount: listState.length+1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.0, // add vertical spacing between items
                      crossAxisSpacing: 10.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                print(index);
                      if (index >= listState.length) {
                        return TouchableOpacity(
                          onTap: (){

                            AppControllers.libraryPageController
                                .jumpToPage(1);
                            context
                                .read<LibraryPageViewCubit>()
                                .setPageIndex(1);
                          },
                          child: Container(child: Image.asset(
                            "assets/images/kidslibrary_purple_shelfbox.png",
                            fit: BoxFit.fitHeight,)),
                        );
                      }
                      else if (index<listState.length) {
                        print(index);
                        return TouchableOpacity(
                          onTap: (){
                          showCustomBottomSheet(context,listState[index]);
                            print("will show bottom sheet");
                          },
                          child: Container(
                            child: Image.network(
                             index<listState.length? listState[index]['cover_url']:"https://picsum.photos/id/$index/300/300",
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                      else
                        {
                          return SizedBox();
                        }

                    }),
            SizedBox(
              height: 10.sp,
            ),
            listState.isEmpty
                ? TouchableOpacity(
                    onTap: () {
                      AppControllers.libraryPageController.jumpToPage(1);
                      context.read<LibraryPageViewCubit>().setPageIndex(1);
                    },
                    child: reusableButtonLibrary(text: "DISCOVER MORE"),
                  )
                : SizedBox()
          ],
        );
      },
    );
  }
}

