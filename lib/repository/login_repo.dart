import 'package:getxmvvm/data/appURL/app_url.dart';
import 'package:getxmvvm/data/network/network_api_services.dart';

class LoginRepo {
  final _apiServices = NetworkApiServices();
  Future<dynamic> LoginApi(dynamic data) async {
    dynamic response = await _apiServices.getPostApiResponse(
      AppUrl.login,
      data, {
      "x-api-key": "reqres-free-v1",
      "Content-Type": "application/json",
    }

    );

Map<String,String>;
    // .getPostApiResponse(AppUrl.login, data,
    // header:{"x-api-key: reqres-free-v1"});
    return response;
  }
}
