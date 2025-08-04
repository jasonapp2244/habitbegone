import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getxmvvm/resources/routes/routes_name.dart';
import 'package:getxmvvm/viewmodel/controller/login/user_prefrence/users_prefrence.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UsersPrefrence usersPrefrence = UsersPrefrence();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME VIEW"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              usersPrefrence.removeUser().then((value) {
                Get.toNamed(RoutesName.loginview);
              }
              );
            },
          ),
        ],
      ),
    );
  }
}
