import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitsbegone/resources/getx_localization/language.dart';
import 'package:habitsbegone/resources/routes/routes.dart';
import 'package:habitsbegone/view/chose_plan_view.dart';
import 'package:habitsbegone/view/collective_program_view.dart';
import 'package:habitsbegone/view/cousre_view.dart';
import 'package:habitsbegone/view/home_view.dart';
import 'package:habitsbegone/view/me_myself_Program_view.dart';
import 'package:habitsbegone/view/one_on_one_view.dart';
import 'package:habitsbegone/view/osteopathy_view.dart';
import 'package:habitsbegone/view/profile_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Language(),

      ///urdu language
      // locale: Locale('ur','PK'),
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      // home: HomeView(),
      getPages: AppRoutes.appRoutes(),
    );
  }
}
