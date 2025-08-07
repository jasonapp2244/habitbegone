import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitsbegone/resources/getx_localization/language.dart';
import 'package:habitsbegone/resources/routes/routes.dart';

import 'package:habitsbegone/view/splash_view.dart';

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
      home: SplashView(),
      getPages: AppRoutes.appRoutes(),
    );
  }
}
