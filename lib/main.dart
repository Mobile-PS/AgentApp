import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ticket_agent/data/repos/LoginRepository.dart';
import 'package:ticket_agent/presentation/screen/home_page.dart';
import 'package:ticket_agent/presentation/screen/login_page.dart';
import 'package:ticket_agent/utils/app_translations.dart';
import 'package:ticket_agent/utils/shared_pref_utils.dart';

import 'data/repos/BusRouteRepository.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
        translations: AppTranslations(),
        locale:   Locale('en', 'US'),
        fallbackLocale:  Locale('en', 'US') ,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Colors.black.withOpacity(0)),
      ),
      // home: RepositoryProvider(
      //   create: (context) => LoginRepository(),
      //   child: LoginPage(),
      // ),
      home:  MultiRepositoryProvider(
          providers: [
            RepositoryProvider( create: (context) => BusRouteRepository())
          ],
          child: SharedPrefUtils.getLoginedInUser()!=null?HomePage():LoginPage())
    );
  }
}
