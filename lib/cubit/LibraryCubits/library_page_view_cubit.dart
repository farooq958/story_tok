import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class LibraryPageViewCubit extends Cubit<int> {
  LibraryPageViewCubit() : super(0);

  setPageIndex(pageNo){

    emit(pageNo);
  }

}
