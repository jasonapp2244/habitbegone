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

  // Check if this is the first time the app is launched
  Future<bool> isFirstLaunch() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool? isFirst = sp.getBool('isFirstLaunch');
    return isFirst ?? true; // If null, it means first launch
  }

  // Mark that the app has been launched before
  Future<bool> setFirstLaunchComplete() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setBool('isFirstLaunch', false);
  }

  // Reset first launch flag (for testing purposes)
  Future<bool> resetFirstLaunch() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.remove('isFirstLaunch');
  }
}
