import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmvvm/resources/colors/app_colors.dart';
import 'package:getxmvvm/widgets/round_button.dart';
import 'package:getxmvvm/utils/utils.dart';
import 'package:getxmvvm/viewmodel/controller/login/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginVM = Get.put(LoginViewmodel());
  final _formkey = GlobalKey<FormState>();

  final height = Get.height;
  final width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login".tr)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              //Email feild
              TextFormField(
                controller: loginVM.emailController.value,
                focusNode: loginVM.emailFocusNode.value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return Utils.toastMassage("email_required".tr);
                  } else {
                    return null;
                  }
                },
                onFieldSubmitted: (value) {
                  Utils.fieldFoucsChnage(
                    context,
                    loginVM.emailFocusNode.value,
                    loginVM.passwordFocusNode.value,
                  );
                },
                decoration: InputDecoration(
                  hintText: "email".tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
              ),

              SizedBox(height: height * 0.025),

              //password feild
              TextFormField(
                controller: loginVM.passwordController.value,
                focusNode: loginVM.passwordFocusNode.value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return Utils.toastMassage("password_required".tr);
                  } else if (value.length < 6) {
                    return Utils.toastMassage("password_lenght".tr);
                  }
                  return null;
                },
                obscureText: true,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  hintText: "password".tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
              ),
              SizedBox(height: height * 0.025),

              // login button
              Obx(
                () => RoundButton(
                  backgroundcolor: AppColors.primaryColor,
                  onpress: () {
                    if (_formkey.currentState!.validate()) {
                      loginVM.loginApi();
                    }
                  },
                  textcolor: AppColors.secconderyColor,
                  isloading: loginVM.loading.value,
                  title: "login".tr,
                  height: height * 0.05,
                  width: width * 0.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
