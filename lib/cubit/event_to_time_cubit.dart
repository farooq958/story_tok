import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';



class EventToTimeCubit extends Cubit<String> {
  EventToTimeCubit() : super("");
  setTime(toTime)
  {
    emit(toTime);
  }
}
