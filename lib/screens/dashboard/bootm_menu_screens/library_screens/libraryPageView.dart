import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:storily/Utils/app_colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../../Utils/app_controller.dart';
import '../../../../cubit/LibraryCubits/library_page_view_cubit.dart';
import '../../../../repo/repo.dart';
import 'discovery_tab.dart';
import 'library_books.dart';
import 'package:storily/cubit/LibraryCubits/library_books_this_month_cubit.dart';
import 'package:storily/cubit/LibraryCubits/library_featured_authors_cubit.dart';
import 'package:storily/cubit/LibraryCubits/library_not_owned_books_cubit.dart';
import 'package:storily/Utils/process_indicator.dart';
import 'package:storily/cubit/LibraryCubits/library_books_cubit.dart';

class LibraryPageView extends StatefulWidget {
  const LibraryPageView({Key? key}) : super(key: key);

  @override
  _LibraryPageView createState() => _LibraryPageView();
}

class _LibraryPageView extends State<LibraryPageView> {
  @override
  void initState() {
    super.initState();
  }

  Future gotoLib() async {
    Circle().show(context);
    await context.read<LibraryBooksCubit>().getLibraryBooksData();
    await context
        .read<LibraryBooksThisMonthCubit>()
        .getLibraryThisMonthBooksData();
    await context
        .read<LibraryFeaturedAuthorsCubit>()
        .getLibraryFeaturedAuthors();
    await context.read<LibraryNotOwnedBooksCubit>().getLibraryNotOwnedBooks();
    await Repository().getCategories();
    Circle().hide(context);
    //goPage(context, LibraryPageView());
    //LibraryPageView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<LibraryPageViewCubit>().setPageIndex(0);
        return true;
      },
      child: Scaffold(
        extendBody: true,
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
                  bottom: 1.sh / 3.5.sp,
                  top: 1.sh / 2.8,
                  child: SizedBox(
                      height: 20.sp,
                      child: Image.asset(
                          "assets/images/background_rectangledots.png"))),
              Positioned(
                  // left: 20.sp,
                  top: 70.sp,
                  right: 0,
                  child: Image.asset(
                    "assets/images/background_circledots.png",
                    width: 115.sp,
                    height: 150.sp,
                  )),
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
                top: 40.sp, // distance from the bottom
                right: 10.sp, // distance from the right
                child: Image.asset(
                  'assets/images/kidslibrary_purple_fullcart.png',
                  width: 30.sp, // specify the width of the image
                  height: 30.sp, // specify the height of the image
                ),
              ),
              Container(
                height: 1.sh,
                width: 1.sw,
                child: Column(
                  //shrinkWrap: true,
                  //padding:  EdgeInsets.symmetric(horizontal: 20.sp)
                  children: [
//SizedBox(height: 35.sp,),
                    ///Top Design

                    SizedBox(
                      height: 25.sp,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.sw / 7.5),
                      color: AppColors.primaryColor,
                      child: Center(
                          child: Text(
                        "    MY\nLIBRARY",
                        style: GoogleFonts.lexend(
                            fontSize: 50.sp, fontWeight: FontWeight.w700),
                      )),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    BlocConsumer<LibraryPageViewCubit, int>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, pageIndex) {
                        return Container(
                          height: 40.sp,
                          margin: EdgeInsets.symmetric(horizontal: 20.sp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.sp),
                              border:
                                  Border.all(width: 2.0, color: Colors.black)),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Align(
                                    child: TouchableOpacity(
                                      onTap: () {
                                        if (pageIndex != 0) {
                                          AppControllers.libraryPageController
                                              .jumpToPage(0);
                                          context
                                              .read<LibraryPageViewCubit>()
                                              .setPageIndex(0);
                                        }
                                      },
                                      child: Container(
                                          height: 35.sp,
                                          width: 80.sp,
                                          margin: EdgeInsets.only(
                                              top: 2.sp, bottom: 2.sp),
                                          decoration: BoxDecoration(
                                              color: pageIndex == 0
                                                  ? AppColors.libraryMainColor
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(20.sp),
                                              border: Border.all(
                                                  color: pageIndex == 0
                                                      ? Colors.black
                                                      : Colors.transparent,
                                                  width: 2.0)),
                                          child: Center(
                                              child: Text(
                                            "BOOKS",
                                            style: GoogleFonts.lexend(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp),
                                          ))),
                                    ),
                                  )),
                              Spacer(),
                              Expanded(
                                  flex: 2,
                                  child: Align(
                                      child: TouchableOpacity(
                                    onTap: () {
                                      if (pageIndex != 1) {
                                        AppControllers.libraryPageController
                                            .jumpToPage(1);
                                        context
                                            .read<LibraryPageViewCubit>()
                                            .setPageIndex(1);
                                      }
                                    },
                                    child: Container(
                                        height: 35.sp,
                                        width: 120.sp,
                                        margin: EdgeInsets.only(
                                            top: 2.sp, bottom: 2.sp),
                                        decoration: BoxDecoration(
                                            color: pageIndex == 1
                                                ? AppColors.libraryMainColor
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(20.sp),
                                            border: Border.all(
                                                color: pageIndex == 1
                                                    ? Colors.black
                                                    : Colors.transparent,
                                                width: 2.0)),
                                        child: Center(
                                            child: FittedBox(
                                                child: Text("DISCOVER",
                                                    style: GoogleFonts.lexend(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15.sp))))),
                                  ))),
                              Spacer(),
                            ],
                          ),
                        );
                      },
                    ),

                    SizedBox(
                      height: 5.sp,
                    ),
                    Expanded(
                        child: FutureBuilder<void>(
                            future: Future.wait([
                              context
                                  .read<LibraryBooksCubit>()
                                  .getLibraryBooksData(),
                              context
                                  .read<LibraryBooksThisMonthCubit>()
                                  .getLibraryThisMonthBooksData(),
                              context
                                  .read<LibraryFeaturedAuthorsCubit>()
                                  .getLibraryFeaturedAuthors(),
                              context
                                  .read<LibraryNotOwnedBooksCubit>()
                                  .getLibraryNotOwnedBooks(),
                              Repository().getCategories()
                            ]),
                            builder: (BuildContext context,
                                AsyncSnapshot<void> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                //Circle().show(context);
                                return Text('Waiting...');
                              } else {
                                if (snapshot.hasError) {
                                  //Circle().hide(context);
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else {
                                  //Circle().hide(context);
                                  return PageView(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    controller:
                                        AppControllers.libraryPageController,
                                    onPageChanged: (x) {
                                      AppControllers.libraryPageController
                                          .jumpToPage(x);
                                      context
                                          .read<LibraryPageViewCubit>()
                                          .setPageIndex(x);
                                    },
                                    children: [BooksLibrary(), DiscoveryTab()],
                                  );
                                }
                              }
                            }))
                  ],
                ),
              ),
              //SizedBox(height: 80.sp,),
            ],
          ),
        ),
      ),
    );
  }
}
