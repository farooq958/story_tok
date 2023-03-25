import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:storily/model/event_flow_model.dart';
import 'package:storily/repo/repo.dart';



class LoadRecommendedEventsCubit extends Cubit<List<EventFlowModel>> {
  LoadRecommendedEventsCubit() : super([]);

  getRecommendedEventData({required int readingLevel})
  async {
    var dataStatus =await Repository().getRecommendedEventsFromFirebase(readingLevel);
    if(dataStatus=="true")
      {
      print("heree");
      print(Repository.recommendedEventListData.length);
      // Repository.eventListData.add(ef);
      //var dateToPass=DateTime(ef.eventDate.year, ef.eventDate.month, ef.eventDate.day);
      //Repository.eventMapOfData.addAll({dateToPass:[Repository.eventTitleController.text] });
     // await Future<void>.delayed(const Duration(milliseconds: 100));
      // print(Repository.eventListData.length);
     // Repository().getEventsTypeFromFirebase();
      //print("repo data${Repository.eventMapOfData}");
      emit(List.of(Repository.recommendedEventListData));
    }
    else
    {
      print(dataStatus);
      //emit(dataStatus);
    }
  }
}
