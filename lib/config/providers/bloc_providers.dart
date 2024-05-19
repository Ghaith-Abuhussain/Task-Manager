import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nested/nested.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managing/data/datasources/remote/api/task_manager_api_service.dart';
import 'package:task_managing/presentation/blocs/home/home_bloc.dart';
import '../../data/datasources/local/app_database.dart';
import '../../data/repositories/remote/get_info_repository_impl.dart';
import '../../presentation/blocs/login/login_bloc.dart';
import '../../data/repositories/database/database_repository_impl.dart';
import '../../data/repositories/remote/login_repository_impl.dart';

List<SingleChildWidget> getProviders(BuildContext context, GetIt locator) {
  AppDatabase appDatabase = locator.get<AppDatabase>();
  Dio dio = locator.get<Dio>();
  SharedPreferences prefs = locator.get<SharedPreferences>();

  return [
    BlocProvider(
      create: (context) => LoginBloc(
          DatabaseRepositoryImpl(appDatabase),
          LoginRepositoryImpl(TaskManagerApiService(dio)),
          prefs,
          GetInfoRepositoryImpl(TaskManagerApiService(dio))),
    ),
    BlocProvider(
      create: (context) => HomeBloc(DatabaseRepositoryImpl(appDatabase), prefs,
          GetInfoRepositoryImpl(TaskManagerApiService(dio))),
    )
  ];
}
