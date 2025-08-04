import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getxmvvm/resources/colors/app_colors.dart';

class Utils {
  static void fieldFoucsChnage(
    BuildContext context,
    FocusNode current,
    FocusNode nextfoucs,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextfoucs);
  }

  static toastMassage(String meassage) {
    Fluttertoast.showToast(
      msg: meassage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.secconderyColor,
      fontSize: 16.0,
    );
  }
  static toastMassageCenter(String meassage) {
    Fluttertoast.showToast(
      // webBgColor: [AppColors.primaryColor,AppColors.secconderyColor],
      msg: meassage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.secconderyColor,
      fontSize: 16.0,
    );
  }

  static snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.secconderyColor,
      colorText: AppColors.primaryColor,
      icon:const Icon(
        Icons.warning_amber_rounded,color:AppColors.primaryColor,
        size:30,

      )
    );
  }
}
