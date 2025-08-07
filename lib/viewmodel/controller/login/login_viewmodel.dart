import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:habitsbegone/model/login/User_model.dart';
import 'package:habitsbegone/repository/login_repo.dart';
import 'package:habitsbegone/resources/routes/routes_name.dart';
import 'package:habitsbegone/utils/utils.dart';
import 'package:habitsbegone/viewmodel/controller/login/user_prefrence/users_prefrence.dart';

class LoginViewmodel extends GetxController {
  UsersPrefrence usersPrefrence = UsersPrefrence();
  final _api = LoginRepo();
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool loading = true.obs;

  void loginApi() {
    loading.value = false;
    Map data = {
      'email': emailController.value.text,
      'password': emailController.value.text,
    };

    _api.LoginApi(data)
        .then((value) {
          loading.value = false;
          usersPrefrence
              .saveUser(UserModel.fromJson(value))
              .then((value) {
                Get.toNamed(RoutesName.homeview);
              })
              .onError((error, stackTrace) {
                if (kDebugMode) {
                  print(error.toString());
                }
              });
          Utils.toastMassage("Login Successfully");
        })
        .onError((error, stackTrace) {
          loading.value = false;

          Utils.toastMassage(error.toString());
        });
  }
}
