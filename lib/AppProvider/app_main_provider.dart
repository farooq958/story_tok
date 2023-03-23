import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storily/cubit/event_from_time_cubit.dart';
import 'package:storily/cubit/load_main_data_cubit.dart';
import 'package:storily/cubit/load_recommended_events_cubit.dart';
import 'package:storily/cubit/selected_date_event_cubit.dart';

import '../cubit/event_to_time_cubit.dart';

///here add all your app_provider of bloc
final List<BlocProvider> appProvider=[

  //BlocProvider<TestCubit>(create: (context)=> TestCubit()),
  BlocProvider<SelectedDateEventCubit>(create: (context)=> SelectedDateEventCubit()),
  BlocProvider<EventFromTimeCubit>(create: (context)=> EventFromTimeCubit()),
  BlocProvider<EventToTimeCubit>(create: (context)=> EventToTimeCubit()),
  BlocProvider<LoadMainDataCubit>(create: (context)=>LoadMainDataCubit()),
  BlocProvider<LoadRecommendedEventsCubit>(create: (context)=>LoadRecommendedEventsCubit())

];