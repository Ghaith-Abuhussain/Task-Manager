import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managing/domain/models/local/remember_me_user.dart';
import 'package:task_managing/presentation/views/home_screen.dart';
import 'package:task_managing/presentation/views/login_signup_screen.dart';
import 'package:task_managing/utils/constants/strings.dart';

import 'config/builders/app_builder.dart';
import 'config/providers/bloc_providers.dart';
import 'config/router/router.dart';
import 'config/themes/app_themes.dart';
import 'data/datasources/local/app_database.dart';
import 'data/repositories/database/database_repository_impl.dart';
import 'locator.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  DatabaseRepositoryImpl databaseRepository = DatabaseRepositoryImpl(locator.get<AppDatabase>());
  SharedPreferences prefs = locator.get<SharedPreferences>();
  RememberMeUser? user = await databaseRepository.getRememberedUser();
  if(user == null) {
    prefs.setString(initialRoot_name, "/");
  } else {
    if(user.isLoggedIn){
      prefs.setString(initialRoot_name, HomeScreen.routeName);
    } else {
      prefs.setString(initialRoot_name, "/");
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs = locator.get<SharedPreferences>();

    return MultiBlocProvider(
      providers: getProviders(context, locator),
      child: OKToast(
        child: MaterialApp(
          title: 'Tour',
          theme: AppTheme.light,
          initialRoute: prefs.getString(initialRoot_name),
          routes: {
            '/': (context) => const LoginSignUpScreen(),
            HomeScreen.routeName : (context) => HomeScreen(),
          },
          onGenerateRoute: (settings) => GeneratedRoutes(settings, context),
          builder: smartDialogBuilder(),
        ),
      ),
    );
  }
}