import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:storily/repo/repo.dart';



class LibraryBooksCubit extends Cubit<List> {
  LibraryBooksCubit() : super([]);
  getLibraryBooksData()
  async {

    //print(test);
    var dataStatus =await Repository().getLibraryBooksFromFirebase();

    if(dataStatus=="true")
      // Repository.eventListData.add(ef);
      //var dateToPass=DateTime(ef.eventDate.year, ef.eventDate.month, ef.eventDate.day);
      //Repository.eventMapOfData.addAll({dateToPass:[Repository.eventTitleController.text] });
        {
      //print(Repository.eventListUpcomingData.length);
      // await Future<void>.delayed(const Duration(milliseconds: 100));
      //print("repo data${Repository.eventMapOfData}");
      emit(List.of(Repository.libraryListBooksDetails));
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
