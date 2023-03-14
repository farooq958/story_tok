import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storily/cubit/test_cubit.dart';
///here add all your app_provider of bloc
final List<BlocProvider> appProvider=[

  BlocProvider<TestCubit>(create: (context)=> TestCubit()),


];