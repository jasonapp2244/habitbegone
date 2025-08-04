abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPutApiResponse(
    String url,
    String body, {
    Map<String, String>? headers,
  });
  Future<dynamic> getPostApiResponse(
    String url,
    dynamic data,Map<String,String> header, );
  Future<dynamic> getDeleteApiResponse(String url);
}
