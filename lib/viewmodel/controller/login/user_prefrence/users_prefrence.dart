import 'package:getxmvvm/model/login/User_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersPrefrence {

  // Save user token in shhared prefrences
  Future<bool> saveUser(UserModel userModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', userModel.token.toString());
    return true;
  }
  //get user token and store in shared prefrences
  Future<UserModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token= sp.getString('token');
    return UserModel(
      token: token,
    );
  }

  // Logout User and remove token from shared prefrences
   Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }
}
