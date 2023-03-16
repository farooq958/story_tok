import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';



class SelectedDateEventCubit extends Cubit<DateTime> {
  SelectedDateEventCubit() : super(DateTime.now());

  setDate(selectedDate)
  {

    emit(selectedDate);
  }

}
