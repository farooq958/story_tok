import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:storily/model/event_flow_model.dart';
import 'package:storily/repo/repo.dart';



class LoadMainDataCubit extends Cubit<List<EventFlowModel>> {
  LoadMainDataCubit() : super([]);

  getEventData(EventFlowModel ef)
  {
    if(ef.eventTitle!=""){
   Repository.eventListData.add(ef);
   var dateToPass=DateTime(ef.eventDate.year, ef.eventDate.month, ef.eventDate.day);
   Repository.eventMapOfData.addAll({dateToPass:[Repository.eventTitleController.text] });

    }
    //print("repo data${Repository.eventMapOfData}");
    emit(Repository.eventListData);

  }
}
