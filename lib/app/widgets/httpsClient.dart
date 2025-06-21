import 'package:dio/dio.dart';

class HttpsClient {
  //静态属性共享存储空间
  static String domain = "https://miapp.itying.com/";
  static Dio dio = Dio();

  HttpsClient() {
    dio.options.baseUrl = domain; // 设置请求的域名
    dio.options.connectTimeout = const Duration(
      milliseconds: 5000,
    ); // 连接超时时间（5秒）
    dio.options.receiveTimeout = const Duration(
      milliseconds: 3000,
    ); // 响应超时时间（3秒）
  }

  Future get(apiUrl) async {
    try {
      var response = await dio.get(apiUrl);
      return response;
    } catch (e) {
      print("请求超时");
      return null;
    }
  }

  Future post(String apiUrl, {Map? data}) async {
    try {
      var response = await dio.post(apiUrl, data: data);
      return response;
    } catch (e) {
      print("请求超时");
      return null;
    }
  }

  // 显式声明返回类型为 String
  static String replaceUri(String picUrl) {
    String tempUrl = domain + picUrl;
    return tempUrl.replaceAll("\\", '/');
  }
}
