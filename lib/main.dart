import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmvvm/resources/getx_localization/language.dart';
import 'package:getxmvvm/resources/routes/routes.dart';
import 'package:getxmvvm/view/auth_mannger_view.dart';
import 'package:getxmvvm/view/home_view.dart';
import 'package:getxmvvm/view/login_view.dart';
import 'package:getxmvvm/view/oboranding_view.dart';
import 'package:getxmvvm/view/onborading_view2.dart';
import 'package:getxmvvm/view/onborading_view3.dart';
import 'package:getxmvvm/view/sign_up_view.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations:Language(),
      ///urdu language
      // locale: Locale('ur','PK'),
      locale: Locale('en','US'),
      fallbackLocale: Locale('en','US'),
      home: HomeView(),
      getPages: 
      AppRoutes.appRoutes()

      ,
    );
  }
}
