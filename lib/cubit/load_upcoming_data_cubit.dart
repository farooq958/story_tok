import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:storily/model/event_flow_model.dart';

import '../repo/repo.dart';



class LoadUpcomingDataCubit extends Cubit<List<EventFlowModel>> {
  LoadUpcomingDataCubit() : super([]);

  getUpcomingEventData()
  async {
    var dataStatus =await Repository().getUpcomingEventsFromFirebase();
    if(dataStatus=="true")
      // Repository.eventListData.add(ef);
      //var dateToPass=DateTime(ef.eventDate.year, ef.eventDate.month, ef.eventDate.day);
      //Repository.eventMapOfData.addAll({dateToPass:[Repository.eventTitleController.text] });
        {
       print(Repository.eventListUpcomingData.length);

      //print("repo data${Repository.eventMapOfData}");
      emit(Repository.eventListUpcomingData);
    }
    else
    {
      print(dataStatus);
      //emit(dataStatus);
    }
  }
}
