import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';



class EventFromTimeCubit extends Cubit<String> {
  EventFromTimeCubit() : super("");
  setTime(fromTime)
  {
    emit(fromTime);
  }
}
