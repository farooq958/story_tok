import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repo/repo.dart';



class LibraryBooksThisMonthCubit extends Cubit<List> {
  LibraryBooksThisMonthCubit() : super([]);

  Future getLibraryThisMonthBooksData()
  async {
  //var t= Repository().getRecommendedBooksNotOwned();

    //print(test);
    var dataStatus =await Repository().getThisMonthBooksFromFirebase();

    if(dataStatus=="true")
      // Repository.eventListData.add(ef);
      //var dateToPass=DateTime(ef.eventDate.year, ef.eventDate.month, ef.eventDate.day);
      //Repository.eventMapOfData.addAll({dateToPass:[Repository.eventTitleController.text] });
        {
      //print(Repository.eventListUpcomingData.length);
      // await Future<void>.delayed(const Duration(milliseconds: 100));
      //print("repo data${Repository.eventMapOfData}");
      emit(List.of(Repository.libraryFinalBooks.toSet().toList().take(5)));
    }
    else if (dataStatus=="false")
    {
      //print(dataStatus);
      emit([]);
    }
    else
    {

      print(dataStatus);
    }
  }
}
